PORTNAME=	smartmontools
PORTVERSION=	7.1
PORTREVISION=	1
CATEGORIES=	sysutils
MASTER_SITES=	SF

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	S.M.A.R.T. disk monitoring tools

LICENSE=	gpl2

CONFLICTS=	smartmontools-devel-[0-9]*

OPTIONS_DEFINE=	DOCS

USES=		compiler:c++11-lib gmake
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--disable-dependency-tracking \
		--enable-sample \
		--with-gnupg=no \
		--with-nvme-devicescan=yes \
		--with-initscriptdir=${PREFIX}/etc/rc.d \
		--with-update-smart-drivedb=no
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd10.4
SUB_FILES=	pkg-message smart
USE_RC_SUBR=	smartd

PORTDOCS=	*

post-patch:
	@${REINPLACE_CMD} -e 's| install-initdDATA| |' ${WRKSRC}/Makefile.in

post-install:
	${MKDIR} ${PREFIX}/etc/periodic/daily
	${INSTALL_SCRIPT} ${WRKDIR}/smart ${PREFIX}/etc/periodic/daily/smart

.include <bsd.port.mk>
