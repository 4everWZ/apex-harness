# APEX contributor guidance

## Architecture

- `using-apex` is the sole entry and router.
- `governing-project-work` owns substantial-work policy.
- every other skill is a cohesive leaf selected by a concrete task need
- keep the whole series at eight skills or fewer
- keep runtime adapters limited to Claude Code, Codex, Antigravity, and Gemini
  CLI unless support scope is explicitly changed

Do not duplicate risk tables, authority models, evidence formats, documentation
topology, or ordinary engineering advice across leaves. Add a reference only
when its detail is stable, needed on demand, and would distract from the core
workflow.

## Skill changes

Treat skills as behavior-shaping code. Validate every `SKILL.md` with the
official skill-creator validator. Use realistic trigger and pressure cases plus
a previous-version or no-skill baseline for material changes.

Keep scripts only for deterministic repeated work that agents would otherwise
reimplement. Do not maintain platform tool catalogs; the active runtime is the
source of truth.
