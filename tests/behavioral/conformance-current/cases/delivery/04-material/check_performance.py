import json
import math
import platform
import time
from parser import parse_limit

samples = []
for _ in range(1000):
    start = time.perf_counter_ns()
    values = (parse_limit(None), parse_limit(5), parse_limit(120), parse_limit("auto"))
    elapsed = (time.perf_counter_ns() - start) / 1_000_000
    if values != (30, 5, 120, 30):
        raise SystemExit("functional precondition failed")
    samples.append(elapsed)
p95 = sorted(samples)[math.ceil(0.95 * len(samples)) - 1]
result = {"environment": platform.platform(), "python": platform.python_version(),
          "samples": len(samples), "unit": "ms", "method": "nearest rank",
          "scope": "four calls per sample: None,5,120,auto; no startup or file IO",
          "p95_ms": p95, "limit_ms": 10, "passed": p95 <= 10}
print(json.dumps(result, ensure_ascii=False))
raise SystemExit(0 if result["passed"] else 1)
