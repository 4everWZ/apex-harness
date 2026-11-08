# Queue delivery

Deliver jobs in increasing enqueue sequence within each tenant. A failed delivery may be attempted at most 3 times including the first attempt; after the third failure mark the job failed. A success becomes terminal and must not be redelivered. Retries do not move other tenants' jobs into this tenant's queue. Restart preserves sequence, attempt count and terminal state.

Acceptance: ordering, three failures, success, tenant isolation and recovery after the second failed attempt.
