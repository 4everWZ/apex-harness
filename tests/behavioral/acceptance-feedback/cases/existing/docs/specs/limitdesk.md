# LimitDesk contract
parse_limit 的 None 默认 30；仅接受 5..120（含）的 Python int，bool 不算 int。其他类型或越界值抛 ValueError，不做隐式字符串/浮点转换；函数无 I/O 或外部状态变更。验收覆盖 None、5、120、4、121、True、"30"、30.0。
当前实现与验收结论见[既有验收记录](../../quality/current.md)，本轮尚待核对。
