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
    local packageName="$(ls  ${buildDir}/myenv-essential*)"        # get package name

    echo -n "You are going to install package  "
    successMsg  "${packageName}"        # 给用户输出编译产生的包名.

    # deb install
    # 注意通配写法: *deb*两边不可以有引号,  =~两边不能有空格.
    if  [  ${packageName}=~*deb* ] ; then
        sudo gdebi  $packageName
        return $?
    fi

    # rpm install
    if [ "${packageName}"=~*rpm ] ; then
        sudo yum install $packageName
        return $?
    fi

    echo  "${packageName}:  Package Type doesnt recognize"
    return -1

    # }}}
}

installPackage
