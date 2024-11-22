## Tips
### 在开始完成考核任务之前，首先确保你正处在你的名字对应的分支下！！！

### main分支是用来发布考核任务的，请不要在该分支下进行答题，否则将不予合并，考核成绩无效

### 我们会对参与考核的你们建立属于你们的分支，然后你们只需在各自的分支下的workspace中上传你们的考核任务即可
### 以下是对该文件夹的说明，请认真阅读
*****

这里是你的工作空间，你可以自由管理所有的内容。关于目录管理你可以仿照tasks的结构分别创建文件夹以分割各周的任务，你也可以以文本，代码等结构，类似于工程搭建式的。无论你选择什么方式，最重要的是清晰的目录结构让考评者能够非常便捷的了解你的工作。 

关于内容，由于github有上传大小的限制，你不需要上传已经生成的可执行文件或者比较大的文件输出结构，只用将工程代码上传，并在报告文档中将运行过程做一个简单的解释。如果涉及到包版本问题，你也可以将你对应版本做一个阐述。 

如果你在后续的方法中有用到诸如深度学习等需要大批量 数据的内容，你可以将数据内容上传至百度网盘并在报告中给出分享链接即可。

该空间完全自由，期待你的发挥 QAQ!

#### week 1
|task|complete|
|:---|:--:|
|1|yes|
|2|yes|
|3|not|

##### task1
代码示例：
```cpp
#include <iostream>
using namespace std;

// 函数计算斐波那契数列的第 n 项
int fibonacci(int n) {
    if (n == 0) return 0; // 处理 F(0)
    if (n == 1) return 1; // 处理 F(1)
    
    // 定义变量保存前两项
    int prev1 = 0, prev2 = 1;
    int current;
    
    // 自底向上计算斐波那契数列
    for (int i = 2; i <= n; ++i) {
        current = prev1 + prev2; // 当前项
        prev1 = prev2;           // 更新前一项
        prev2 = current;         // 更新当前项
    }
    
    return current;
}

int main() {
    int n;
    cout << "输入 n (0 <= n <= 50): ";
    cin >> n;

    if (n < 0 || n > 50) {
        cout << "输入的 n 超出范围。" << endl;
        return 1;
    }

    // 调用函数并输出结果
    cout << "斐波那契数列的第 " << n << " 项是: " << fibonacci(n) << endl;

    return 0;
}
```

linux终端界面和cmake、makefile的编译示例：

![linux图形界面示例](https://github.com/nulidedoupier/Tutorial_2024/blob/main/workspace/image/1.png)
![linux编译程序示例1]
![linux编译程序示例2]
![linux编译程序示例3]

##### task2
代码示例：
```sh
#!/bin/bash

# 文件名
FILE="books.txt"

# 用法提示
usage() {
  echo "Usage:"
  echo "  book.sh                  列出所有书籍的记录"
  echo "  book.sh -a 书号:书名:作者:类别  添加新书籍记录"
  echo "  book.sh -d 书号             删除指定书号的记录"
  echo "  book.sh -s 书号             查找并显示指定书号的记录"
}

# 检查文件是否存在，如果不存在则创建
if [ ! -f "$FILE" ]; then
  touch "$FILE"
fi

# 列出所有书籍记录
if [ $# -eq 0 ]; then
  cat "$FILE"
  exit 0
fi

# 处理不同的选项
case $1 in
  -a)
    # 添加书籍记录
    if [ $# -eq 2 ]; then
      IFS=":" read -r book_id book_name book_author book_category <<< "$2"
      if grep -q "^$book_id:" "$FILE"; then
        echo "书号 $book_id 已存在，信息如下："
        grep "^$book_id:" "$FILE"
      else
        echo "$2" >> "$FILE"
        echo "书籍记录已添加：$2"
      fi
    else
      echo "错误：参数不足，请提供书籍信息。"
      usage
    fi
    ;;

  -d)
    # 删除书籍记录
    if [ $# -eq 2 ]; then
      book_id="$2"
      if grep -q "^$book_id:" "$FILE"; then
        echo "找到书号 $book_id 的记录："
        grep "^$book_id:" "$FILE"
        echo -n "确认删除记录？(y/n): "
        read -r confirm
        if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
          sed -i "/^$book_id:/d" "$FILE"
          echo "书号 $book_id 的记录已删除。"
        else
          echo "操作已取消。"
        fi
      else
        echo "错误：书号 $book_id 不存在。"
      fi
    else
      echo "错误：参数不足，请提供书号。"
      usage
    fi
    ;;

  -s)
    # 查找书籍记录
    if [ $# -eq 2 ]; then
      book_id="$2"
      if grep -q "^$book_id:" "$FILE"; then
        echo "找到书号 $book_id 的记录："
        grep "^$book_id:" "$FILE"
      else
        echo "错误：书号 $book_id 不存在。"
      fi
    else
      echo "错误：参数不足，请提供书号。"
      usage
    fi
    ;;

  *)
    # 其他错误输入
    echo "错误：无效的选项 $1"
    usage
    ;;
esac
```
![编译图书管理代码示例](https://github.com/nulidedoupier/Tutorial_2024/blob/main/workspace/image/2.1.png)
![编译图书管理终端界面及测试示例](https://github.com/nulidedoupier/Tutorial_2024/blob/main/workspace/image/2.png)

##### task3
由于无法连接到github上传输软件源，下载多次失败，进度截止到ros的更新安装，这是目前的一些进度照片

![进度]()


