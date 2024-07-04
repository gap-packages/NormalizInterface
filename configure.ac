dnl ##
dnl ## Process this file with autoconf to produce a configure script.
dnl ## 

dnl ##
dnl ## Setup autoconf
dnl ##
AC_PREREQ([2.68])
AC_INIT([NormalizInterface], [package], [https://github.com/gap-packages/NormalizInterface/issues], [NormalizInterface], [https://gap-packages.github.io/NormalizInterface/])
AC_CONFIG_SRCDIR([src/normaliz.cc])
AC_CONFIG_MACRO_DIR([m4])
m4_include([m4/ax_cxx_compile_stdcxx.m4])
m4_include([m4/find_gap.m4])

dnl ##
dnl ## C++ is the language
dnl ##
AC_PROG_CXX
AC_LANG([C++])

dnl ##
dnl ## Check for C++14 support
dnl ##
AX_CXX_COMPILE_STDCXX(14, ,mandatory)

dnl ##
dnl ## Locate the GAP root dir
dnl ##
FIND_GAP


dnl ##
dnl ## Check for GMP
dnl ##

GMP_PREFIX=${GMP_PREFIX:-none}
GMP_CPPFLAGS=""
GMP_LDFLAGS=""

AC_MSG_CHECKING([for GMP])

if test "x$GMP_PREFIX" = "xnone" ; then
    # If a gaproot was specified, try to find GMP in there; otherwise, fall
    # back to whatever GMP may be found via user specified C/CPP/LDFLAGS
    if test "${with_gaproot+set}" = set; then
        if test -f ${with_gaproot}/extern/install/gmp/include/gmp.h && test -d ${with_gaproot}/extern/install/gmp/lib ; then
            AC_MSG_RESULT([yes, bundled with GAP at ${with_gaproot}])
            GMP_CPPFLAGS="-I${with_gaproot}/extern/install/gmp/include"
            GMP_LDFLAGS="-L${with_gaproot}/extern/install/gmp/lib"
        fi
    fi
else
    AC_MSG_RESULT([yes, at GAP supplied prefix ${GMP_PREFIX}])
	if test -d ${GMP_PREFIX}/include && test -d ${GMP_PREFIX}/lib ; then
		GMP_CPPFLAGS="-I${GMP_PREFIX}/include"
        GMP_LDFLAGS="-L${GMP_PREFIX}/lib"
	else
		AC_MSG_ERROR([Could not locate libgmp in the specified location])
	fi
fi;

AC_SUBST(GMP_LDFLAGS)
AC_SUBST(GMP_CPPFLAGS)


dnl ##
dnl ## Locate Normaliz
dnl ##

NORMALIZ_RPATH_EXTRA=""

AC_ARG_WITH([normaliz],
    [AS_HELP_STRING([--with-normaliz=<path>], [specify root of Normaliz installation])],
    [NORMALIZ="$with_normaliz"],
    [NORMALIZ="$PWD/NormalizInstallDir"
     # The following is a hack to ensure compatibility with versions of gac that
     # don't use GNU libtool anymore, and thus don't set a run path pointing to
     # the specific version of libnormaliz we requested. Without this, when GAP
     # loads NormalizInterface.so it may not find the libnormaliz shared library.
     NORMALIZ_RPATH_EXTRA="-Wl,-rpath,$NORMALIZ/lib"
    ]
)
NORMALIZ_CPPFLAGS="-I$NORMALIZ/include"
NORMALIZ_LDFLAGS="$NORMALIZ_RPATH_EXTRA -L$NORMALIZ/lib"
AC_SUBST(NORMALIZ_LDFLAGS)
AC_SUBST(NORMALIZ_CPPFLAGS)

dnl ## Make sure Normaliz can be used and its version is at least >= 3.4.0

old_CPPFLAGS="$CPPFLAGS"
old_LDFLAGS="$LDFLAGS"
CPPFLAGS="$CPPFLAGS $NORMALIZ_CPPFLAGS $GMP_CPPFLAGS"
LDFLAGS="$LDFLAGS $NORMALIZ_LDFLAGS $GMP_LDFLAGS"
AC_CHECK_HEADER([libnormaliz/cone.h], [], [AC_MSG_ERROR([could not use libnormaliz/cone.h])], [])

AC_MSG_CHECKING([for Normaliz >= 3.5.4])
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[@%:@include "libnormaliz/cone.h"]],
               [[#if !defined(NMZ_RELEASE) || NMZ_RELEASE < 30504
               #error Normaliz too old
               #endif
               return 0;]])],
       ac_normaliz=yes,ac_normaliz=no)

AC_MSG_RESULT($ac_normaliz)
if test "x$ac_normaliz" != "xyes"; then
    AC_MSG_ERROR([Normaliz >= 3.5.4 is required])
fi
CPPFLAGS="$old_CPPFLAGS"
LDFLAGS="$old_LDFLAGS"

dnl ##
dnl ## Finally, generate the Makefiles and output everything
dnl ##
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
