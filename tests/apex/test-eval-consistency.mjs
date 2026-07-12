import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const readJson = (relative) => JSON.parse(fs.readFileSync(path.join(root, relative), 'utf8'));
const sameSet = (actual, expected) => JSON.stringify([...actual].sort()) === JSON.stringify([...expected].sort());
const exactSet = (actual, expected) => assert.ok(sameSet(actual, expected), `expected ${JSON.stringify(expected)}, got ${JSON.stringify(actual)}`);
const assertCompleteIds = (results, count, label) => {
  assert.deepEqual(results.map((item) => item.id).sort((a, b) => a - b), Array.from({ length: count }, (_, index) => index + 1), `${label} has each id exactly once`);
};

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
for (const name of [
  'using-apex',
  'governing-project-work',
  'shaping-solutions',
  'managing-git',
  'coordinating-subagents',
  'debugging-systematically',
  'testing-changes',
]) {
  assert.ok(expectedNames.has(name), `routing set covers ${name}`);
}
assert.ok(routes.some((item) => item.expected_skills.length === 0), 'routing set includes no-skill near misses');
assert.ok(routes.some((item) => item.expected_skills.length > 1), 'routing set includes multi-skill composition');

for (const iteration of [9, 11]) {
  const benchmark = readJson(`evals/results/iteration-${iteration}/benchmark.json`);
  assert.equal(benchmark.metadata.runs_per_configuration, 1, `iteration ${iteration} is single-run`);
  assert.equal(benchmark.metadata.timing_available, false, `iteration ${iteration} does not claim timing`);
  assert.equal(benchmark.metadata.token_metrics_available, false, `iteration ${iteration} does not claim tokens`);
  assert.equal(benchmark.run_summary.delta.definition, 'with_skill - old_skill');
}

for (const scenario of ['debugging', 'tdd', 'docs', 'git', 'review']) {
  const metadata = readJson(`evals/results/iteration-9/eval-${scenario}/eval_metadata.json`);
  assert.ok(typeof metadata.prompt === 'string' && metadata.prompt.length > 0, `${scenario} metadata retains prompt`);
}

assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/eval-git/with_skill/run-1/outputs/evidence.json')), 'execution machine evidence is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/eval-review/with_skill/run-1/outputs/report.md')), 'subagent controller report is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-11/eval-11-current-migration/with_skill/run-1/outputs/response.md')), 'current migration response is retained in viewer-compatible layout');

const blindQueries = readJson('evals/results/iteration-10/queries-only.json');
assert.deepEqual(blindQueries.map((item) => item.query), routes.slice(0, blindQueries.length).map((item) => item.query), 'iteration 10 blind queries remain a labeled prefix of the routing set');
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-10/run-${run}-selections.json`);
  assert.equal(selections.results.length, blindQueries.length, `iteration 10 blind run ${run} covers its query snapshot`);
  assertCompleteIds(selections.results, blindQueries.length, `iteration 10 run ${run}`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `blind run ${run} contains no labels or self-grades`);
}
const blindGrade = readJson('evals/results/iteration-10/trigger-grading-revised.json');
assert.equal(blindGrade.aggregate.passed, 66);
assert.equal(blindGrade.aggregate.total, 66);
assert.ok(blindGrade.ground_truth_revision, 'blind grading records the query-13 ground-truth revision');

const currentQueries = readJson('evals/results/iteration-12/queries-only.json');
assert.deepEqual(currentQueries.map((item) => item.query), routes.slice(0, currentQueries.length).map((item) => item.query), 'iteration 12 queries remain a labeled prefix of the routing set');
const currentDescriptions = readJson('evals/results/iteration-12/descriptions-only.json');
for (const item of currentDescriptions) {
  const skill = fs.readFileSync(path.join(root, `skills/${item.name}/SKILL.md`), 'utf8');
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
    exactSet(item.selected_skills, routes[item.id - 1].expected_skills);
    currentPasses += 1;
  }
}
const currentGrade = readJson('evals/results/iteration-12/trigger-grading.json');
assert.deepEqual(currentGrade.aggregate, { passed: currentPasses, total: currentQueries.length * 3 });

const compositionQueries = readJson('evals/results/iteration-13/queries-only.json');
const compositionRoutes = routes.slice(-compositionQueries.length);
assert.deepEqual(compositionQueries.map((item) => item.query), compositionRoutes.map((item) => item.query), 'iteration 13 queries match current composition routes');
const compositionDescriptions = readJson('evals/results/iteration-13/descriptions-only.json');
for (const item of compositionDescriptions) {
  const skill = fs.readFileSync(path.join(root, `skills/${item.name}/SKILL.md`), 'utf8');
  const match = skill.match(/^description:\s*(.+)$/m);
  assert.equal(item.description, match?.[1], `iteration 13 snapshots current ${item.name} description`);
}
const originalCompositionTruth = readJson('evals/results/iteration-13/ground-truth-original.json');
let revisedPasses = 0;
let originalPasses = 0;
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-13/run-${run}-selections.json`);
  assert.equal(selections.source_commit, '4534a92085468ce390707815ad48eb548b88cb96');
  assertCompleteIds(selections.results, compositionQueries.length, `iteration 13 run ${run}`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `iteration 13 run ${run} contains no labels or self-grades`);
  for (const item of selections.results) {
    if (sameSet(item.selected_skills, originalCompositionTruth[item.id - 1].expected_skills)) originalPasses += 1;
    exactSet(item.selected_skills, compositionRoutes[item.id - 1].expected_skills);
    revisedPasses += 1;
  }
}
const compositionGrade = readJson('evals/results/iteration-13/trigger-grading.json');
assert.deepEqual({ passed: originalPasses, total: 6 }, { passed: compositionGrade.original.passed, total: compositionGrade.original.total });
assert.ok(compositionGrade.ground_truth_revision, 'composition grading records the query-2 revision');
assert.deepEqual(compositionGrade.revised.aggregate, { passed: revisedPasses, total: 6 });

for (const scenario of ['debugging', 'tdd', 'docs', 'git', 'review']) {
  const metadata = readJson(`evals/results/iteration-9/eval-${scenario}/eval_metadata.json`);
  for (const config of ['with_skill', 'old_skill']) {
    const grading = readJson(`evals/results/iteration-9/eval-${scenario}/${config}/run-1/grading.json`);
    assert.deepEqual(grading.expectations.map((item) => item.text), metadata.assertions, `${scenario}/${config} grading preserves assertion identities`);
  }
}

console.log('STATUS: PASSED (official eval schema, current routing coverage, and retained benchmark claims)');
