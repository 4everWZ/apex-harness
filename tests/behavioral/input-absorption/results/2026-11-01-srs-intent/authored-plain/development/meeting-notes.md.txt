# Customer discussion material

These are requested changes for discussion, not accepted product changes yet. The existing project documents remain the source of accepted requirements.

The customer wants returning an article to require a reason. A reason containing only whitespace should be rejected; a valid reason must contain at most 500 Unicode code points. A rejected action must leave the article Submitted and must not add a review audit event. The writer must see the reason on the Returned article. Trimming for validation must not silently rewrite the stored reason. The wording of the error message has not been decided.

Administrators want the automatic refresh interval configured through the server's `refresh_seconds` YAML value. It should default to 30 when absent, accept integers from 5 through 120 inclusive, and reject an invalid configured value at server startup rather than silently using the default. It takes effect after a server restart, applies to all users, and has no browser-side override. Existing non-overlap, manual refresh and failure behavior should continue.

CSV export and email notifications are suggestions only. No recipients, export fields, delivery guarantees, schedule or implementation have been agreed. The customer has not requested changes to supported browsers, viewport limits, team boundaries, review permissions, keyboard accessibility or the H1 performance requirement. No evidence of implementation or performance is available from this meeting.
