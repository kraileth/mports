PORTNAME=	xmltodict
PORTVERSION=	0.12.0
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	XML parser that returns python dictionaries

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

TEST_DEPENDS=	${PYTHON_PKGNAMEPREFIX}nose>=0:devel/py-nose@${PY_FLAVOR}

NO_ARCH=	yes
USES=		python:3.6+
USE_PYTHON=	autoplist concurrent distutils

USE_LOCALE=	en_US.UTF-8

do-test:
	@cd ${WRKSRC} && ${LOCALBASE}/bin/nosetests-${PYTHON_VER}

.include <bsd.port.mk>
