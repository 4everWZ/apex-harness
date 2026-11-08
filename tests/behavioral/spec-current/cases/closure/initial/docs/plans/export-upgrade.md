# Export upgrade
Goal: implement and verify the [export contract](../specs/export.md).
当前团队已确认实现只处理 ASCII 非空批次；Unicode、空导出、恢复与敏感字段检查均未完成。现有 [smoke](../../evidence/smoke.txt) 只验证旧实现的一个 ASCII 样本。
待完成实现与当前契约的验收，不得据 smoke 声称交付。
## Warmup history
试跑一：H0 44 ms；试跑二：H0 42 ms。只是预热，不影响任何当前选择。原始数据已由 evidence/warmup.csv 持有。
