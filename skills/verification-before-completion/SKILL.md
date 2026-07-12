---
name: verification-before-completion
description: Validates completion claims against relevant, fresh evidence. Use before claiming work complete, fixed, or passing, and before authorized commits or publication when those claims depend on verification.
---

# Verification Before Completion

## APEX boundary

This leaf owns the evidence check for a completion claim. It consumes the APEX verification level and freshness boundary; it cannot expand scope or turn an irrelevant green command into evidence. Without a full decision record, the `using-apex` lightweight boundary applies.

## Overview

Completion claims need relevant evidence for the state being claimed.

**Core principle:** Evidence before claims, always.

## The Iron Law

```
NO COMPLETION CLAIMS WITHOUT RELEVANT, FRESH VERIFICATION EVIDENCE
```

Evidence is fresh when it covers the code state and inputs being claimed. A
message or agent boundary alone does not make evidence stale; a later material
change to covered code or inputs does.

## The Gate Function

```
BEFORE claiming any status or expressing satisfaction:

1. IDENTIFY: What command, inspection, visual check, or checklist proves this claim?
2. CHECK EVIDENCE: Does existing evidence cover the final code state and claim?
3. REFRESH IF NEEDED: Close stale, missing, or insufficient gaps with the smallest credible command, inspection, visual check, or checklist
4. READ: Check command exit status/failures or the recorded outcome for non-command evidence
5. VERIFY: Does the evidence confirm the claim?
   - If NO: State actual status with evidence
   - If YES: State claim WITH evidence
6. ONLY THEN: Make the claim and name any remaining boundary

If a step cannot be completed, report the evidence gap instead of the claim.
```

## Common Failures

| Claim | Requires | Not Sufficient |
|-------|----------|----------------|
| Tests pass | Test evidence with 0 failures tied to the claimed code state | Stale run, "should pass" |
| Linter clean | Linter output: 0 errors | Partial check, extrapolation |
| Build succeeds | Build command: exit 0 | Linter passing, logs look good |
| Bug fixed | Test original symptom: passes | Code changed, assumed fixed |
| Regression test works | Red-green cycle verified | Test passes once |
| Agent completed | Diff inspection plus evidence tied to the reviewed code state | Unchecked agent report |
| Requirements met | Line-by-line checklist | Tests passing |

## Red Flags - STOP

- Using "should", "probably", "seems to"
- Expressing satisfaction before verification ("Great!", "Perfect!", "Done!", etc.)
- About to commit/push/PR without verification
- Trusting agent conclusions without inspecting their evidence and the resulting code state
- Relying on partial verification
- Thinking "just this once"
- Tired and wanting work over
- **ANY wording implying success without relevant evidence for the claimed state**

## Key Patterns

**Tests:**
```
✅ [Run test command] [See: 34/34 pass] "All tests pass"
❌ "Should pass now" / "Looks correct"
```

**Regression tests:**
```
✅ Observe the regression fail before the fix → apply fix → run and pass
✅ If the original failure was not observed safely, use an isolated controlled check that proves the test detects the defect
❌ "I've written a regression test" without evidence that it can detect the regression
```

**Build:**
```
✅ [Run build] [See: exit 0] "Build passes"
❌ "Linter passed" (linter doesn't check compilation)
```

**Requirements:**
```
✅ Re-read plan → Create checklist → Verify each → Report gaps or completion
❌ "Tests pass, phase complete"
```

**Agent delegation:**
```
✅ Agent reports success → Check VCS diff → Validate evidence freshness/relevance → Run missing checks → Report actual state
❌ Trust agent report
```

## When To Apply

**Apply before:**
- Any success or completion claim about the work
- Any expression implying that a technical result is correct, fixed, or passing
- Committing, PR creation, task completion
- Marking a task complete when the next task depends on that claim

**Rule applies to:**
- Exact phrases
- Paraphrases and synonyms
- Implications of success
- ANY communication suggesting completion/correctness

## The Bottom Line

**No shortcuts for verification.**

Inspect the final state and its evidence. Run the checks needed to close real
gaps. Then make only the claim that evidence supports.
