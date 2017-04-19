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

installPackage() {
    # {{{
    local buildDir="./build"
    local packageName="$(ls  ${buildDir}/*deb)"

    echo -n "You are going to install package  "
    successMsg  "${packageName}"        # 给用户输出编译产生的包名.

    sudo gdebi  $packageName

    # }}}
}

installPackage
