# LimitDesk
这是会持续收集客户反馈的本地配置组件。

[配置值解析规格与验收](docs/specs/config-limit.md) 维护当前接受要求、验收结论和待处理客户意见。`tmp/srs.md` 是建立当前要求的已接受输入，不承担后续维护。

功能检查命令是 `python -m unittest discover -s tests`，输出覆盖写入 `evidence/unit.txt`；性能检查命令是 `python check_performance.py`，输出覆盖写入 `evidence/performance.txt`。性能检查使用规格限定的 Python 环境。这些文件只保存当前检查输出，持续有效的验收结论保留在规格中。
