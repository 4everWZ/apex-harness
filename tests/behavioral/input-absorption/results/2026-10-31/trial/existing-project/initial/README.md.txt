# QueueDesk

This README is the maintained product specification and documentation entry point. There is no separate specification document.

## Accepted current contract
R01. GET /jobs returns only jobs owned by the current tenant.
R02. The optional limit is an integer from 1 through 200 inclusive; default 20. Invalid values return 400 with code invalid_limit.
R03. Results sort by created_at descending, then job_id descending. Cursor traversal follows both descending ordering keys.
R04. Pagination uses an opaque cursor containing both ordering keys and the tenant identity. A foreign or malformed cursor returns 400 with code invalid_cursor. Existing cursors encoded under the previous ordering (created_at descending, job_id ascending) also return 400 with code invalid_cursor; they must not be silently reinterpreted under the new ordering.
R05. An empty page is {"items": [], "next_cursor": null}.
R06. The response contains items and next_cursor only; every item contains job_id and created_at. Preserve all existing item fields when applying CR-17.

## Development
The accepted CR-17 contract above precedes implementation and verification. Conformance and delivery have not been established. Current unfinished work is in [the work plan](docs/plans/pagination.md).
