# Created by: Koop Mast <kwm@FreeBSD.org>

PORTNAME=	dconf
PORTVERSION=	0.28.0
CATEGORIES=	devel gnome
MASTER_SITES=	GNOME
DISTNAME=	dconf-${PORTVERSION}
DIST_SUBDIR=	gnome3

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Configuration database system for GNOME

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	vala>=0.18.1:lang/vala \
		docbook-xsl>=0:textproc/docbook-xsl
LIB_DEPENDS=	libdbus-1.so:devel/dbus

PORTSCOUT=	limitw:1,even

USES=		gettext gnome localbase meson pkgconfig python:3.6+,build tar:xz
USE_GNOME=	glib20 libxslt:build
USE_LDCONFIG=	yes
BINARY_ALIAS=	python3=${PYTHON_VERSION}

NO_TEST=	yes

MESON_ARGS=	-Denable-man=true

post-patch:
	@${REINPLACE_CMD} -e 's|/etc/|${PREFIX}/etc/|g' \
		-e 's|"/etc"|"${PREFIX}/etc"|g' \
		${WRKSRC}/docs/dconf-overview.xml \
		${WRKSRC}/engine/dconf-engine.c \
		${WRKSRC}/engine/dconf-engine-profile.c \
		${WRKSRC}/engine/dconf-engine-source-system.c \
		${WRKSRC}/bin/dconf-update.vala \
		${WRKSRC}/tests/engine.c

post-install:
	@${MKDIR} ${PREFIX}/etc/dconf/db
	@${MKDIR} ${PREFIX}/etc/dconf/profile

.include <bsd.port.mk>
