# env setting
```
export VIM_MISC_CSCOPE_C=~/cscope_sys.out,~/cscope_core.out
export VIM_MISC_TAGS_C=~/tags_core,~/tags_sys
export VIM_MISC_PATH_C=$APPHOME/include,$DB2HOME/include,/usr/include,/usr/local/include,/usr/include/libxml2
export VIM_MISC_GCC_OPT_C="-fPIC -Wall -std=c99 -D_XOPEN_SOURCE=600 -fms-extensions -DLINUX -D_DBTYPE_DB2 "
```

# ctags and cscope
```
ctags -I __THROW,__attribute_pure__,__nonnull,__attribute__ --langmap=c:+.h --languages=c,c++ --c-kinds=+px --c++-kinds=+px --fields=+iafksS --extra=+qf -f ~/tags_core -R ~/core
find ~/core -name "*.h" -o -name "*.c" -o -name "*.sqc">~/cscope_core.files && cscope -b -i ~/cscope_core.files -f ~/cscope_core.out
```

# command
```
SetTitle
```
