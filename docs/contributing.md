# APEX contributor guidance

## Architecture

- `using-apex` is the sole bootstrap and routing entry; leaves remain directly
  selectable after bootstrap.
- APEX is Codex-first; compatibility adapters only expose the same skills to
  Claude Code, Gemini CLI, and Antigravity.
- `governing-project-work` owns risk, authority, evidence, and completion policy.
- `managing-project-docs` owns documentation topology, templates, artifact
  lifecycle, and legacy management and is directly selectable without bootstrap.
- every other skill is a cohesive leaf selected by a concrete task need
- keep the whole series at eight skills or fewer
- keep runtime support limited to native Codex plus compatibility adapters for
  Claude Code, Gemini CLI, and Antigravity unless scope is explicitly changed

Do not duplicate risk tables, authority models, evidence formats, documentation
topology, or ordinary engineering advice across leaves. Do not encode custom
subagent model, scheduling, or reasoning settings. Add a reference only
when its detail is stable, needed on demand, and would distract from the core
workflow.

## Skill changes

Treat skills as behavior-shaping code. Validate every `SKILL.md` with the
official skill-creator validator. Use realistic trigger and pressure cases plus
a previous-version or no-skill baseline for material changes.

Keep scripts only for deterministic repeated work that agents would otherwise
reimplement. Do not maintain platform tool catalogs; the active runtime is the
source of truth.
