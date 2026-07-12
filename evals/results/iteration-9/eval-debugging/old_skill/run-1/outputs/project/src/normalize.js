export function normalizeNames(values) {
  return values.map((value) => value.trim).filter(Boolean);
}
