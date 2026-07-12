---
name: using-apex
description: Bootstrap entry for the installed APEX skill series. Harnesses load it once at session start; invoke it manually only when the user asks to coordinate APEX skills or the bootstrap was not loaded. Do not re-invoke it for an ordinary task after the entry is active.
---

# Using APEX

Use APEX as the command layer for skill composition. Leaf skills provide focused
mechanisms; they do not set their own risk, authority, verification intensity,
or documentation obligations.

<SUBAGENT-STOP>
If you were dispatched with one bounded role and an explicit skill or workflow,
follow that dispatch. Do not reload the entry skill or broaden your role.
</SUBAGENT-STOP>

## Instruction order

Apply instructions in this order:

1. platform system and developer instructions
2. user and repository instructions
3. the APEX command boundary below
4. applicable leaf skills

No skill can grant permission that a higher-priority source did not grant.

## APEX command boundary

Apply these rules whenever a leaf skill is used, including small work that does
not justify loading the full `apex-governance` skill:

- Preserve requested scope and obtain a user decision before a material product,
  research, data, evaluation, architecture, or public-contract tradeoff.
- Treat file edits, Git mutations, delegation, and named external mutations as
  separate capabilities. Availability is not authorization.
- Select mechanisms from observable task facts. Do not activate planning,
  worktrees, delegation, review, or documentation merely because they exist.
- Match verification to the claim and report what remains unverified. A green
  but irrelevant check is not evidence.
- Keep an existing source of truth aligned when behavior changes; do not create
  parallel specs, plans, matrices, tradeoff logs, or handoff records.

This lightweight boundary keeps routine work proportionate while ensuring every
leaf operates under the same engineering principles.

## When to load apex-governance

Load `apex-governance` before selecting execution mechanisms when work is
substantial enough to need an explicit decision record, including:

- architecture, cross-module, public API, schema, data-contract, ML, research,
  evaluation, or correctness-critical changes
- multi-step work where verification strength or documentation ownership is a
  material concern
- work that may use delegation, independent review, worktree isolation, or a
  durable plan and the appropriate intensity is not already established
- any task whose scope or claim could materially affect downstream trust

Do not load the full governance skill for a trivial local edit solely to assign
it a tier. The lightweight command boundary above still governs that edit.

When `apex-governance` is active, its decision record owns:

- risk tier and design gate
- Git, delegated, and external-mutation authority
- selected mechanisms and execution mode
- verification level and reusable evidence boundary
- documentation obligations

Leaf skills consume those decisions. They may stop when their own preconditions
are absent, but they cannot increase the recorded authority or ceremony.

## Select leaf skills

Before acting, compare the task facts with installed skill descriptions:

1. Invoke skills explicitly requested by the user.
2. Invoke skills whose concrete trigger matches the task.
3. If an invoked skill's preconditions are absent, stop using it and choose the
   smallest applicable mechanism.
4. Use multiple leaf skills only when their responsibilities are distinct and
   their order is clear.

Typical ordering is:

1. `apex-governance` when the substantial-work trigger matches
2. intent or causal process skills such as `brainstorming` or
   `systematic-debugging`
3. planning or execution skills
4. verification and review skills selected by the governing decision
5. branch-finishing skills only when the user requests branch lifecycle work

Examples:

- A cross-module feature with unresolved behavior: `apex-governance` then
  `brainstorming`, followed by the selected planning/execution mechanism.
- A narrow unexplained defect: `systematic-debugging`; load `apex-governance` only
  if investigation reveals a substantial boundary.
- A local copy edit: use the lightweight command boundary and no leaf workflow
  unless another skill has a concrete trigger.

## Leaf skill contract

Each leaf skill should define only:

- its trigger and non-trigger boundary
- mechanism-specific preconditions
- the focused process and output contract
- mechanism-specific stop conditions
- references or scripts loaded only when needed

A leaf should refer to the active APEX decision instead of restating the full
governance policy. A small repeated sentence that preserves this interface is
preferable to copying risk tables, authority schemas, or documentation rules.

## Platform adaptation

Translate actions through the tools actually exposed by the current runtime.
Harness adapters own concrete tool-name mappings and bootstrap injection. Do not
guess a tool, parameter, model selector, shell, or path convention from an old
example. If a required capability is unavailable, use a documented fallback or
report the boundary.

When the harness does not append its mapping to the bootstrap, load only the
matching adapter reference: [Claude Code](references/claude-code-tools.md),
[Codex](references/codex-tools.md), [Copilot CLI](references/copilot-tools.md),
[Gemini CLI](references/gemini-tools.md), [Pi](references/pi-tools.md), or
[Antigravity](references/antigravity-tools.md). Verify the mapping against the
tools actually exposed in the session; the runtime interface is authoritative.

## Start-of-task output

Keep coordination visible but proportionate:

- state which governance or leaf skills are being used and why
- for substantial APEX work, report the decision boundary required by
  `apex-governance`
- for routine work, avoid manufacturing a tier report or workflow ceremony

The goal is disciplined execution with the least mechanism that can credibly
deliver the requested result.
