#!/bin/bash

if [ $# -eq 0 ];then #如果没有参数传入，则列出所有图书
    cat books.txt
fi

operation=$1
shift

if [ "$operation" = "-a" ];then
    new_book_info=$*
    new_book_number=$(echo $new_book_info | cut -d: -f1)
    #获得new_book_info并从中提取出new_bokk_number
    if grep -q "^$new_book_number:" books.txt;then #添加书籍
        echo "The book has existed and its info is as followed:"
        grep "^$new_book_number:" books.txt
    else
        echo $new_book_info >> books.txt
        echo "The book is added successfully."
    fi
elif [ "$operation" = "-d" ];then #删除书籍
    book_to_delete_number=$*
    if grep -q "^$book_to_delete_number:" books.txt;then
        echo "Are you sure to DELETE it?(y/n)"
        read confirmation #寻求确定
        if [ "$confirmation" = "y" ] || [ "$confirmation" = "yes" ] || [ "$confirmation" = "Y" ];then
            sed -i "/^$book_to_delete_number:/d" books.txt
            echo "It was deleted seccessfully."
        else
            echo "The delete operation was stoped."
        fi
    else 
        echo "The book does not exist and delete operation fails."
    fi
elif [ "$operation" = "-s" ];then #搜索
    book_to_search_number=$*
    if grep -q "^$book_to_search_number:" books.txt;then
        echo "The book exists and its info is as followed."
        grep "^$book_to_search_number:" books.txt
    else
        echo "The book does not exist." 
    fi
elif [ "$operation" != "" ];then #不合法的输入时，提示该脚本的规范输入
    echo "Your operation is wrong and the right one is as followed"
    echo "book.sh,which means listing all info of books"
    echo "book.sh -a [new_book_number:new_book_name:new_book_author:new_book_type],which means adding "
    echo "book.sh -d [book_to_delete_number],which means deleting the info of the book"
    echo "book.sh -d [book_to_search_number],which means searching the info of the book"
fi
#写代码的时候，linux还没下中文，所以回应都是蹩脚的英文，应该没关系吧