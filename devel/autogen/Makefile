# $MidnightBSD$

PORTNAME=	autogen
PORTVERSION=	5.18.10
CATEGORIES=	devel
MASTER_SITES=	GNU/${PORTNAME}/rel${PORTVERSION}
DISTFILES=	${DISTNAME}${EXTRACT_SUFX}:DEFAULT,gnu

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	The Automated Program Generator

LICENSE=	gpl3

BUILD_DEPENDS=	bash:${PORTSDIR}/shells/bash
LIB_DEPENDS=	libguile-2.0.so:${PORTSDIR}/lang/guile2

USES=		gmake libtool pathfix perl5 pkgconfig shebangfix tar:xz
USE_PERL5=	build
USE_GNOME=	libxml2
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--with-libguile=yes --with-libxml2=yes \
		--datadir=${PREFIX}/share CONFIG_SHELL=${LOCALBASE}/bin/bash
USE_LDCONFIG=	yes
SHEBANG_FILES=	autoopts/tpl/*.pl
INSTALL_TARGET=	install-strip

INFO=		autogen

.include <bsd.port.mk>
