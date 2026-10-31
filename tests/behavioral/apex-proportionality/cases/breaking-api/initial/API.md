# Job payload

The current v1 contract contains exactly `id` and `status`, both strings. External desktop clients consume these keys.

API v2 is approved for implementation: exactly `job_id` and `state`, with unchanged string values. External desktop clients have not been migrated. This repository contains only the encoder and one local parser, not a running transport or deployment.
