# QueueDesk

This is the maintained QueueDesk product specification. Accepted contract changes belong here.

## Accepted current contract
R01. GET /jobs returns only jobs owned by the current tenant.
R02. The optional limit is an integer from 1 through 100 inclusive; default 20. Invalid values return 400 with code invalid_limit.
R03. Results sort by created_at descending, then job_id ascending.
R04. Pagination uses an opaque cursor containing both ordering keys and the tenant identity. A foreign or malformed cursor returns 400 with code invalid_cursor.
R05. An empty page is {"items": [], "next_cursor": null}.
R06. The response contains items and next_cursor only; every item contains job_id and created_at.

## Development
The local adapter implements this contract, but no delivery claim for a changed contract is established without its relevant checks. Current unfinished work is in [the work plan](../plans/pagination.md).
