import test from 'node:test';
import assert from 'node:assert/strict';
import { tokenize, tokenizeUpper } from '../src/tokenize.js';

test('splits and trims comma-separated tokens', () => {
  assert.deepEqual(tokenize('alpha, beta'), ['alpha', 'beta']);
});

test('returns tokenized values in uppercase', () => {
  assert.deepEqual(tokenizeUpper('alpha, beta'), ['ALPHA', 'BETA']);
});
