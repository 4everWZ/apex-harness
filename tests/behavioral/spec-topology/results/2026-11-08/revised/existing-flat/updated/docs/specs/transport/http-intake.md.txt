# HTTP intake

Only registered job types may be submitted. Unknown types return 422 without enqueuing work. Accept UTF-8 JSON objects only; malformed input returns 400 with no state change. Clients receive a job ID only after durable enqueue; a retry after a lost reply uses the same idempotency key and returns that ID without creating another job. Keys are scoped to tenant and expire 24 hours after first successful enqueue.

Acceptance: malformed JSON, unregistered types, Unicode, tenant isolation and a lost-response replay after restart.
