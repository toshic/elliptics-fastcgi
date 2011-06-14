AC_DEFUN([AC_CHECK_FASTCGIDAEMON],[
AC_MSG_CHECKING([whether FastCGI daemon version is installed])
FASTCGIDAEMON_LIBS="-lfastcgi-daemon2"
ac_have_fastcgidaemon="no"

AC_ARG_WITH([fastcgidaemon-path],
	AC_HELP_STRING([--with-fastcgidaemon-path=@<:@ARG@:>@],
		[Build with the different path to FastCGI daemon (ARG=string)]),
	[
		FASTCGIDAEMON_LIBS="-L$withval/lib -lfastcgi-daemon2"
		FASTCGIDAEMON_CFLAGS="-I$withval/include"
	],
	[
		FASTCGIDAEMON_LIBS="-lfastcgi-daemon2"
	]
)

saved_CFLAGS="$CFLAGS"
saved_LIBS="$LIBS"
LIBS="$FASTCGIDAEMON_LIBS $LIBS"
CFLAGS="$FASTCGIDAEMON_CFLAGS $CFLAGS"

echo $LIBS
echo $CFLAGS

AC_TRY_LINK([#include <fastcgi2/cookie.h>],
	[fastcgi::Cookie cookie("test", "test");],
	[
		AC_DEFINE(HAVE_FASTCGIDAEMON_SUPPORT, 1, [Define this if FastCGI daemon is installed])
		ac_have_fastcgidaemon="yes"
		AC_MSG_RESULT([yes])
	], [
		AC_MSG_ERROR([FastCGI daemon was not found. See https://github.com/golubtsov/Fastcgi-Daemon])
	])

AC_SUBST(FASTCGIDAEMON_LIBS)
AC_SUBST(FASTCGIDAEMON_CFLAGS)
LIBS="$saved_LIBS"
AM_CONDITIONAL(HAVE_FASTCGIDAEMON, [test "f$ac_have_fastcgidaemon" = "fyes"])
])
