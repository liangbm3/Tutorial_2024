#!/bin/bash

BOOKS_FILE="books.txt"

# 显示所有书籍记录
list_books() {
    if [ -f "$BOOKS_FILE" ]; then
        cat "$BOOKS_FILE"
    else
        echo "书籍文件不存在。"
    fi
}

# 添加书籍记录
add_book() {
    local book_info="$1"
    local book_id=$(echo "$book_info" | cut -d':' -f1)
    
    if grep -q "^$book_id:" "$BOOKS_FILE"; then
        echo "书号 $book_id 已存在。"
        grep "^$book_id:" "$BOOKS_FILE"
    else
        echo "$book_info" >> "$BOOKS_FILE"
        echo "书籍已添加。"
    fi
}

# 删除书籍记录
delete_book() {
    local book_id="$1"
    
    if grep -q "^$book_id:" "$BOOKS_FILE"; then
        echo "确认删除书号 $book_id 的记录吗？(y/n)"
        read confirmation
        if [[ "$confirmation" == "y" || "$confirmation" == "yes" ]]; then
            grep -v "^$book_id:" "$BOOKS_FILE" > temp.txt && mv temp.txt "$BOOKS_FILE"
            echo "书籍已删除。"
        else
            echo "取消删除操作。"
        fi
    else
        echo "书号 $book_id 不存在。"
    fi
}

# 查找书籍记录
search_book() {
    local book_id="$1"
    
    if grep -q "^$book_id:" "$BOOKS_FILE"; then
        grep "^$book_id:" "$BOOKS_FILE"
    else
        echo "书号 $book_id 不存在。"
    fi
}

# 显示脚本使用方法
usage() {
    echo "使用方法: $0 [-a 书籍信息] [-d 书号] [-s 书号]"
    echo "  -a  添加书籍信息，格式为 书号:书名:作者:类别"
    echo "  -d  删除书籍记录，参数为书号"
    echo "  -s  查找书籍记录，参数为书号"
}

# 主逻辑
if [ $# -eq 0 ]; then
    list_books
else
    case "$1" in
        -a)
            if [ -n "$2" ]; then
                add_book "$2"
            else
                echo "缺少书籍信息。"
                usage
            fi
            ;;
        -d)
            if [ -n "$2" ]; then
                delete_book "$2"
            else
                echo "缺少书号。"
                usage
            fi
            ;;
        -s)
            if [ -n "$2" ]; then
                search_book "$2"
            else
                echo "缺少书号。"
                usage
            fi
            ;;
        *)
            echo "无效的选项。"
            usage
            ;;
    esac
fi