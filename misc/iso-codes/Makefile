PORTNAME=	iso-codes
PORTVERSION=	4.2
CATEGORIES=	misc

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Lists of the country, language, and currency iso names

LICENSE=	lgpl2.1

USES=		gettext-tools gmake pathfix python:3.4+,build tar:xz

BUILD_DEPENDS+=	python3:lang/python3

GNU_CONFIGURE=	yes
NO_ARCH=	yes

USE_GITLAB=	yes
GL_SITE=	https://salsa.debian.org
GL_ACCOUNT=	iso-codes-team
GL_COMMIT=	58a4f20f8e6f4d8f9545333f3eae4cfe5678de16

BINARY_ALIAS=	python3=${PYTHON_VERSION}

.include <bsd.port.mk>
