# APEX repository rules

- `using-apex` is the only bootstrap entry.
- `apex-governance` owns risk, authority, verification, evidence freshness, and
  documentation policy.
- Every other skill is a focused leaf and must not duplicate or broaden those
  governance decisions.
- Keep leaf directory/frontmatter names stable unless an explicit migration is
  approved.
- Do not guess runtime tools, parameters, schemas, or environment semantics.
- Preserve user scope and ask before material product, research, data,
  evaluation, architecture, or public-contract tradeoffs.
- Keep changes cohesive, use repository-native tooling, and verify the changed
  claim rather than relying on unrelated green checks.
- Material skill behavior changes require previous-version or no-skill baselines
  and realistic trigger/pressure cases; static tests only prove structure.
