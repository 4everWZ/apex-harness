export function tokenize(input) {
  return input.split(',').map((value) => value.trim()).filter(Boolean);
}

export function tokenizeUpper(input) {
  return tokenize(input).map((token) => token.toUpperCase());
}
