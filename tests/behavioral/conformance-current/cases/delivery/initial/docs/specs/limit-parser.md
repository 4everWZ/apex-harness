# LimitParser
parse_limit(value=None) 的已接受契约：缺失值 None 返回整数 30；显式值仅接受 5 至 120（含）的 Python int，bool 不算 int。其他类型或范围抛 ValueError。不得把字符串或浮点隐式转为整数。纯函数不修改任何输入或外部状态。
验收覆盖 None、5、120、4、121、True、字符串 "30" 与浮点 30.0；异常不能返回部分结果。

当前实现已提供，尚未执行本次验收；工作见[交付计划](../plans/delivery.md)。
