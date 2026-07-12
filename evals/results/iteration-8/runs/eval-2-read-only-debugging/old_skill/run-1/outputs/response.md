Route this through `systematic-debugging` under the lightweight `using-apex` boundary. This is a diagnosis-only, read-only investigation: do not edit code, change dependencies or runtime state, mutate Git, or propose a fix before establishing the cause.

The first evidence to request is:

1. The repository path and the exact failing unit-test identifier.
2. The exact command and environment used to run it.
3. The complete unedited failure output, including assertion details, stack trace, file paths, and line numbers.
4. The relevant refactor commit or diff from yesterday, plus whether the same test passed immediately before it.

Once those inputs exist, reproduce that exact test without substituting another failure, read the full error, and compare the failing path with the recent refactor. Trace the observed bad value or behavior backward through the call path if the failure is downstream, then compare with a nearby working example. Form one specific hypothesis tied to the gathered evidence and test it using read-only inspection or an already-authorized, non-mutating reproduction. Report the evidenced cause and a proposed verification experiment, but stop before implementation because no edit authority was granted.

With no repository path, test command, or failure output supplied, the investigation cannot yet establish reproducibility or root cause. The correct next step is to obtain those artifacts; it would be guessing to name a cause or substitute a different failing test.
