# TDD Report: `tokenizeUpper`

## Test added

Updated `project/test/tokenize.test.js` to import `tokenizeUpper` and added:

```js
test('returns tokenized values in uppercase', () => {
  assert.deepEqual(tokenizeUpper('alpha, beta'), ['ALPHA', 'BETA']);
});
```

## RED

Command:

```text
node --test test/tokenize.test.js
```

Result: exit code 1. The focused test file failed before production code was changed because the requested export did not exist. Exact failure reason:

```text
SyntaxError: The requested module '../src/tokenize.js' does not provide an export named 'tokenizeUpper'
```

Output summary:

```text
tests 1
pass 0
fail 1
```

## GREEN implementation

Updated `project/src/tokenize.js` with:

```js
export function tokenizeUpper(input) {
  return tokenize(input).map((token) => token.toUpperCase());
}
```

This delegates token production to the existing `tokenize` function and uppercases only the returned tokens, preserving `tokenize` behavior.

## Verification

Focused command:

```text
node --test test/tokenize.test.js
```

Result: exit code 0; 2 tests passed, 0 failed.

Full-suite command:

```text
npm test
```

Result: exit code 0; 2 tests passed, 0 failed.

## Refactor

No refactor was needed after GREEN. The implementation is a focused composition of the existing tokenizer and contains no duplicated tokenization logic.
