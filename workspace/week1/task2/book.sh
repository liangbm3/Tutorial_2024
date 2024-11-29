#!/bin/bash

# $0 是脚本的名称，$# 是传入的参数数量，$1 是第一个参数，$BOOK_ID 是变量BOOK_ID的内容
# 定义书籍文件路径
BOOK_FILE="books.txt"

# 检查文件是否存在，如果不存在则用touch创建一个空文件
if [ ! -f "$BOOK_FILE" ]; then
    touch "$BOOK_FILE"
fi

# 使用方法，在用户输入参数错误时显示
usage() {
    echo "Usage: $0 [-a book_info] [-d book_id] [-s book_id]"
    echo "  -a  添加新书籍，格式: 书号:书名:作者:类别"
    echo "  -d  删除书籍，需要提供书号"
    echo "  -s  搜索书籍，需要提供书号"
    echo "  无参数  显示所有书籍"
}

# 没有参数
if [ $# -eq 0 ]; then
    cat "$BOOK_FILE"
else
    case $1 in
        -a)
            # 添加书籍
            BOOK_INFO=$2
            BOOK_ID=$(echo $BOOK_INFO | cut -d':' -f1)
            if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
                echo "书号 $BOOK_ID 已存在！"
                grep "^$BOOK_ID:" "$BOOK_FILE"
            else
                echo "$BOOK_INFO" >> "$BOOK_FILE"
                echo "书籍已添加：$BOOK_INFO"
            fi
            ;;
        -d)
            # 删除书籍
            BOOK_ID=$2
            if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
                read -p "确认要删除书号为 $BOOK_ID 的书籍吗？(y/n): " CONFIRM
                if [[ "$CONFIRM" =~ ^[Yy][Ee][Ss]|[Yy]$ ]]; then
                    sed -i "/^$BOOK_ID:/d" "$BOOK_FILE"
                    echo "书籍已删除：书号 $BOOK_ID"
                else
                    echo "取消删除操作。"
                fi
            else
                echo "书号 $BOOK_ID 不存在！"
            fi
            ;;
        -s)
            # 搜索书籍
            BOOK_ID=$2
            if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
                grep "^$BOOK_ID:" "$BOOK_FILE"
            else
                echo "书号 $BOOK_ID 不存在！"
            fi
            ;;
        *)
            # 错误参数
            usage
            ;;
    esac
fi
