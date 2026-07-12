Route this to systematic debugging because the failure is unexplained, but stop before diagnosis: the repository path, exact test command, and failure output are required to investigate the named regression without inventing or substituting evidence.

The first evidence to gather is:

- the repository and current branch/commit, plus the relevant environment details;
- the exact identity of the failing unit test and the command that produced the failure;
- the complete, unedited failure output, including assertion details and stack trace;
- whether that same command reliably reproduces the same failure, ideally with the smallest invocation that still does;
- the relevant refactor diff from yesterday and the surrounding test and production code once their paths are known.

With that evidence, reproduce only this unit-test failure and record its exact input and output. Then read the complete failure, surrounding code and configuration, and recent relevant changes. Trace the incorrect value or state backward across boundaries, comparing inputs, outputs, and changed assumptions. Form one falsifiable hypothesis and run the smallest read-only or explicitly authorized experiment that distinguishes it from alternatives, changing one variable at a time. Repeat until the root cause is supported or the remaining uncertainty is explicit.

No edit or fix is authorized in this scenario. Until the missing evidence is supplied, the cause remains unknown; a different locally available failure must not be used as a proxy.
