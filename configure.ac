dnl ##
dnl ## Process this file with autoconf to produce a configure script.
dnl ## 
AC_PREREQ([2.68])
AC_INIT([GAPnormaliz], m4_esyscmd([tr -d '\n' < VERSION]))
AC_CONFIG_SRCDIR([src/normaliz.c])
m4_include([m4/ac_find_gap.m4])

AC_PROG_CC

dnl ##
dnl ## C is the language 
dnl ##
AC_LANG([C])

dnl ##
dnl ## Checks for system header files.
dnl ##
AC_CHECK_HEADERS([stdlib.h])

dnl ##
dnl ## Locate the GAP root dir
dnl ##
AC_FIND_GAP

dnl ##
dnl ## Finally, generate the Makefiles and output everything
dnl ##
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
