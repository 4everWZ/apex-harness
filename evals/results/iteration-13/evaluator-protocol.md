# Evaluator protocol

Each fresh evaluator is instructed to read the official `skill-creator`
instructions and then only `queries-only.json` and `descriptions-only.json`.
Expected labels, repository skill bodies, and other iterations are forbidden.
The evaluator returns selections and rationale without self-grading. The runtime
does not expose an exact model identifier or transcript, so input isolation is
a recorded process constraint rather than an independently provable property.
