#!/bin/bash

# 检查参数数量，如果小于 1，就会输出 book.txt 文件内所存书目信息
if [ "$#" -lt 1 ]; then
  cat "book.txt"
  echo""
  exit 1
fi

# 提取操作选项
option="$1"
shift

# 提取书号
book_id="$1"

# 根据所输入选项执行相应操作
case "$option" in
  -a)
    # 检测是否存在所输书号判断是否添加书籍信息
    if grep -q "^$book_id:" books.txt; then
      echo "书号 $book_id 已存在。"
    else
      echo "$book_id:$2" >> books.txt
      echo "添加书籍信息成功。"
    fi
    ;;
  -d)
    # 删除书籍信息
    if grep -q "^$book_id:" books.txt; then
      read -p "确认要删除书号 $book_id 的记录吗？(y/n): " confirm
      if [ "$confirm" == "y" ] || [ "$confirm" == "yes" ]; then
        sed -i "/^$book_id:/d" books.txt
        echo "删除书籍信息成功。"
      else
        echo "删除操作已取消。"
      fi
    else
      echo "书号 $book_id 不存在。"
    fi
    ;;
  -s)
    # 搜索调用书籍信息
    if grep -q "^$book_id:" books.txt; then
      grep "^$book_id:" books.txt
    else
      echo "书号 $book_id 不存在。"
    fi
    ;;
  *)
    # 错误提示
    echo "错误: 无效的选项。"
    echo "用法: $0 [-a | -d | -s] 书号:书名:作者:类别"
    exit 1
    ;;
esac
