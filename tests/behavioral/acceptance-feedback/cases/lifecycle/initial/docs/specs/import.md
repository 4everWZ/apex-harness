# Import contract
接受严格 UTF-8 JSON Lines，每行一个事件，空文件导入零项；非法行使整次调用报 INVALID_INPUT，不产生部分状态。
当前非空 ASCII 示例已验证，Unicode 与空输入尚未验收；见[当前验收](../acceptance/import.md)。
