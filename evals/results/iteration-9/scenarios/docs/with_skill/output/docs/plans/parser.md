# Quoted Tokenizer Implementation Plan

> **For agentic workers:** Use the repository's plan execution workflow to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the approved quoted-token parsing API and focused regression coverage.

**Architecture:** Extend the existing tokenizer module with a single-pass quoted-field parser that owns only quote state, token accumulation, and delimiter handling. Keep the existing export unchanged and exercise the public module through Node's built-in test runner.

**Tech Stack:** JavaScript (ES modules), Node.js built-in `node:test` and `node:assert/strict`

**Spec:** [Parser API Specification](../specs/parser.md)

## Global Constraints

The approved spec is the sole behavior contract. Do not add dependencies, change `tokenize`, add public exports beyond the approved function, or invent whitespace, escaping, or input-validation semantics that the spec does not define.

---

### Task 1: Add focused public-API tests

**Files:**
- Create: `test/tokenize.test.js`
- Test: `test/tokenize.test.js`

**Interfaces:**
- Consumes: named exports from `src/tokenize.js`
- Produces: focused assertions for the approved acceptance cases and preservation of the existing `tokenize(input)` behavior

- [ ] **Step 1: Create the acceptance tests**

Use `node:test` and `node:assert/strict`. Cover plain comma-separated input, a comma inside double quotes, an empty unquoted field, and an unmatched opening quote. Assert the unmatched-quote case with `assert.throws(..., SyntaxError)`. Use inputs that do not establish unspecified whitespace, escaping, or non-string-input behavior. Add a regression assertion for the existing `tokenize` export.

- [ ] **Step 2: Confirm the tests initially expose the missing API**

Run: `node --test test/tokenize.test.js`

Expected: the test command fails because `src/tokenize.js` does not yet provide the approved named export; failures must not be caused by test syntax or module loading.

---

### Task 2: Implement the quoted tokenizer

**Files:**
- Modify: `src/tokenize.js`
- Test: `test/tokenize.test.js`

**Interfaces:**
- Consumes: `tokenizeQuoted(input)` string input as defined by the approved spec
- Produces: named export `tokenizeQuoted`, an array of parsed tokens, and `SyntaxError` for an unmatched quote

- [ ] **Step 1: Add a single-pass parser**

Scan the input once while tracking whether the cursor is inside a double-quoted region. Treat commas as delimiters only outside quotes, omit quote characters from accumulated token content, and retain enough field state to distinguish an empty unquoted field from quoted content. At end of input, throw `SyntaxError` if quote state remains open; otherwise finalize the last field under the same rules as earlier delimiters. Keep `tokenize` unchanged.

- [ ] **Step 2: Run the focused suite**

Run: `node --test test/tokenize.test.js`

Expected: all acceptance and regression tests pass with no skipped or cancelled tests.

---

### Task 3: Review the bounded public surface

**Files:**
- Review: `src/tokenize.js`
- Review: `test/tokenize.test.js`

**Interfaces:**
- Consumes: the completed implementation and focused test results
- Produces: evidence that the change is limited to the approved API and preserves the existing tokenizer

- [ ] **Step 1: Inspect the final diff**

Confirm that implementation changes are confined to `src/tokenize.js`, test changes are confined to `test/tokenize.test.js`, `tokenize` remains behaviorally unchanged, and no dependency or unrelated public API was added.

- [ ] **Step 2: Re-run final verification**

Run: `node --test test/tokenize.test.js`

Expected: exit status 0; the four approved acceptance cases and the existing-tokenizer regression assertion all pass.
