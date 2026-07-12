import test from 'node:test';
import assert from 'node:assert/strict';
import { normalizeNames } from '../src/normalize.js';

test('trims names and removes empty entries', () => {
  assert.deepEqual(normalizeNames([' Ada ', ' ', 'Lin']), ['Ada', 'Lin']);
});
