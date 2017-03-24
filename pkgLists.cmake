set(CPACK_DEBIAN_PACKAGE_DEPENDS "cmake-qt-gui")

list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS "vim")            # 使用list append, 避免参数挤在一起.
list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS "vim-gnome")
