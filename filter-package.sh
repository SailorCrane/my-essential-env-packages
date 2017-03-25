listTxt=./ubuntu-essential-list.txt

grep -v -E '^ *#' ${listTxt}   -v \
     | grep -e "^$" -v            \
     | awk '{print $1}'

# 第一行过滤注释
# 第二行过滤空白行
# 第三行输出包名
