import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const readJson = (relative) => JSON.parse(fs.readFileSync(path.join(root, relative), 'utf8'));

const evals = readJson('evals/evals.json');
assert.equal(evals.skill_name, 'using-apex');
assert.ok(evals.evals.length >= 11);
for (const item of evals.evals) {
  assert.ok(Number.isInteger(item.id), `eval id is integer: ${item.id}`);
  assert.ok(item.prompt.startsWith('Routing-only'), `eval ${item.id} declares routing-only scope`);
  assert.ok(Array.isArray(item.assertions) && item.assertions.length > 0, `eval ${item.id} has assertions`);
  assert.ok(!('expectations' in item), `eval ${item.id} keeps grader expectations out of source definitions`);
  assert.ok(!/performs the bounded edit/i.test(item.expected_output), `eval ${item.id} does not claim unexecuted edits`);
}

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
assert.deepEqual(blindQueries.map((item) => item.query), routes.map((item) => item.query), 'blind queries match current routing set');
for (const run of [1, 2, 3]) {
  const selections = readJson(`evals/results/iteration-10/run-${run}-selections.json`);
  assert.equal(selections.results.length, routes.length, `blind run ${run} covers every query`);
  assert.ok(selections.results.every((item) => !('expected' in item) && !('passed' in item)), `blind run ${run} contains no labels or self-grades`);
}
const blindGrade = readJson('evals/results/iteration-10/trigger-grading-revised.json');
assert.equal(blindGrade.aggregate.passed, 66);
assert.equal(blindGrade.aggregate.total, 66);
assert.ok(blindGrade.ground_truth_revision, 'blind grading records the query-13 ground-truth revision');

for (const scenario of ['debugging', 'tdd', 'docs', 'git', 'review']) {
  const metadata = readJson(`evals/results/iteration-9/eval-${scenario}/eval_metadata.json`);
  for (const config of ['with_skill', 'old_skill']) {
    const grading = readJson(`evals/results/iteration-9/eval-${scenario}/${config}/run-1/grading.json`);
    assert.deepEqual(grading.expectations.map((item) => item.text), metadata.assertions, `${scenario}/${config} grading preserves assertion identities`);
  }
}

console.log('STATUS: PASSED (eval schema, routing coverage, and retained benchmark claims)');
