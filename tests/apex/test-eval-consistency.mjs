import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { execFileSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const readJson = (relative) => JSON.parse(fs.readFileSync(path.join(root, relative), 'utf8'));
const sameSet = (actual, expected) => JSON.stringify([...actual].sort()) === JSON.stringify([...expected].sort());
const exactSet = (actual, expected) => assert.ok(sameSet(actual, expected), `expected ${JSON.stringify(expected)}, got ${JSON.stringify(actual)}`);
const assertCompleteIds = (results, count, label) => {
  assert.deepEqual(results.map((item) => item.id).sort((a, b) => a - b), Array.from({ length: count }, (_, index) => index + 1), `${label} has each id exactly once`);
};
const indexById = (items) => new Map(items.map((item) => [item.id, item]));
const readAtCommit = (commit, relative) => execFileSync('git', ['show', `${commit}:${relative}`], { cwd: root, encoding: 'utf8' });
const normalizeDescriptionSnapshot = (snapshot) => Array.isArray(snapshot)
  ? snapshot
  : Object.entries(snapshot).map(([name, description]) => ({ name, description }));

const evals = readJson('evals/evals.json');
assert.equal(evals.skill_name, 'using-apex');
assert.ok(evals.evals.length >= 11);
for (const item of evals.evals) {
  assert.ok(Number.isInteger(item.id), `eval id is integer: ${item.id}`);
  assert.ok(item.prompt.startsWith('Routing-only'), `eval ${item.id} declares routing-only scope`);
  assert.ok(Array.isArray(item.expectations) && item.expectations.length > 0, `eval ${item.id} has official-schema expectations`);
  assert.ok(!('assertions' in item), `eval ${item.id} does not use a custom assertions dialect`);
  assert.ok(!/performs the bounded edit/i.test(item.expected_output), `eval ${item.id} does not claim unexecuted edits`);
}
assertCompleteIds(evals.evals, evals.evals.length, 'source evals');

const routes = readJson('evals/routing-evals.json');
const expectedNames = new Set(routes.flatMap((item) => item.expected_skills));
const skillNames = [
  'using-apex',
  'governing-project-work',
  'shaping-solutions',
  'managing-git',
  'coordinating-subagents',
  'debugging-systematically',
  'testing-changes',
];
const assertDescriptionSet = (items, label) => {
  assert.equal(items.length, skillNames.length, `${label} snapshots seven descriptions`);
  assert.deepEqual([...new Set(items.map((item) => item.name))].sort(), [...skillNames].sort(), `${label} covers each skill exactly once`);
};
for (const name of skillNames) {
  assert.ok(expectedNames.has(name), `routing set covers ${name}`);
}
assert.ok(routes.some((item) => item.expected_skills.length === 0), 'routing set includes no-skill near misses');
assert.ok(routes.some((item) => item.expected_skills.length > 1), 'routing set includes multi-skill composition');

for (const iteration of [9, 11]) {
  const summary = readJson(`evals/results/iteration-${iteration}/single-run-summary.json`);
  assert.equal(summary.metadata.runs_per_configuration, 1, `iteration ${iteration} is single-run`);
  assert.equal(summary.metadata.timing_available, false, `iteration ${iteration} does not claim timing`);
  assert.equal(summary.metadata.token_metrics_available, false, `iteration ${iteration} does not claim tokens`);
  assert.equal(summary.metadata.skill_loading_verified, false, `iteration ${iteration} does not claim audited skill loading`);
  assert.equal(summary.run_summary.delta.definition, 'with_skill - without_skill');
  assert.ok(summary.runs.every((run) => ['with_skill', 'without_skill'].includes(run.configuration)), `iteration ${iteration} uses consistent comparison names`);
  assert.ok(!fs.existsSync(path.join(root, `evals/results/iteration-${iteration}/benchmark.json`)), `iteration ${iteration} does not claim an official benchmark artifact`);
}

for (const scenario of ['debugging', 'tdd', 'docs', 'git', 'review']) {
  const metadata = readJson(`evals/results/iteration-9/eval-${scenario}/eval_metadata.json`);
  assert.ok(typeof metadata.prompt === 'string' && metadata.prompt.length > 0, `${scenario} metadata retains prompt`);
}

assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/eval-git/with_skill/run-1/outputs/evidence.json')), 'execution machine evidence is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/eval-review/with_skill/run-1/outputs/report.md')), 'subagent controller report is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-11/eval-11-current-migration/with_skill/run-1/outputs/response.md')), 'current migration response is retained in viewer-compatible layout');

const blindQueries = readJson('evals/results/iteration-10/queries-only.json');
assertCompleteIds(blindQueries, blindQueries.length, 'iteration 10 queries');
const routeById = indexById(routes.map((item, index) => ({ id: index + 1, ...item })));
for (const item of blindQueries) assert.equal(item.query, routeById.get(item.id).query, `iteration 10 query ${item.id} matches its route`);
const originalBlindGrade = readJson('evals/results/iteration-10/trigger-grading.json');
const revisedBlindGrade = readJson('evals/results/iteration-10/trigger-grading-revised.json');
const originalBlindTruth = indexById(originalBlindGrade.per_query);
const revisedBlindTruth = indexById(revisedBlindGrade.per_query);
let originalBlindPasses = 0;
let revisedBlindPasses = 0;
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-10/run-${run}-selections.json`);
  assert.equal(selections.source_commit, '95e3f936c5b507e98765af286e1fce75145b4e5b');
  assert.equal(selections.results.length, blindQueries.length, `iteration 10 blind run ${run} covers its query snapshot`);
  assertCompleteIds(selections.results, blindQueries.length, `iteration 10 run ${run}`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `blind run ${run} contains no labels or self-grades`);
  const descriptionSnapshot = normalizeDescriptionSnapshot(selections.description_snapshot);
  assertDescriptionSet(descriptionSnapshot, `iteration 10 run ${run}`);
  for (const item of descriptionSnapshot) {
    const skill = readAtCommit(selections.source_commit, `skills/${item.name}/SKILL.md`);
    const match = skill.match(/^description:\s*(.+)$/m);
    assert.equal(item.description, match?.[1], `iteration 10 run ${run} preserves historical ${item.name} description`);
  }
  let originalRunPasses = 0;
  let revisedRunPasses = 0;
  for (const item of selections.results) {
    const runKey = `run_${run}`;
    exactSet(item.selected_skills, originalBlindTruth.get(item.id).selections[runKey]);
    exactSet(item.selected_skills, revisedBlindTruth.get(item.id).selections[runKey]);
    if (sameSet(item.selected_skills, originalBlindTruth.get(item.id).expected_skills)) originalRunPasses += 1;
    if (sameSet(item.selected_skills, revisedBlindTruth.get(item.id).expected_skills)) revisedRunPasses += 1;
  }
  originalBlindPasses += originalRunPasses;
  revisedBlindPasses += revisedRunPasses;
  assert.deepEqual(originalBlindGrade.per_run[run - 1], { run, total: blindQueries.length, passed: originalRunPasses, failed: blindQueries.length - originalRunPasses, pass_rate: originalRunPasses / blindQueries.length });
  assert.deepEqual(revisedBlindGrade.per_run[run - 1], { run, total: blindQueries.length, passed: revisedRunPasses, failed: blindQueries.length - revisedRunPasses, pass_rate: revisedRunPasses / blindQueries.length });
}
assert.deepEqual(originalBlindGrade.aggregate, { total: 66, passed: originalBlindPasses, failed: 66 - originalBlindPasses, pass_rate: originalBlindPasses / 66 });
assert.deepEqual(revisedBlindGrade.aggregate, { total: 66, passed: revisedBlindPasses, failed: 66 - revisedBlindPasses, pass_rate: revisedBlindPasses / 66 });
assert.ok(revisedBlindGrade.ground_truth_revision, 'blind grading records the query-13 ground-truth revision');

const currentQueries = readJson('evals/results/iteration-12/queries-only.json');
assertCompleteIds(currentQueries, currentQueries.length, 'iteration 12 queries');
for (const item of currentQueries) assert.equal(item.query, routeById.get(item.id).query, `iteration 12 query ${item.id} matches its route`);
const currentDescriptions = readJson('evals/results/iteration-12/descriptions-only.json');
assertDescriptionSet(currentDescriptions, 'iteration 12 descriptions');
for (const item of currentDescriptions) {
  const skill = readAtCommit('a473d6f8817995117ebecda7745ee77dc6cb380b', `skills/${item.name}/SKILL.md`);
  const match = skill.match(/^description:\s*(.+)$/m);
  assert.equal(item.description, match?.[1], `iteration 12 snapshots current ${item.name} description`);
}
let currentPasses = 0;
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-12/run-${run}-selections.json`);
  assert.equal(selections.source_commit, 'a473d6f8817995117ebecda7745ee77dc6cb380b');
  assert.equal(selections.results.length, currentQueries.length, `iteration 12 run ${run} covers every snapshotted query`);
  assertCompleteIds(selections.results, currentQueries.length, `iteration 12 run ${run}`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `current blind run ${run} contains no labels or self-grades`);
  for (const item of selections.results) {
    exactSet(item.selected_skills, routeById.get(item.id).expected_skills);
    currentPasses += 1;
  }
}
const currentGrade = readJson('evals/results/iteration-12/trigger-grading.json');
assert.deepEqual(currentGrade.aggregate, { passed: currentPasses, total: currentQueries.length * 3 });
assert.deepEqual(currentGrade.per_run, [1, 2, 3].map((run) => ({ run, passed: currentQueries.length, total: currentQueries.length, mismatches: [] })));

const compositionQueries = readJson('evals/results/iteration-13/queries-only.json');
assertCompleteIds(compositionQueries, compositionQueries.length, 'iteration 13 queries');
const compositionRouteById = indexById(compositionQueries.map((item) => {
  const route = routes.find((candidate) => candidate.query === item.query);
  assert.ok(route, `iteration 13 query ${item.id} has a current route`);
  return { id: item.id, ...route };
}));
for (const item of compositionQueries) assert.equal(item.query, compositionRouteById.get(item.id).query, `iteration 13 query ${item.id} matches its route`);
const compositionDescriptions = readJson('evals/results/iteration-13/descriptions-only.json');
assertDescriptionSet(compositionDescriptions, 'iteration 13 descriptions');
for (const item of compositionDescriptions) {
  const skill = readAtCommit('4534a92085468ce390707815ad48eb548b88cb96', `skills/${item.name}/SKILL.md`);
  const match = skill.match(/^description:\s*(.+)$/m);
  assert.equal(item.description, match?.[1], `iteration 13 snapshots current ${item.name} description`);
}
const originalCompositionTruth = readJson('evals/results/iteration-13/ground-truth-original.json');
assertCompleteIds(originalCompositionTruth, compositionQueries.length, 'iteration 13 original ground truth');
const originalCompositionById = indexById(originalCompositionTruth);
let revisedPasses = 0;
let originalPasses = 0;
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-13/run-${run}-selections.json`);
  assert.equal(selections.source_commit, '4534a92085468ce390707815ad48eb548b88cb96');
  assertCompleteIds(selections.results, compositionQueries.length, `iteration 13 run ${run}`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `iteration 13 run ${run} contains no labels or self-grades`);
  for (const item of selections.results) {
    if (sameSet(item.selected_skills, originalCompositionById.get(item.id).expected_skills)) originalPasses += 1;
    exactSet(item.selected_skills, compositionRouteById.get(item.id).expected_skills);
    revisedPasses += 1;
  }
}
const compositionGrade = readJson('evals/results/iteration-13/trigger-grading.json');
assert.deepEqual({ passed: originalPasses, total: 6 }, { passed: compositionGrade.original.passed, total: compositionGrade.original.total });
assert.ok(compositionGrade.ground_truth_revision, 'composition grading records the query-2 revision');
assert.deepEqual(compositionGrade.revised.aggregate, { passed: revisedPasses, total: 6 });
assert.deepEqual(compositionGrade.revised.per_run, [1, 2, 3].map((run) => ({ run, passed: compositionQueries.length, total: compositionQueries.length, mismatches: [] })));

for (const scenario of ['debugging', 'tdd', 'docs', 'git', 'review']) {
  const metadata = readJson(`evals/results/iteration-9/eval-${scenario}/eval_metadata.json`);
  for (const config of ['with_skill', 'old_skill']) {
    const grading = readJson(`evals/results/iteration-9/eval-${scenario}/${config}/run-1/grading.json`);
    assert.deepEqual(grading.expectations.map((item) => item.text), metadata.assertions, `${scenario}/${config} grading preserves assertion identities`);
  }
}

console.log('STATUS: PASSED (source eval fields, routing evidence, and retained single-run claims)');
