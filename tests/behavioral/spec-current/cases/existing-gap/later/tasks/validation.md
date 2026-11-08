# LimitParser validation work
This file owns current validation state. Existing evidence/current-check.txt records the present rejection failures; evidence/old-smoke.txt only checked a default on an older state.
Remaining: reject out-of-range integers, bool, string and float; then run the existing acceptance tests against the implementation. There is no passing current evidence for the complete contract. Do not relax the accepted specification to match the implementation.
