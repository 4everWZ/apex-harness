import test from 'node:test';
import assert from 'node:assert/strict';
import { sum } from '../src/sum.js';

test('adds positive and negative numbers', () => {
  assert.equal(sum(3, 4), 7);
  assert.equal(sum(-2, 5), 3);
});
