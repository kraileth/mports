# handle dependency depends on desktop-file-utils and package regen
#
# Feature:	desktop-file-utils
# Usage:	USES=desktop-file-utils
# Valid ARGS:	does not require args
#

.if !defined(_INCLUDE_USES_DESKTOP_FILE_UTILS_MK)
_INCLUDE_USES_DESKTOP_FILE_UTILS_MK=	yes

.if !empty(desktop-file-utils_ARGS)
IGNORE=	USES=desktop-file-utils does not require args
.endif

BUILD_DEPENDS+=	update-desktop-database:devel/desktop-file-utils
RUN_DEPENDS+=	update-desktop-database:devel/desktop-file-utils

# bolt our post-install target to post-install
post-install: desktop-file-post-install

desktop-file-post-install:
# run for port post-install
	@-update-desktop-database
# plist entries for packages.
	@${ECHO_CMD} "@postexec ${LOCALBASE}/bin/update-desktop-database > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST}; \
	${ECHO_CMD} "@postunexec ${LOCALBASE}/bin/update-desktop-database > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST}

.endif
