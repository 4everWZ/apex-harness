# Read-only debugging report

## Scope and method

The investigation followed the supplied baseline `systematic-debugging` skill. I reproduced the failure, read the complete error, inspected the implementation and test, traced the returned values to their source, and tested one hypothesis with a read-only Node command. I did not edit any file in `project` and did not attempt a fix.

## Reproduction

Working directory for all project commands:

```text
D:\Code\prompt\apex-workspace\iteration-9\debugging\old_skill\project
```

Command:

```powershell
npm test
```

Output (exit code 1):

```text
> test
> node --test

✖ trims names and removes empty entries (2.2188ms)
ℹ tests 1
ℹ suites 0
ℹ pass 0
ℹ fail 1
ℹ cancelled 0
ℹ skipped 0
ℹ todo 0
ℹ duration_ms 194.7502

✖ failing tests:

test at test\normalize.test.js:5:1
✖ trims names and removes empty entries (2.2188ms)
  AssertionError [ERR_ASSERTION]: Expected values to be strictly deep-equal:
  + actual - expected
  
    [
  +   [Function: trim],
  +   [Function: trim],
  +   [Function: trim]
  -   'Ada',
  -   'Lin'
    ]
  
      at TestContext.<anonymous> (file:///D:/Code/prompt/apex-workspace/iteration-9/debugging/old_skill/project/test/normalize.test.js:6:10)
      at Test.runInAsyncScope (node:async_hooks:227:14)
      at Test.run (node:internal/test_runner/test:1201:25)
      at Test.start (node:internal/test_runner/test:1096:17)
      at startSubtestAfterBootstrap (node:internal/test_runner/harness:385:17) {
    generatedMessage: true,
    code: 'ERR_ASSERTION',
    actual: [Array],
    expected: [Array],
    operator: 'deepStrictEqual',
    diff: 'simple'
  }
```

The single test therefore reproduces the failure: 0 passed and 1 failed.

## Source and contract evidence

Command:

```powershell
$n=0; Get-Content -LiteralPath '.\src\normalize.js' | ForEach-Object { $n++; '{0,4}: {1}' -f $n, $_ }; $n=0; Get-Content -LiteralPath '.\test\normalize.test.js' | ForEach-Object { $n++; '{0,4}: {1}' -f $n, $_ }; node --input-type=module -e "import { normalizeNames } from './src/normalize.js'; const input=[' Ada ','',' Lin ']; const output=normalizeNames(input); console.log(output); console.log(output.map((value,index)=>({index,type:typeof value,name:value?.name})));"
```

Output (exit code 0):

```text
   1: export function normalizeNames(values) {
   2:   return values.map((value) => value.trim).filter(Boolean);
   3: }
   1: import test from 'node:test';
   2: import assert from 'node:assert/strict';
   3: import { normalizeNames } from '../src/normalize.js';
   4: 
   5: test('trims names and removes empty entries', () => {
   6:   assert.deepEqual(normalizeNames([' Ada ', ' ', 'Lin']), ['Ada', 'Lin']);
   7: });
[ [Function: trim], [Function: trim], [Function: trim] ]
[
  { index: 0, type: 'function', name: 'trim' },
  { index: 1, type: 'function', name: 'trim' },
  { index: 2, type: 'function', name: 'trim' }
]
```

The test establishes the intended contract: trim each input string, then remove the resulting empty string. The implementation instead maps each input to a function object.

## Hypothesis test

Hypothesis: `src/normalize.js:2` references the `trim` method instead of invoking it. Consequently `map` produces truthy function objects; `filter(Boolean)` retains all three, including the entry originating from whitespace-only input.

Command:

```powershell
node --input-type=module -e "const values=[' Ada ',' ','Lin']; const referenced=values.map(value=>value.trim); const invoked=values.map(value=>value.trim()); console.log('referenced:', referenced.map(value=>({type:typeof value,name:value.name}))); console.log('invoked:', invoked); console.log('invoked+filtered:', invoked.filter(Boolean));"
```

Output (exit code 0):

```text
referenced: [
  { type: 'function', name: 'trim' },
  { type: 'function', name: 'trim' },
  { type: 'function', name: 'trim' }
]
invoked: [ 'Ada', '', 'Lin' ]
invoked+filtered: [ 'Ada', 'Lin' ]
```

This confirms the hypothesis without changing the implementation.

## Root cause

The root cause is the missing invocation parentheses on `value.trim` at `src/normalize.js:2`. JavaScript property access (`value.trim`) returns the `String.prototype.trim` function; it does not execute it. Every returned function object is truthy, so the subsequent Boolean filter cannot remove the whitespace-only element. The failure is therefore in normalization itself, not in the assertion or the filter.

The implied source-level correction would be to invoke the method (`value.trim()`), after which the existing filter has the values it expects. No correction was applied because this task is diagnosis-only.

## Version-control and file-integrity observations

Command:

```powershell
git status --short --branch; git log -5 --oneline
```

Output (exit code 1):

```text
fatal: not a git repository (or any of the parent directories): .git
fatal: not a git repository (or any of the parent directories): .git
```

An upward search also found no `.git` directory, so recent-change history and Git worktree integrity could not be assessed for this fixture.

The following SHA-256 hashes were captured before running the test and again after all read-only diagnostics. They were identical in both snapshots:

```text
package.json
E752C067CB66EDA7400950F88D154AF466B2DA84828C54DD8A4996F73BB04369

src\normalize.js
8CCB319CB5178CA4A9923EE68D33E2E1E9D6E56E503CD379CD773AE2F210C8A1

test\normalize.test.js
230DE8B3D23F19C6B4191890C263E15F7D56C374D97013B505E97BA137948DA2
```

This establishes that the project files were not modified during the investigation. The only written artifact is this report, outside the `project` directory.
