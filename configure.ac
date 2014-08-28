dnl ##
dnl ## Process this file with autoconf to produce a configure script.
dnl ## 
AC_PREREQ([2.68])
AC_INIT([NormalizInterface], m4_esyscmd([tr -d '\n' < VERSION]))
AC_CONFIG_SRCDIR([src/normaliz.cc])
m4_include([m4/ac_find_gap.m4])

dnl ##
dnl ## C++ is the language 
dnl ##
AC_PROG_CXX
AC_LANG([C++])

dnl ##
dnl ## Checks for system header files.
dnl ##
AC_CHECK_HEADERS([stdlib.h])

dnl ##
dnl ## Locate the GAP root dir
dnl ##
AC_FIND_GAP

AC_ARG_WITH([normaliz],
    [AC_HELP_STRING([--with-normaliz=<path>], [specify root of Normaliz installation])],
    [NORMALIZ="$with_normaliz"],
    [AC_MSG_ERROR([Must use --with-normaliz])]
)
NORMALIZ_CPPFLAGS="-I$NORMALIZ/include"
NORMALIZ_LDPATH="$NORMALIZ/lib"
NORMALIZ_LDFLAGS="-L$NORMALIZ_LDPATH"
AC_SUBST(NORMALIZ_LDPATH)
AC_SUBST(NORMALIZ_LDFLAGS)
AC_SUBST(NORMALIZ_CPPFLAGS)

dnl ##
dnl ## Finally, generate the Makefiles and output everything
dnl ##
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
