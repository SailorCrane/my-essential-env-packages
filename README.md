#test-cmake-package-deb
0: 本deb包的制作是受到了Ubuntu 环境下 build-essential的启发.
    build-essential 本身并没有什么实质性内容, 只不过维护了一张依赖表.
    依赖表位于文件/usr/share/build-essential/essential-packages-list

    这样使用apt-get 安装build-essential时, 会自动安装所以来的那些包.这正是build-essential包的目的所在.

    我的Ubuntu16.04 上 essential-packages-list的内容, 时间2017年 03月 24日 星期五 22:02:33 CST
            base-files
            base-passwd
            bash
            bsdutils
            coreutils
            dash
            debianutils
            diffutils
            dpkg
            e2fsprogs
            findutils
            grep
            gzip
            hostname
            init
            libc-bin
            login
            mount
            ncurses-base
            ncurses-bin
            perl-base
            sed
            tar
            util-linux


1: 编译步骤:
    1- 编辑 essential-list.txt, 在其中添加自己的软件依赖列表, 注意这些列表必须能在apt仓库中找到.
        本txt支持 '#' 注释.

    2- 运行 addLists.sh 脚本生成 pkgLists.cmake.  pkgLists.cmake 被 CMakeLists.txt 所include.
        如果已经存在pkgLists.cmake, 再次运行addLists.sh 会覆盖原有 pkgLists.cmake
        ./addLists.sh

    3- 进入build编译生成 myenv-essential.deb包, 生成后使用dpkg-deb -I查看包信息.
        cd build
        cmake ../
        make  package
        dpkg-deb  -I  myenv-essential.deb   # 查看生成包的信息是否正确.

    4- 使用gdebi 安装deb包.( 因为gdebi可以自动解决依赖, 这正是本包的目的所在. 如果没有安装gdebi, apt-get install  gdebi )
        gdebi  myenv-essential-1.0.0-Linux.deb      # 通过安装myenv-essential, 安装了列表依赖中所有的包


2: 参考链接: http://www.open-open.com/lib/view/open1419165844339.html


3: 使用技术
    使用cmake 的cpack 生成deb包.
    使用bash脚本将packagetList 添加到 pkgLists.cmake中.

