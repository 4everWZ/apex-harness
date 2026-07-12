export function tokenize(input) {
  return input.split(',').map((value) => value.trim()).filter(Boolean);
}
