---
name: managing-project-docs
description: Manages project documentation topology, templates, specification and artifact lifecycles, handoffs, and legacy documentation or code boundaries. Use directly when the user asks about document hierarchy, durable engineering artifacts, templates, supersession, or legacy management; using-apex and full project governance are not prerequisites.
---

# Managing Project Docs

Keep durable engineering knowledge easy to find, current, and owned. Prefer the
repository's established documentation layout and formats; use this skill's
neutral topology and templates only when the repository has no stronger
convention.

This skill is directly selectable. Do not load `using-apex` first merely to
manage documents, and do not activate full project governance unless risk,
authority, evidence, or completion boundaries independently require it.

## Select the artifact

Read [documentation.md](references/documentation.md) before creating, moving,
superseding, or retiring a durable project artifact. It defines:

- document topology and ownership
- the distinction between specs, designs, plans, matrices, tradeoffs, and status
- fallback templates under `assets/templates/`
- decision status, artifact supersession, and legacy lifecycle
- legacy-code containment and retirement records

Create or update only the artifact that owns the information. Link to existing
sources instead of copying them. Remove unused template sections.

## Compose without duplication

- Use `shaping-solutions` when design intent or plan content remains unresolved;
  this skill owns artifact placement and lifecycle, while shaping owns the
  substantive design or plan.
- Use `governing-project-work` only when the task also needs an explicit risk,
  mutation-authority, evidence-strength, or completion boundary.
- Keep behavior and its canonical documentation consistent in the same change.
  If the requested work makes a durable source false, update or explicitly
  supersede it.

## Completion

Before claiming document work complete, check that links and ownership are
unambiguous, active and legacy status agree, required templates were actually
adapted, and no empty artifact directory or competing source of truth remains.
