#!/bin/bash

BOOKS_FILE="books.txt"

usage() {
    echo "Usage:"
    echo " book.sh  -->  列出所有书籍记录"
    echo " book.sh -a  -->  添加书"
    echo " book.sh -d  -->  删除书"
    echo " book.sh -s  -->  查找对应书号的书籍信息"
}

if [ ! -f "$BOOKS_FILE" ];
then
    echo "错误：文件 $BOOKS_FILE 不存在！"
    exit 1
fi

if [ "$1" == "" ]
then 
    cat "$BOOKS_FILE"
elif [ "$1" == "-a" ]
then
    if [ -z "$2" ]
    then 
        echo "错误：没有正确输入要添加的书籍信息"
        usage
        exit 1
    fi
    IFS=":" read -r book_id title author category <<< "$2"
    if grep -q "^$book_id:" "$BOOKS_FILE"
    then
        echo "书号 $book_id 已存在"
        grep "^$book_id:" "$BOOKS_FILE"
    else
        echo "$2" >> "$BOOKS_FILE"
    fi
elif [ "$1" == "-d" ]
then
    if [ -z "$2" ]
    then 
        echo "错误：没有正确输入书号"
        usage
        exit 1
    elif grep -q "^$2:" "$BOOKS_FILE"
    then
        echo "确认删除书号为 $2 的书籍信息吗？ (y/n)"
        read -r confirm
        if [ "$confirm" == y ]
        then
            grep -v "^$2:" "$BOOKS_FILE" > tmpfile && mv tmpfile "$BOOKS_FILE"
        fi
    fi
elif [ "$1" == "-s" ]
then
    if [ -z "$2" ]
    then
        echo "错误：没有正确输入书号"
        usage
        exit 1
    elif grep -r "^$2:" "$BOOKS_FILE"
    then
        grep "^$2:" "$COOKS_FILE"
    else
        echo "找不到书号 $2 的信息"
    fi
else
    usage
    exit 1
fi
