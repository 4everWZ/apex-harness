# Snapshot recovery

Restore accepts only a complete supported snapshot. Corrupt or unsupported data reports SNAPSHOT_INVALID and leaves the running state unchanged. Successful restoration preserves tenant boundaries, delivery order, attempt counts, terminal states and idempotency replay. Validation completes before any live-state replacement.

Acceptance: truncated data, unsupported version, no partial mutation and round-trip retry/replay behavior.
