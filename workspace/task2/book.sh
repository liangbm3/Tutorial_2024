#!/bin/bash

BOOK_FILE="./book.txt"
USAGE="用法: $0 [-a \"书号:书名:作者:类别\"] | [-d 书号] | [-s 书号]"

if [ $# -eq 0 ]; then
    # 列出所有书籍
    cat "$BOOK_FILE"
    exit 0
fi

if [ "$1" = "-a" ]; then
    # 添加书籍
    BOOK_INFO="$2"
    if [ -z "$BOOK_INFO" ]; then
        echo "错误：未提供书籍信息。"
        echo "$USAGE"
        exit 1
    fi
    BOOK_ID=$(echo "$BOOK_INFO" | cut -d':' -f1)
    if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        echo "书号 $BOOK_ID 已存在："
        grep "^$BOOK_ID:" "$BOOK_FILE"
    else
        echo "$BOOK_INFO" >> "$BOOK_FILE"
        echo "已添加书籍：$BOOK_INFO"
    fi
elif [ "$1" = "-d" ]; then
    # 删除书籍
    BOOK_ID="$2"
    if [ -z "$BOOK_ID" ]; then
        echo "错误：未提供书号。"
        echo "$USAGE"
        exit 1
    fi
    if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        echo -n "确认删除书号 $BOOK_ID 的记录吗？(y/yes 或 n/no): "
        read CONFIRM
        if [[ "$CONFIRM" == "y" || "$CONFIRM" == "yes" ]]; then
            grep -v "^$BOOK_ID:" "$BOOK_FILE" > temp && mv temp "$BOOK_FILE"
            echo "已删除书号 $BOOK_ID 的记录。"
        else
            echo "已取消删除操作。"
        fi
    else
        echo "书号 $BOOK_ID 不存在。"
    fi
elif [ "$1" = "-s" ]; then
    # 查询书籍
    BOOK_ID="$2"
    if [ -z "$BOOK_ID" ]; then
        echo "错误：未提供书号。"
        echo "$USAGE"
        exit 1
    fi
    if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        grep "^$BOOK_ID:" "$BOOK_FILE"
    else
        echo "书号 $BOOK_ID 不存在。"
    fi
else
    # 错误的选项
    echo "错误的选项。"
    echo "$USAGE"
    exit 1
fi