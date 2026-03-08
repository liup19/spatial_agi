#!/bin/bash
# NotebookLM Cookies Manager Wrapper
# 从spatial_agi根目录快速调用cookies管理

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANAGER_DIR="$SCRIPT_DIR/notebooklm_manager"

# 直接调用主管理器
bash "$MANAGER_DIR/notebooklm_cookies_manager.sh" "$@"
