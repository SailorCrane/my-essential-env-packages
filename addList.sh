pkgs=$(./filter-package.sh)

for pkgName in $pkgs ; do
    echo "list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS \"$pkgName\")"
done

#list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS "vim-gnome")      # 使用list append, 避免参数挤在一起.
