
PHP_ARG_ENABLE(oath, for OATH support,
[  --enable-oath           Include OATH support])

if test "$PHP_OATH" = "yes"; then
    AC_PATH_PROG(PKG_CONFIG, pkg-config, no)

    AC_MSG_CHECKING([for oath-toolkit])
    if test -x "$PKG_CONFIG" && $PKG_CONFIG --exists liboath; then
        LIBOATH_CFLAGS=`$PKG_CONFIG liboath --cflags`
        LIBOATH_LIBS=`$PKG_CONFIG liboath --libs`
        LIBOATH_VERSION=`$PKG_CONFIG liboath --modversion`
        AC_MSG_RESULT(version $LIBOATH_VERSION found using pkg-config)
        PHP_EVAL_LIBLINE($LIBOATH_LIBS, OATH_SHARED_LIBADD)
        PHP_EVAL_INCLINE($LIBOATH_CFLAGS)
    else
        PHP_ADD_LIBRARY(oath, OATH_SHARED_LIBADD)
    fi

    PHP_NEW_EXTENSION(oath, oath.c, $ext_shared)
    PHP_SUBST(OATH_SHARED_LIBADD)
fi

# vim: tabstop=4:softtabstop=4:shiftwidth=4:noexpandtab

