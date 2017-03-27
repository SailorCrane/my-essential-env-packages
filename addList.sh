function  filter-package {
    listTxt=./ubuntu-essential-list.txt

    # 第一行过滤注释
    # 第二行过滤空白行
    # 第三行输出包名
    grep -v -E '^ *#' ${listTxt}   -v \
         | grep -e "^$" -v            \
         | awk '{print $1}'
}

function GetAddList {
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
        if [ $i != $pkgCnts ] ; then       # 不是最后一个软件时, 才输出逗号.
            echo -n  ", "
        fi
    done

    echo '" )'

}


GetAddList > pkgLists.cmake         # 这里直接覆盖pkgLists.cmake的内容

#list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS "vim-gnome")      # 使用list append, 避免参数挤在一起.
