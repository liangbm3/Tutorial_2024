#-----------------------------------------------------------------------
# FileName：book.sh
# Author: @Ethan-Zhengsy
# Version: 1.0.0
# Date: 2024.11.19
#-----------------------------------------------------------------------
# Discription: 
#   当输入 book.sh 时，列出文件中所有书籍的记录内容。
#   当输入 book.sh -a 2001:Python编程:张三:计算机科学 时，
#           首先判断 2001 书号记录是否存在，
#               如果不存在，则将该信息写入文件；
#               如果存在，则给出提示，并输出文件中书号为 2001 的该行信息。
#   当输入 book.sh -d 2001 时，
#           首先判断 2001 书号记录是否存在，
#               如果不存在，则给出提示；
#               如果存在，则提示用户确认是否要删除记录。
#                   若用户输入 y 或 yes，则删除文件中书号为 2001 的该行信息；
#                   若用户输入 n 或 no，则不做删除操作。
#   当输入 book.sh -s 2001 时，
#           首先判断 2001 书号记录是否存在，
#               如果不存在，给出提示；
#               如果存在，则输出文件中书号为 2001 的该行信息。 
#   当用户输入的选项不正确时，给出错误提示，并显示脚本的使用方法。
#------------------------------------------------------------------------


#!/bin/bash

# 定义书籍信息文件
BOOK_FILE="books.txt"

# 检查文件是否存在
if [ ! -f "$BOOK_FILE" ]; then
    echo "书籍信息文件不存在。"
    exit 1
fi

# @brief 列出所有书籍记录
listBooks() {
    echo "文件中所有书籍的记录内容："
    cat "$BOOK_FILE"
}

# @brief 添加书籍记录
addBook() {
    local book_info="$1"
    local book_id=$(echo "$book_info" | cut -d':' -f1)
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录已存在。"
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "$book_info" >> "$BOOK_FILE"
        echo "书号为 $book_id 的记录已添加。"
    fi
}

# @brief 删除书籍记录
deleteBook() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录存在。"
        read -p "是否要删除记录？(y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
            sed -i "/^$book_id:/d" "$BOOK_FILE"
            echo "书号为 $book_id 的记录已被删除。"
        else
            echo "操作已取消。"
        fi
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# @brief 搜索书籍记录
searchBook() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# 主函数
main() {
    if [ $# -eq 0 ]; then
        listBooks
    elif [ "$1" == "-a" ] && [ $# -eq 2 ]; then
        addBook "$2"
    elif [ "$1" == "-d" ] && [ $# -eq 2 ]; then
        deleteBook "$2"
    elif [ "$1" == "-s" ] && [ $# -eq 2 ]; then
        searchBook "$2"
    else
        echo "错误：不正确的参数。"
        echo "使用方法："
        echo "  $0                 列出所有书籍记录"
        echo "  $0 -a <book_info>  添加书籍记录，格式：书号:书名:作者:类别"
        echo "  $0 -d <book_id>    删除书号为 <book_id> 的记录"
        echo "  $0 -s <book_id>    搜索书号为 <book_id> 的记录"
    fi
}

# 执行主函数
main "$@"