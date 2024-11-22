#!/bin/bash

# 文件名：book.sh

# 定义书籍信息文件
BOOK_FILE="books.txt"

# 显示所有书籍信息
list_books() {
    echo "所有书籍的记录内容："
    cat "$BOOK_FILE"
}

# 添加书籍信息
add_book() {
    local book_info="$1"
    local book_id=$(echo "$book_info" | cut -d':' -f1)
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录已存在。"
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "$book_info" >> "$BOOK_FILE"
        echo "书籍信息已添加。"
    fi
}

# 删除书籍信息
delete_book() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录存在。"
        read -p "是否要删除该记录？(y/n): " confirm
        if [[ $confirm =~ ^[Yy]?es$ ]]; then
            grep -v "^$book_id:" "$BOOK_FILE" > temp && mv temp "$BOOK_FILE"
            echo "记录已删除。"
        else
            echo "删除操作已取消。"
        fi
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# 搜索书籍信息
search_book() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# 检查参数并执行相应的函数
case "$1" in
    "")
        list_books
        ;;
    "-a")
        if [ $# -eq 2 ]; then
            add_book "$2"
        else
            echo "错误：添加书籍信息时需要提供完整的书籍信息。"
            echo "使用方法："
            echo "  $0 -a <书号:书名:作者:类别>"
        fi
        ;;
    "-d")
        if [ $# -eq 2 ]; then
            delete_book "$2"
        else
            echo "错误：删除书籍信息时需要提供书号。"
            echo "使用方法："
            echo "  $0 -d <书号>"
        fi
        ;;
    "-s")
        if [ $# -eq 2 ]; then
            search_book "$2"
        else
            echo "错误：搜索书籍信息时需要提供书号。"
            echo "使用方法："
            echo "  $0 -s <书号>"
        fi
        ;;
    *)
        echo "错误：未知参数。"
        echo "使用方法："
        echo "  $0                 列出所有书籍信息"
        echo "  $0 -a <书号:书名:作者:类别>  添加书籍信息"
        echo "  $0 -d <书号>        删除书籍信息"
        echo "  $0 -s <书号>        搜索书籍信息"
        ;;
esac
