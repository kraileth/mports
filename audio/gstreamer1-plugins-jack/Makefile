# $FreeBSD: head/audio/gstreamer1-plugins-jack/Makefile 375225 2014-12-22 10:22:38Z kwm $

PORTREVISION=	0
CATEGORIES=	audio

COMMENT=	Gstreamer low-latency audio server plugin

GST_PLUGIN=	jack
DIST=		good

# jack defaults to readline and this is killing magus.
LIB_DEPENDS+=	libreadline.so:${PORTSDIR}/devel/readline
BUILD_DEPENDS+=	${LOCALBASE}/lib/libreadline.so:${PORTSDIR}/devel/readline

MASTERDIR=	${.CURDIR}/../../multimedia/gstreamer1-plugins

.include "${MASTERDIR}/Makefile"
