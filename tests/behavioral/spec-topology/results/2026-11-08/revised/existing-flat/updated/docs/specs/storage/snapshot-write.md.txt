# Snapshot writing

A successful snapshot atomically replaces the prior snapshot. A failed write leaves the prior accepted snapshot usable and reports SNAPSHOT_WRITE_FAILED. A snapshot includes tenant queues, enqueue sequence, attempts, terminal states and unexpired idempotency records. It never contains credentials. The encoding is not yet selected.

Acceptance: interrupted write, replacement and sensitive-field exclusion.
