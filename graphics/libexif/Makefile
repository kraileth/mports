PORTNAME=	libexif
PORTVERSION=	0.6.22
CATEGORIES=	graphics
MASTER_SITES=	https://github.com/libexif/libexif/releases/download/libexif-${PORTVERSION:S|.|_|g}-release/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Library to read digital camera file meta-data

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/COPYING

OPTIONS_DEFINE=	DOCS NLS

USES=		cpe gmake libtool localbase pathfix pkgconfig tar:xz
CPE_VENDOR=	curtis_galloway
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--disable-docs
USE_LDCONFIG=	yes

PORTDOCS=	AUTHORS ChangeLog NEWS README
OPTIONS_SUB=	yes

NLS_USES=	gettext
NLS_CONFIGURE_ENV_OFF=	am_cv_func_iconv=no
NLS_CONFIGURE_ENABLE=	nls

post-patch:
	@${REINPLACE_CMD} -e '/^SUBDIRS =/s|doc||g ; \
		 /^am__installdirs =/s|$$(docdir)||g ; \
		 /^install-data-am:/s|install-docDATA||g' ${WRKSRC}/Makefile.in

post-install:
	@${MKDIR} ${DOCSDIR}
.for file in ${PORTDOCS}
	${INSTALL_DATA} ${WRKSRC}/${file} ${DOCSDIR}
.endfor

.include <bsd.port.mk>
