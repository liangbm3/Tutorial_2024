#!/bin/bash

BOOK_FILE="books.txt"

# 检查文件是否存在
if [ ! -f "$BOOK_FILE" ]; then
    echo "错误: 文件 $BOOK_FILE 不存在!"
    exit 1
fi

# 显示使用方法
usage() {
    echo "输入选项错误！"
    echo "使用方法:"
    echo "  $0                # 显示所有书籍记录"
    echo "  $0 -a 书号:书名:作者:类别  # 添加新的书籍记录"
    echo "  $0 -d 书号       # 删除指定书号的书籍记录"
    echo "  $0 -s 书号       # 查询指定书号的书籍记录"
    exit 1
}

# 如果没有参数，显示所有书籍记录
if [ $# -eq 0 ]; then
    cat "$BOOK_FILE"
    exit 0
fi

# 如果是 -a 参数，添加书籍
if [ "$1" == "-a" ]; then
    if [ $# -ne 2 ]; then
        usage
    fi
    
    NEW_BOOK="$2"
    BOOK_ID=$(echo "$NEW_BOOK" | cut -d':' -f1)
    
    # 检查书号是否已存在
    if grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        echo "错误: 书号 $BOOK_ID 已存在。"
        grep "^$BOOK_ID:" "$BOOK_FILE"
    else
        echo "$NEW_BOOK" >> "$BOOK_FILE"
        echo "书籍信息已添加：$NEW_BOOK"
    fi
    exit 0
fi

# 如果是 -d 参数，删除书籍
if [ "$1" == "-d" ]; then
    if [ $# -ne 2 ]; then
        usage
    fi
    
    BOOK_ID="$2"
    
    # 检查书号是否存在
    if ! grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        echo "错误: 书号 $BOOK_ID 不存在。"
    else
        echo "确认删除书号为 $BOOK_ID 的书籍记录? (y/n)"
        read CONFIRM
        if [[ "$CONFIRM" == "y" || "$CONFIRM" == "yes" ]]; then
            # 删除该行
            sed -i "/^$BOOK_ID:/d" "$BOOK_FILE"
            echo "书籍记录已删除。"
        else
            echo "操作已取消。"
        fi
    fi
    exit 0
fi

# 如果是 -s 参数，查询书籍
if [ "$1" == "-s" ]; then
    if [ $# -ne 2 ]; then
        usage
    fi
    
    BOOK_ID="$2"
    
    # 检查书号是否存在
    if ! grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
        echo "错误: 书号 $BOOK_ID 不存在。"
    else
        grep "^$BOOK_ID:" "$BOOK_FILE"
    fi
    exit 0
fi

# 如果没有匹配到任何有效的选项，显示使用方法
usage

