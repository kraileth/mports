PORTNAME=	gnome-backgrounds
PORTVERSION=	3.38.0
CATEGORIES=	x11-themes graphics gnome
MASTER_SITES=	GNOME
DIST_SUBDIR=	gnome

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Collection of backgrounds for GNOME

LICENSE=	gpl2
LICENSE_FILE=	${WRKSRC}/COPYING

PORTSCOUT=	limitw:1,even

BUILD_DEPENDS+=	ninja:devel/ninja

NO_ARCH=	yes
USES=		gettext meson python:3.7,build tar:xz

.include <bsd.port.mk>
