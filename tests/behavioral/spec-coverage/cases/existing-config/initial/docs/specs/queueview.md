# QueueView Specification

## Intent
A desktop browser queue viewer, supported in current Chrome and Edge. The maintained owner of behavior and acceptance is this file; README is navigation only.

## Contract
The list shows loading, records, empty, or load-error. A load error offers retry and must not masquerade as an empty list. Manual Refresh is unavailable while a request is in flight. Requests do not mutate queue records.

The server reads refresh_seconds at startup. Precedence is QUEUE_REFRESH_SECONDS environment value, then refresh_seconds in project YAML, then 30. It must be a whole integer from 5 to 300 inclusive; an invalid selected value fails startup before serving. Editing YAML or the environment takes effect only after a server restart. GET /config returns exactly {"refresh_seconds": <integer>}; external v1 clients depend on that key and shape.

The page reads the effective interval on initial load. Automatic refresh is always enabled in the current contract. The next refresh starts one interval after the previous request completes, so requests never overlap. A manual refresh resets that schedule. An interval refresh that fails leaves the last successful records visible with a retry indicator.

## Acceptance
Check loading/empty/error distinctions, retry with retained records, single in-flight request, interval bounds and precedence, startup failure, restart-only configuration, and unchanged v1 payload. No changed-contract conformance is claimed by this document.
