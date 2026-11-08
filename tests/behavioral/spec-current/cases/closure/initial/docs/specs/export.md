# Export contract
导出为 UTF-8 JSON Lines，每行一个完整事件并以 LF 结束，空导出为零字节。每租户按 sequence 升序，恢复后不得丢已提交事件或重复 event_id。禁止包含 credentials。验收应覆盖 Unicode、空批次、顺序、恢复、重复及敏感字段。
