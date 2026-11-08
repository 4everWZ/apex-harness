# Access policy

The accepted session lifetime is 30 minutes since the last successful authenticated request. At the expiry instant and later, reject the request as SESSION_EXPIRED without performing its operation. Reject a revoked session as SESSION_REVOKED regardless of idle time. Rejected requests do not extend the session. IDs are case-sensitive.

Acceptance covers the exact expiry boundary, successful refresh, rejected requests and revocation precedence. Current behavior is required, not an assertion about implementation conformance.
