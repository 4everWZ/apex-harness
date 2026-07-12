import test from 'node:test';
import assert from 'node:assert/strict';
import { tokenize } from '../src/tokenize.js';

test('splits and trims comma-separated tokens', () => {
  assert.deepEqual(tokenize('alpha, beta'), ['alpha', 'beta']);
});
