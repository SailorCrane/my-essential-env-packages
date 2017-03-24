pkgs=$(./filter-package.sh)

echo -n "set(CPACK_DEBIAN_PACKAGE_DEPENDS \""
for pkgName in $pkgs ; do
    echo -n  "$pkgName, "
done
    echo "\" )"

#list(APPEND CPACK_DEBIAN_PACKAGE_DEPENDS "vim-gnome")      # 使用list append, 避免参数挤在一起.
