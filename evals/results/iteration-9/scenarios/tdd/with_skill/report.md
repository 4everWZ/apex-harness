# TDD Report: `tokenizeUpper`

## Test added

Added `tokenizes comma-separated values as uppercase tokens` in
`project/test/tokenize.test.js`.

The test exercises the exported module boundary with:

```js
tokenizer.tokenizeUpper(' alpha, Beta, , gamma ')
```

and expects:

```js
['ALPHA', 'BETA', 'GAMMA']
```

This covers uppercase transformation while also demonstrating that the existing
tokenization behavior (trimming and filtering empty comma-separated values) is
preserved.

## Red

Command:

```text
node --test --test-name-pattern="tokenizes comma-separated values as uppercase tokens" test/tokenize.test.js
```

Result: exit code 1; 1 test, 0 passed, 1 failed.

Exact failure reason:

```text
TypeError: tokenizer.tokenizeUpper is not a function
```

This was the intended red state: the test loaded and executed correctly, then
failed because the requested public function did not yet exist.

## Implementation

Added the following export to `project/src/tokenize.js`:

```js
export function tokenizeUpper(input) {
  return tokenize(input).map((token) => token.toUpperCase());
}
```

Delegating to `tokenize` preserves its existing splitting, trimming, and empty
token filtering semantics rather than duplicating them.

## Green

Focused command:

```text
node --test --test-name-pattern="tokenizes comma-separated values as uppercase tokens" test/tokenize.test.js
```

Result: exit code 0; 1 test, 1 passed, 0 failed.

Full-suite command:

```text
npm test
```

Result: exit code 0; 2 tests, 2 passed, 0 failed. Both the original `tokenize`
test and the new `tokenizeUpper` test passed.

## Refactor

Reviewed the green implementation for duplication and boundary clarity. No
further code change was warranted: the implementation is already the smallest
cohesive form and reuses `tokenize` as the single source of tokenization
behavior.
