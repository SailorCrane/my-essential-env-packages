# vim: set foldmethod=marker  foldlevel=2: vim modeline( set )

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

# 编译在build生成 package
compile() {
    # {{{
    pkgListCmake="pkgLists.cmake"            # 定义包含package list的cmake file的名字, 被CMakeLists.txt include
    getCmakeList > $pkgListCmake             # 这里直接覆盖pkgLists.cmake的内容. 注意不是追加">>".

    rm build/* -rf                           # 清空build/, build/下包含编译缓存信息.
    cd build/ && cmake ../ && make package   # 进入build编译.
    cd ../
    # }}}
}

compile
