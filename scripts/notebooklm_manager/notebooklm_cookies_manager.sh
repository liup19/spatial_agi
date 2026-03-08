#!/bin/bash
# NotebookLM Cookies 自动化管理器
# 用途：检测、备份、恢复、刷新cookies的统一入口

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONDA_ENV="spatial-agi"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() { echo -e "${BLUE}ℹ ${NC}$1"; }
print_success() { echo -e "${GREEN}✅ ${NC}$1"; }
print_warning() { echo -e "${YELLOW}⚠️  ${NC}$1"; }
print_error() { echo -e "${RED}❌ ${NC}$1"; }

# 显示帮助信息
show_help() {
    cat << EOF
NotebookLM Cookies 自动化管理器

用法: $(basename "$0") [命令]

命令:
    check       检测cookies是否有效
    backup      备份当前cookies
    restore     从备份恢复cookies
    refresh     从浏览器刷新cookies
    auto        自动检测并恢复（推荐用于定时任务）
    status      显示cookies状态和备份信息
    help        显示此帮助信息

示例:
    $(basename "$0") check        # 检测cookies
    $(basename "$0") auto         # 自动管理
    $(basename "$0") backup       # 手动备份

环境变量:
    COOKIES_FILE    Cookies文件路径（默认: ~/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json）
    BACKUP_DIR      备份目录（默认: ~/.notebooklm-mcp-cli/backups）
    MAX_BACKUPS     最大备份数量（默认: 10）

EOF
}

# 检测cookies
check_cookies() {
    print_info "检测NotebookLM cookies..."
    
    if bash "$SCRIPT_DIR/check_cookies.sh"; then
        print_success "Cookies有效"
        return 0
    else
        print_error "Cookies无效或已过期"
        return 1
    fi
}

# 备份cookies
backup_cookies() {
    print_info "备份cookies..."
    bash "$SCRIPT_DIR/backup_cookies.sh"
}

# 恢复cookies
restore_cookies() {
    print_info "从备份恢复cookies..."
    bash "$SCRIPT_DIR/restore_cookies.sh"
}

# 刷新cookies
refresh_cookies() {
    print_info "从浏览器刷新cookies..."
    bash "$SCRIPT_DIR/refresh_cookies.sh"
}

# 自动管理（检测 -> 尝试恢复 -> 如果失败提示刷新）
auto_manage() {
    print_info "自动管理NotebookLM cookies..."
    echo ""
    
    # Step 1: 检测cookies
    if check_cookies; then
        echo ""
        print_success "Cookies状态良好，无需操作"
        
        # 可选：自动备份（每周一次）
        LAST_BACKUP=$(ls -1t ~/.notebooklm-mcp-cli/backups/notebooklm_cookies_* 2>/dev/null | head -1)
        if [ -n "$LAST_BACKUP" ]; then
            BACKUP_AGE=$((($(date +%s) - $(stat -c %Y "$LAST_BACKUP" 2>/dev/null || stat -f %m "$LAST_BACKUP")) / 86400))
            if [ "$BACKUP_AGE" -gt 7 ]; then
                echo ""
                print_warning "上次备份已超过7天，执行自动备份..."
                backup_cookies
            fi
        fi
        
        return 0
    fi
    
    # Step 2: Cookies无效，尝试恢复
    echo ""
    print_warning "Cookies已失效，尝试从备份恢复..."
    
    if restore_cookies; then
        print_success "恢复成功"
        return 0
    fi
    
    # Step 3: 恢复失败，需要手动刷新
    echo ""
    print_error "自动恢复失败，需要手动刷新cookies"
    echo ""
    echo "请执行以下命令手动刷新:"
    echo "  $(basename "$0") refresh"
    echo ""
    echo "或者直接运行:"
    echo "  bash $SCRIPT_DIR/refresh_cookies.sh"
    
    return 1
}

# 显示状态
show_status() {
    COOKIES_FILE="${COOKIES_FILE:-$HOME/.notebooklm-mcp-cli/notebooklm.google.com_cookies.json}"
    BACKUP_DIR="${BACKUP_DIR:-$HOME/.notebooklm-mcp-cli/backups}"
    
    echo "📊 NotebookLM Cookies 状态"
    echo "================================"
    echo ""
    
    # Cookies文件信息
    echo "📄 Cookies文件:"
    if [ -f "$COOKIES_FILE" ]; then
        FILE_SIZE=$(du -h "$COOKIES_FILE" | cut -f1)
        FILE_TIME=$(stat -c %y "$COOKIES_FILE" 2>/dev/null || stat -f "%Sm" "$COOKIES_FILE")
        echo "   路径: $COOKIES_FILE"
        echo "   大小: $FILE_SIZE"
        echo "   修改: $FILE_TIME"
    else
        echo "   状态: ❌ 文件不存在"
    fi
    echo ""
    
    # 认证状态
    echo "🔐 认证状态:"
    if check_cookies 2>/dev/null; then
        echo "   状态: ✅ 有效"
    else
        echo "   状态: ❌ 无效或已过期"
    fi
    echo ""
    
    # 备份信息
    echo "💾 备份信息:"
    if [ -d "$BACKUP_DIR" ]; then
        BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/notebooklm_cookies_* 2>/dev/null | wc -l)
        echo "   目录: $BACKUP_DIR"
        echo "   数量: $BACKUP_COUNT 个备份"
        
        if [ "$BACKUP_COUNT" -gt 0 ]; then
            echo ""
            echo "   最新备份:"
            ls -lht "$BACKUP_DIR"/notebooklm_cookies_* 2>/dev/null | head -3 | awk '{print "     " $9 " (" $5 " bytes, " $6 " " $7 ")"}'
        fi
    else
        echo "   状态: ❌ 备份目录不存在"
    fi
    echo ""
    
    # Conda环境
    echo "🐍 Conda环境:"
    echo "   环境名: $CONDA_ENV"
    if conda env list | grep -q "^$CONDA_ENV "; then
        echo "   状态: ✅ 已创建"
    else
        echo "   状态: ❌ 未创建"
    fi
    echo ""
}

# 主函数
main() {
    case "${1:-help}" in
        check)
            check_cookies
            ;;
        backup)
            backup_cookies
            ;;
        restore)
            restore_cookies
            ;;
        refresh)
            refresh_cookies
            ;;
        auto)
            auto_manage
            ;;
        status)
            show_status
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "未知命令: $1"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 运行主函数
main "$@"
