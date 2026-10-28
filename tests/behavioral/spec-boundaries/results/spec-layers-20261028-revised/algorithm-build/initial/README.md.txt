# Sentinel

Pure Python streaming anomaly detection implementing score-method v1. There are no third-party dependencies.

```python
from sentinel import Detector

detector = Detector()
output = detector.process("device-1", "event-1", 1, 0.5)
restored = Detector.from_snapshot(detector.snapshot())
```

Run local detector acceptance checks from this directory:

```powershell
& 'D:/Code/prompt/apex/.venv/Scripts/python.exe' -B -m unittest discover -s tests -v
```

[Project contract](docs/specs/sentinel.md) owns the accepted scope and links to independent method/protocol specifications. [Current work plan](docs/plans/sentinel.md) tracks detector verification and the deferred evaluator. No real evaluation or latency/quality measurement is included.
