# Local runner
运行：python runner.py --input PATH --output PATH。输入是 UTF-8 JSON Lines；输出不能覆盖已有文件。exit 0 成功，exit 2 为参数或输入格式错误，stderr 提供原因；失败不产生输出文件。无网络，无第三方依赖。
