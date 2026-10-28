# Relay 产品需求输入

以下 R01–R36 已由项目所有者接受，目前尚无实现。该文件是传入的需求材料，后续由项目文档承担维护职责，不修改本输入。

Relay 由公共任务 API、worker 插件协议和审计导出能力组成。移动端与合作方 SDK 按公共 API 的版本发布；两个不隶属服务器团队的 worker 提供方按插件协议开发，协议兼容性单独验收；审计消费者按导出格式导入，更新周期不依赖 API 发布。它们都服务于同一任务产品，但这些消费方需要分别知道自己依赖的行为是否发生变化。目前接受的是 API v1、worker protocol v1 和 audit format v1。负责人还没选 HTTP 框架、数据库、队列或部署方式。

## 任务 API

- R01: 调用者只能读取和创建自己 tenant 的任务；跨 tenant 查询与不存在任务统一返回 404，不泄露存在性。
- R02: 创建需要 job_type 与 JSON payload；job_type 必须为租户允许的已注册类型，未知类型返回 422，不创建任务。
- R03: 创建请求必须带 1–128 个 ASCII 字符的 Idempotency-Key。缺失或不合格式返回 400，不产生任务。
- R04: 幂等范围是 tenant + key；同 key、同规范化请求在首次创建后 24 小时内重放，返回同 job_id 和原创建响应，不重复创建。不同 tenant 可独立使用同 key。
- R05: 同 key、不同请求在上述范围内返回 409。规范化请求按解析后的 JSON 结构比较，忽略对象键顺序，保留数组顺序；整数 1 与浮点 1.0 视为相同数字。
- R06: 状态为 queued、running、succeeded、failed、cancelled；后三者是终态，不允许回到非终态。
- R07: 首次创建为 queued。领取成功才进入 running。成功或不可重试失败进入相应终态。
- R08: 取消 queued 任务立即进入 cancelled；取消 running 任务只登记取消请求，在 worker 确认后进入 cancelled，不虚报已停止。
- R09: 取消请求与成功结果并发时，以服务端先成功提交的终态转换为准；后到结果不能改写终态。重复取消是幂等的。
- R10: 获取任务返回 job_id、job_type、state、created_at、updated_at、cancel_requested；终态失败另有 error_code，禁止返回 worker stack 或 credentials。
- R11: 列表按 created_at 降序、job_id 升序打破同时间平局；采用不透明 cursor，page_size 为 1–100。游标无效返回 400；不得混入其他 tenant 数据。
- R12: API v1 的幂等和终态行为需通过并发请求验收，单次 happy-path 示例不能作为全部验收。

## Worker 协议

- R13: 领取返回 job_id、attempt_id、lease_token、lease_expires_at、job_type 和 payload。attempt_id 在每次重新领取时改变。
- R14: lease 默认 60 秒；worker 每 20 秒心跳，成功心跳从服务端当前时间延长 60 秒。到期时刻及之后即失效。
- R15: 心跳和结果都必须携带 attempt_id 与 lease_token；不匹配或已过期返回 STALE_LEASE，不更新任务状态或结果。
- R16: lease 过期的非终态任务重新排队；旧 worker 的迟到成功不能盖过新 attempt 的状态。
- R17: 同一有效 attempt 的相同结果重复提交返回原确认；不同结果返回 RESULT_CONFLICT。确认丢失后的重试不能再次执行终态转换。
- R18: 至多 3 次领取，首次计入次数。第三次 lease 过期或可重试失败之后进入 failed，error_code 为 ATTEMPTS_EXHAUSTED，不再派发。
- R19: 可重试失败不直接发布终态；若仍有次数则返回 queued。不可重试失败立即 failed。
- R20: worker 收到 cancel_requested 后应停止工作并确认取消；确认使用当前有效 lease。无法证明旧 attempt 已停，不代表它仍有权提交结果。
- R21: 领取结果带 protocol_version=1；服务器拒绝不支持的协议版本，错误为 UNSUPPORTED_PROTOCOL，不改变任务。
- R22: 外部提供方用独立 conformance suite 验收协议：到期边界、迟到结果、重放、冲突和次数耗尽都必须覆盖，不能只测试服务器自带 worker。

## 审计导出

- R23: 已提交的创建、开始、取消请求和终态转换必须各有审计事件；失败事务不得产生看似已提交的事件。
- R24: 事件字段为 event_id、tenant_id、job_id、kind、occurred_at、tenant_sequence、actor_type、actor_id；occurred_at 为 UTC RFC3339，kind 属于已声明枚举。
- R25: tenant_sequence 在各 tenant 内严格递增；允许空洞，不允许重复或倒序。不同 tenant 的 sequence 不可比较。
- R26: format_version=1，导出为 UTF-8 JSON Lines，每行一个完整事件，以换行结束。禁止把 JSON 数组作为等价输出。
- R27: 请求从指定 tenant_sequence 之后导出，exclusive；每批最多 1000 条，返回 next_sequence。重复请求可重放相同历史事件，event_id 不改变。
- R28: 审计中不得包含 payload、lease_token、Idempotency-Key、credentials 或原始错误堆栈。只允许声明的审计字段。
- R29: 审计消费者不得读取其他 tenant 事件；不允许为了修复顺序问题全租户混合排序后暴露数据。
- R30: 审计格式的 golden 文件验收包括 Unicode、空批次、多个同时间事件、分页边界及敏感字段检查，不能用 API 状态测试代替格式验收。

## 一致性与范围

- R31: 在状态已向调用方显示提交时，对应审计事件必须可恢复；具体事务或 outbox 实现未决定，但不能接受静默丢审计的设计。
- R32: API 层不能把 expired lease 当成功结果；worker 层不能绕过 tenant 隔离；审计记录必须对应同一次已提交状态转换。
- R33: 服务重启后保留任务、幂等窗口和审计顺序；不得依赖进程内状态完成这些承诺。
- R34: worker 内部算法和部署拓扑不是当前公开契约。不得擅自增加消息中间件或数据库产品依赖作为已接受要求。
- R35: 本轮不包含计费、管理 GUI 或跨地域复制。
- R36: 开发分数次会话完成；API 消费方、worker 提供方和审计消费方分别验收自己的接口，再做跨边界的一致性验收。尚无任何实现符合性证据。
