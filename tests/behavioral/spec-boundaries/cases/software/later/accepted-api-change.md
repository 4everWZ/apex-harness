# 已接受的 API 变更

项目所有者接受公共 API v2：幂等窗口由 24 小时改为 72 小时，列表排序改为 created_at 降序、job_id 降序。其余公共 API 行为不变。本次尚未实现，旧输入保留不改写。

worker protocol 仍为 v1，所有提供方继续使用原有 lease、重试和结果提交语义，不需要因 API 发布重做协议验收。audit format 仍为 v1，字段与 tenant_sequence 顺序不变。跨边界的一致性要求继续适用。
