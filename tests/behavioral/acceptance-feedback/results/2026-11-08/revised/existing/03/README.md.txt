# Existing LimitDesk
[规格](docs/specs/limitdesk.md) 定义接受要求。持续验收和有效反馈由 [quality/current.md](quality/current.md) 维护，该位置是仓库既有权威承载者；具体工单由 issues/current.md 维护，CI 当前结果在 ci/current.txt。它们是本地提供的服务数据镜像，本任务只修改本地文件，不连接外部服务。
测试命令 python -m unittest discover -s tests；功能输出覆盖写 ci/current.txt，性能输出覆盖写 ci/performance.txt。ops/operator-guide.md 是有独立读者的运行说明，继续维护。
