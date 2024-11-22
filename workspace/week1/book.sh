#!/bin/bash

# 定义书籍记录文件
BOOK_FILE="books.txt"

# 显示使用方法
usage() {
    echo "用法: $0 [option] [parameters]"
    echo "选项:"
    echo "  space              列出所有书籍记录"
    echo "  -a <book_id> <book_name> <author>   添加书籍记录"
    echo "  -d <book_id>   删除书籍记录"
    echo "  -s <book_id>   搜索书籍记录"
    echo "  -h              显示帮助信息"
}

# 列出所有书籍记录
list_books() {
    if [ -f "$BOOK_FILE" ]; then
        cat "$BOOK_FILE"
    else
        echo "没有书籍记录。"
    fi
}

# 添加书籍记录
add_book() {
    local book_id="$1"
    local book=${book_id%%:*}
    if grep -q "^$book" "$BOOK_FILE"; then
        echo "书号$book已存在，记录为："
        grep  "^$book" "$BOOK_FILE"
    else
        echo "$book_id" >> "$BOOK_FILE"
        echo "书号 $book 添加成功。"
    fi
}

# 删除书籍记录
delete_book() {
    local book_id="$1"

    if grep -q "^$book_id" "$BOOK_FILE"; then
        echo "确定删除书号为 $book_id 的书籍记录吗？(y/n)"
        read -r confirm
        if [[ "$confirm" == "y" || "$confirm" == "yes"  ]]; then
            grep -v "^$book_id" "$BOOK_FILE" > "$BOOK_FILE.tmp" && mv "$BOOK_FILE.tmp" "$BOOK_FILE"
            echo "书籍记录删除成功。"
        else
            echo "删除操作已取消。"
        fi
    else
        echo "书号 $book_id 不存在。"
    fi
}

# 搜索书籍记录
search_book() {
    local book_id="$1"

    if grep -q "^$book_id" "$BOOK_FILE"; then
        echo "找到书籍记录："
        grep "^$book_id" "$BOOK_FILE"
    else
        echo "书号 $book_id 不存在。"
    fi
}

# 主程序逻辑
if [ $# -eq 0 ]; then
     list_books 
       	exit 1
fi

case "$1" in
    -l)
        list_books
        ;;
    -a)
        if [ $# -ne 2 ]; then
            echo "错误: 添加书籍需要书号、书名和作者。"
            usage
            exit 1
        fi
        add_book "$2"
        ;;
    -d)
        if [ $# -ne 2 ]; then
            echo "错误: 删除书籍需要书号。"
            usage
            exit 1
        fi
        delete_book "$2"
        ;;
    -s)
        if [ $# -ne 2 ]; then
            echo "错误: 搜索书籍需要书号。"
            usage
            exit 1
        fi
        search_book "$2"
        ;;
    -h)
        usage
        ;;
    *)
        echo "错误: 无效选项 '$1'。"
        usage
        exit 1
        ;;
esac

