import assert from 'node:assert/strict';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const readJson = (relative) => JSON.parse(fs.readFileSync(path.join(root, relative), 'utf8'));

const evals = readJson('evals/evals.json');
assert.equal(evals.skill_name, 'apex-series');
assert.ok(evals.evals.length >= 11);
for (const item of evals.evals) {
  assert.ok(Number.isInteger(item.id), `eval id is integer: ${item.id}`);
  assert.ok(item.prompt.startsWith('Routing-only'), `eval ${item.id} declares routing-only scope`);
  assert.ok(Array.isArray(item.expectations) && item.expectations.length > 0, `eval ${item.id} has expectations`);
  assert.ok(!('assertions' in item), `eval ${item.id} follows skill-creator evals.json schema`);
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

for (const iteration of [5, 6, 7, 8, 9]) {
  const benchmark = readJson(`evals/results/iteration-${iteration}/benchmark.json`);
  assert.equal(benchmark.metadata.runs_per_configuration, 1, `iteration ${iteration} is single-run`);
  assert.equal(benchmark.metadata.timing_available, false, `iteration ${iteration} does not claim timing`);
  assert.equal(benchmark.metadata.token_metrics_available, false, `iteration ${iteration} does not claim tokens`);
  assert.equal(benchmark.run_summary.delta.definition, 'with_skill - old_skill');
}

assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-8/runs/eval-2-read-only-debugging/with_skill/run-1/outputs/response.md')), 'routing raw response is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/scenarios/git/with_skill/evidence.json')), 'execution machine evidence is retained');
assert.ok(fs.existsSync(path.join(root, 'evals/results/iteration-9/scenarios/review/with_skill/report.md')), 'subagent controller report is retained');

console.log('STATUS: PASSED (eval schema, routing coverage, and retained benchmark claims)');
