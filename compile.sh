# vim: set foldmethod=marker  foldlevel=0: vim modeline( set )

filter-package() {
    # {{{
    listTxt=./ubuntu-essential-list.txt

    # 第一行过滤注释
    # 第二行过滤空白行
    # 第三行输出包名
    egrep -v '^ *#' ${listTxt}   -v \
         | grep -e "^$" -v          \
         | awk '{print $1}'
    # }}}
}

getCmakeList() {
    # {{{
    pkgs=$(filter-package)
    pkgCnts=$(filter-package | wc -l)

    echo
    echo "note: there are  ${pkgCnts} packages is essential!!!"  1>&2
    echo

    echo -n 'set(CPACK_DEBIAN_PACKAGE_DEPENDS "'

    i=0         # 为了最后一个列表, 不要输出","
    for pkgName in $pkgs ; do
        echo -n  "$pkgName"

        let "i = i + 1"
        if [ $i != $pkgCnts ] ; then       # 不是最后一个软件时, 才在软件包名后面输入",".
            echo -n  ", "
        fi
    done

    echo '" )'
    # }}}
}

function  successMsg {
# {{{
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
     SETCOLOR_NORMAL="echo -en \\033[0;39m"     # 之后的颜色恢复正常

    #echo $1  &&  $SETCOLOR_FAILURE
    $SETCOLOR_SUCCESS && echo $1        # 先设置颜色, 再输出信息
    $SETCOLOR_NORMAL                    # 之后的颜色要正常才可以
# }}}
}

# 编译在build生成 package
compile() {
    # {{{
    local pkgListCmake="pkgLists.cmake"            # 定义包含package list的cmake file的名字, 被CMakeLists.txt include
    getCmakeList > $pkgListCmake             # 这里直接覆盖pkgLists.cmake的内容. 注意不是追加">>".

    local buildDir="./build"

    # 清空build/, build/下包含编译缓存信息.
    # 然后进入build编译package
    # 最后返回build上层目录. 即compile.sh所在目录.
    rm ${buildDir}/* -rf &&  \
         cd ${buildDir}/ &&  \
         cmake ../       &&  \
         make package    &&
         cd ../

    local packageName="$(ls  ${buildDir}/*deb)"

    echo && echo && echo        # 输出三行空白, 用以展现以下输出.

    echo -n "You have built package  "
    successMsg  "${packageName}"        # 给用户输出编译产生的包名.

    # }}}
}

compile
