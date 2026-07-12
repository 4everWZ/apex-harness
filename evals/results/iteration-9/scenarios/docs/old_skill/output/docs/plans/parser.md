# Quoted-Comma Parser Implementation Plan

> **For agentic workers:** Use the repository's plan execution workflow to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add the approved quoted-comma tokenizer behavior and focused regression coverage without changing the existing `tokenize` API or adding any other public API.

**Architecture:** Extend the existing tokenizer module with a single-pass state machine that distinguishes delimiters inside and outside double quotes. Exercise the public exports through Node's built-in test runner; add only the minimal ES-module project metadata needed to make that test command reproducible.

**Tech Stack:** JavaScript ES modules, Node.js built-in `node:test` and `node:assert/strict`

**Spec:** [`../specs/parser.md`](../specs/parser.md)

## Global Constraints

- No other public API changes.

---

### Task 1: Implement and verify `tokenizeQuoted`

**Files:**
- Create: `package.json`
- Create: `tests/tokenize.test.js`
- Modify: `src/tokenize.js:1`

**Interfaces:**
- Consumes: `tokenize(input)` as the existing named export from `src/tokenize.js`; the approved behavior contract in `docs/specs/parser.md`
- Produces: named export `tokenizeQuoted(input)` from `src/tokenize.js`, returning an array of tokens or throwing `SyntaxError` for an unmatched double quote; `npm test` as the repository-local verification entry point

- [ ] **Step 1: Add the dependency-free ES-module test entry point**

Create `package.json` with `"private": true`, `"type": "module"`, and a `"test": "node --test"` script. Do not add runtime or development dependencies.

- [ ] **Step 2: Write focused public-API tests before the implementation**

Create `tests/tokenize.test.js` using `node:test` and `node:assert/strict`. Import both named exports from `../src/tokenize.js` and cover these observable cases:

- `tokenize('alpha,beta')` remains `['alpha', 'beta']`, guarding the existing API against regression.
- `tokenizeQuoted('alpha,beta')` returns `['alpha', 'beta']`.
- `tokenizeQuoted('alpha,"beta,gamma"')` returns `['alpha', 'beta,gamma']`.
- `tokenizeQuoted('alpha,,beta')` returns `['alpha', 'beta']`.
- `tokenizeQuoted('alpha,"beta')` throws an error whose constructor is `SyntaxError`.

Run: `npm test`

Expected: the existing `tokenize` regression test passes, while the four `tokenizeQuoted` tests fail because the named export is not yet present.

- [ ] **Step 3: Implement the parser as a focused extension of the tokenizer module**

Add `tokenizeQuoted(input)` to `src/tokenize.js` without altering `tokenize(input)`. Scan the input once while maintaining the current token buffer, whether the scan is inside a double-quoted region, and whether the current token was quoted. Omit quote characters from the buffer, treat commas as delimiters only outside quotes, discard empty unquoted fields, and preserve a quoted empty field. After the final character, throw `SyntaxError` if quote state is still open; otherwise finalize the last field under the same empty-field rule. Do not add exports, options, escaping rules, or alternate quote syntax beyond the approved contract.

- [ ] **Step 4: Run the focused suite and inspect the public export surface**

Run: `npm test`

Expected: five tests pass with zero failures, including the unchanged `tokenize` behavior and all four required `tokenizeQuoted` categories.

Run: `node --input-type=module -e "import('./src/tokenize.js').then((m) => { const names = Object.keys(m).sort(); if (JSON.stringify(names) !== JSON.stringify(['tokenize', 'tokenizeQuoted'])) throw new Error(names.join(',')); console.log(names.join(',')); })"`

Expected: exits successfully and prints `tokenize,tokenizeQuoted`, demonstrating that no additional public export was introduced.

- [ ] **Step 5: Review the implementation diff against the approved source of truth**

Run: `git diff --check -- src/tokenize.js tests/tokenize.test.js package.json docs/plans/parser.md` when executing in a Git worktree; if this fixture is still outside a Git worktree, inspect those four files directly instead of treating the unavailable Git check as evidence.

Expected: no whitespace errors in a Git worktree, and in either environment the implementation and tests remain limited to the API and acceptance behavior linked in `docs/specs/parser.md`.
