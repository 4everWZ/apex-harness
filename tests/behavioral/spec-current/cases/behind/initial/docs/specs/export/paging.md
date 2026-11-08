# Paging contract
每页最多 50 条，cursor 是 tenant-scoped 且 exclusive。非法 cursor 返回 INVALID_CURSOR，不输出部分行。相同历史事件的 event_id 在重放时不变。
验收覆盖页上限、下一页无重复、租户隔离、非法 cursor 原子性及重放。
