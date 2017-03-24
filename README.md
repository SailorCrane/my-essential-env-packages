#test-cmake-package-deb

1: 编译步骤:

    1- 使用shell脚本生成 pkgLists.cmake.  pkgLists.cmake 被 CMakeLists.txt 所include
    2- 进入build编译生成 deb包
        cd build
        cmake ../
        make  package

    3- 使用gdebi 安装deb包.( 因为gdebi可以自动解决依赖, 这正是本包的目的所在 )

2: 参考链接: http://www.open-open.com/lib/view/open1419165844339.html

