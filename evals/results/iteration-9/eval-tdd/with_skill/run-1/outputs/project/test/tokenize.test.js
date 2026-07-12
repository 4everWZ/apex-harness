import test from 'node:test';
import assert from 'node:assert/strict';
import * as tokenizer from '../src/tokenize.js';

test('splits and trims comma-separated tokens', () => {
  assert.deepEqual(tokenizer.tokenize('alpha, beta'), ['alpha', 'beta']);
});

test('tokenizes comma-separated values as uppercase tokens', () => {
  assert.deepEqual(
    tokenizer.tokenizeUpper(' alpha, Beta, , gamma '),
    ['ALPHA', 'BETA', 'GAMMA'],
  );
});
