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


1: 项目细节(工具细节, 还谈不上项目):
    1- 如果要生成RPM包, 修改CMakeLists.txt中CPACK_GENERATOR 为 RPM: set(CPACK_GENERATOR "RPM")
       如果要生成DEB包, 修改CMakeLists.txt中CPACK_GENERATOR 为 DEB: set(CPACK_GENERATOR "DEB")

       注意: 如果生成rpm包, 本地需要有rpmbuild命令!!!

    2- 编辑 essential-list.txt, 在其中添加自己的软件依赖列表. 注意:这些列表必须能在apt/yum仓库中找到.
       提示: essential-list.txt支持 '#' 注释.

    3- 运行 compile.sh  开始编译. 编译完毕后, 会输出生产的包名.
        ./compile.sh

    4- 运行./install.sh 安装 生成的deb包.
       # Ubuntu 借助gdebi, rpm借助 yum
       # rpm/yum用户使用 yum 安装.(yum 安装本地文件, 也会自动解决依赖)

       ./install.sh


2: 参考链接: http://www.open-open.com/lib/view/open1419165844339.html


3: 使用技术
    使用cmake 的cpack 生成deb/rpm包.
    使用bash脚本将 ubuntu-essential-list.txt 中的软件列表 添加到 pkgLists.cmake中.
