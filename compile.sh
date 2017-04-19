# vim: set foldmethod=marker  foldlevel=0: vim modeline( set )

function  successMsg {
# {{{
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
     SETCOLOR_NORMAL="echo -en \\033[0;39m"     # 之后的颜色恢复正常

    #echo $1  &&  $SETCOLOR_FAILURE
    $SETCOLOR_SUCCESS && echo $1        # 先设置颜色, 再输出信息
    $SETCOLOR_NORMAL                    # 之后的颜色要正常才可以
# }}}
}

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

# 转换为小写
sh_tolower() {
    echo $1 | tr '[A-Z]'  '[a-z]'
}


sh_toupper() {
    echo $1 | tr '[a-z]'  '[A-Z]'
}

# output  rpm or deb
get-PackageSuffix() {
    # {{{
    local packSuffix="deb"        # 默认是DEB类型

    if [ $# == 1 ]; then
        packSuffix=$(sh_tolower ${1})
    fi

    echo  "${packSuffix}"
    # }}}
}

#
getCmakeType() {
    # {{{
        packType=$(sh_toupper ${1})
        echo  "set(CPACK_GENERATOR \"${packType}\")"
        echo
    # }}}
}

getCmakeList() {
    # {{{
    pkgs=$(filter-package)
    pkgCnts=$(filter-package | wc -l)

    echo    1>&2
    successMsg  "note: there are  ${pkgCnts} packages is setting in your essential-list.txt !!!"  1>&2
    echo    1>&2

    #get-packageType-cmake  $*       # 由get-packageType-cmake 来处理参数

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
# example1: compile     # default is DEB
# example2: compile  rpm
# example3: compile  deb
compile() {
    # {{{
    local UsageMsg1="Usage: ./compile.sh [rpm/RPM/deb/Deb/DEB]"     # default is DEB
    local UsageMsg2="Example: ./compile.sh rpm"     # default is DEB
    successMsg "$UsageMsg1"
    successMsg "$UsageMsg2"

    local packageSuffix=$(get-PackageSuffix $*)                    # 文件后缀名, 需要小写.

    local pkgListCmake="pkgLists.cmake"            # 定义包含package list的cmake file的名字, 被CMakeLists.txt include

    getCmakeType  $packageSuffix >  $pkgListCmake   # 这里">" 覆盖写入
    getCmakeList  >>  $pkgListCmake                 # 这里 ">>"追加写入.

    local buildDir="./build"

    # 清空build/, build/下包含编译缓存信息.
    # 然后进入build编译package
    # 最后返回build上层目录. 即compile.sh所在目录.
    rm ${buildDir}/* -rf &&  \
         cd ${buildDir}/ &&  \
         cmake ../       &&  \
         make package    &&
         cd ../

    local packageName="$(ls  ${buildDir}/*${packageSuffix})"

    echo && echo && echo        # 输出三行空白, 用以展现以下输出.

    echo -n "You have built package  "
    successMsg  "${packageName}"        # 给用户输出编译产生的包名.

    # }}}
}

compile $*
