# Evaluator protocol

Each evaluator was instructed to read the official `skill-creator` instructions
and then only `queries-only.json` and `descriptions-only.json`; it was explicitly
forbidden from reading labels, other iterations, or skill bodies. It returned
all 23 selections as JSON and did not grade itself. The runtime exposed neither
an exact model identifier nor a transcript, so input isolation is a recorded
process constraint, not independently provable from the retained artifacts.
