# Sentinel

标准库 Python 流式异常检测器。接口见 [score-method v1](docs/specs/score-method.md)，离线 QA 契约见 [evaluation protocol v3](docs/specs/evaluation-protocol.md)，后续工作见 [开发计划](docs/plans/sentinel.md)。

```python
from sentinel import Detector

detector = Detector()
result = detector.process("device-1", "event-1", 0, 1.0)
assert result.score is None
assert result.warmup_remaining == 16

saved = detector.snapshot()
restored = Detector.from_snapshot(saved)
```

本地验证（在本目录执行；不含真实评测）：

```powershell
& 'D:/Code/prompt/apex/.venv/Scripts/python.exe' -m unittest discover -s tests -v
```

score 为 Decimal，warmup 时为 None。快照支持可信本地 pickle 持久化；不要反序列化不可信 pickle。检测器未声明达到 QA 的质量或延迟目标。
