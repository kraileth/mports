# $MidnightBSD$
#
# handle dependency on the iconv port
#
# Feature:	iconv
# Usage:	USES=iconv or USES=iconv:ARGS
# Valid ARGS:	lib (default, implicit), build, patch,
#		wchar_t (port uses "WCHAR_T" extension),
#		translit (port uses "//TRANSLIT" extension)

.if !defined(_INCLUDE_USES_ICONV_MK)
_INCLUDE_USES_ICONV_MK=	yes

#iconv_ARGS:=   ${iconv_ARGS:S/,/ /g}

.if ${iconv_ARGS:Mwchar_t} || ${iconv_ARGS:Mtranslit} || ${OSVERSION} < 8000 || !exists(/usr/include/iconv.h) || !exists(/usr/lib/libiconv.so)

ICONV_CMD=	${LOCALBASE}/bin/iconv
ICONV_LIB=	-liconv
ICONV_PREFIX=	${LOCALBASE}
ICONV_CONFIGURE_ARG=	--with-libiconv-prefix=${LOCALBASE}
ICONV_CONFIGURE_BASE=	--with-libiconv=${LOCALBASE}
ICONV_INCLUDE_PATH=	${LOCALBASE}/include
ICONV_LIB_PATH=		${LOCALBASE}/lib/libiconv.so

.if ${iconv_ARGS:Mbuild}
BUILD_DEPENDS+=	${ICONV_CMD}:converters/libiconv
.elif ${iconv_ARGS:Mpatch}
PATCH_DEPENDS+=	${ICONV_CMD}:converters/libiconv
.else
BUILD_DEPENDS+=	${ICONV_CMD}:converters/libiconv
LIB_DEPENDS+=	libiconv.so:converters/libiconv
RUN_DEPENDS+=	${ICONV_CMD}:converters/libiconv
.endif

.else

ICONV_CMD=	/usr/bin/iconv
ICONV_LIB=
ICONV_PREFIX=	/usr
ICONV_CONFIGURE_ARG=
ICONV_CONFIGURE_BASE=
ICONV_INCLUDE_PATH=	/usr/include
ICONV_LIB_PATH=		/usr/lib/libc.so

.if exists(${LOCALBASE}/include/iconv.h)
# Check that libiconv iconv.h is recent enough for LIBICONV_PLUG to work.
BUILD_DEPENDS+=	libiconv>=1.14_11:converters/libiconv
.endif

# LIBICONV_PLUG makes libiconv iconv.h act like libc iconv.h.
CPPFLAGS+=	-DLIBICONV_PLUG
CFLAGS+=	-DLIBICONV_PLUG
CXXFLAGS+=	-DLIBICONV_PLUG
OBJCFLAGS+=	-DLIBICONV_PLUG

.endif

# These are the most common names for the iconv-related variables found in
# CMake-based ports. We set them here via CMAKE_ARGS to make sure that the best
# combination is always used (ie. we prefer the version in libc whenever it is
# available, and sometimes have to fall back to the iconv.h header from ports
# while still using the library from base).
CMAKE_ARGS+=	-DICONV_INCLUDE_DIR=${ICONV_INCLUDE_PATH} \
		-DICONV_LIBRARIES=${ICONV_LIB_PATH} \
		-DICONV_LIBRARY=${ICONV_LIB_PATH} \
		-DLIBICONV_INCLUDE_DIR=${ICONV_INCLUDE_PATH} \
		-DLIBICONV_LIBRARIES=${ICONV_LIB_PATH} \
		-DLIBICONV_LIBRARY=${ICONV_LIB_PATH}

.endif
