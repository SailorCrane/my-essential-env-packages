cmake_minimum_required(VERSION 2.6)
# cmake version  3.5, Ubuntu16.04
# usage: cmake <dir>.  cmake  ./

#set(CMAKE_INSTALL_PREFIX  ./usr)

project(test-pac)
# 使用project( pro_name )命令后
# Cmake 系统也帮助我们预定义了 PROJECT_BINARY_DIR和PROJECT_SOURCE_DIR其值与上述对应相等
# <project name>_BINARY_DIR(二进制文件保存路径)    <project name>_SOURCE_DIR（源代码路径）

#add_subdirectory(src)
set(MAJOR_VERSION 1)
set(MINOR_VERSION 0)
set(PATCH_VERSION 0)

set(CPACK_GENERATOR "DEB")

set(CPACK_PACKAGE_VERSION_MAJOR "${MAJOR_VERSION}")
set(CPACK_PACKAGE_VERSION_MINOR "${MINOR_VERSION}")
set(CPACK_PACKAGE_VERSION_PATCH "${PATCH_VERSION}")

#set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.3.1-6)")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "vim-gnome")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "vim")
#set(CPACK_DEBIAN_PACKAGE_DEPENDS "cmake-qt-gui" "slurm" "vim" "vim-gnome")

include(./pkgLists.cmake)       # pkgLists.cmake由脚本文件自动生成

set(CPACK_PACKAGE_DESCRIPTION "pro-cc service")

set(CPACK_PACKAGE_CONTACT "215379951@qq.com")

include(CPack)

#install(FILES ${CMAKE_SOURCE_DIR}/pro-cc.conf DESTINATION /etc/init)
#install(FILES  test1 test2  DESTINATION /etc)
