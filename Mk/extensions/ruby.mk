#
# bsd.ruby.mk - Utility definitions for Ruby related ports.
#
# Created by: Akinori MUSHA <knu@FreeBSD.org>
#
# $MidnightBSD$ 
# $FreeBSD: ports/Mk/bsd.ruby.mk,v 1.154 2006/08/27 09:53:27 sem Exp $
#

.if !defined(_POST_MKINCLUDED) && !defined(Ruby_Pre_Include)

Ruby_Pre_Include=			ruby.mk
Ruby_Include_MAINTAINER=	ports@MidnightBSD.org

#
# [variables that a user may define]
#
# RUBY_VER		- (See below)
# RUBY_DEFAULT_VER	- Set to (e.g.) "2.2" if you want to refer to "ruby22"
#			  just as "ruby".
# RUBY_ARCH		- (See below)
# RUBY_RD_HTML		- Define if you want HTML files generated from RD files.
#
#
# [variables that each port can define]
#
# RUBY			- Set to full path of ruby.  If you set this, the values
#			  of the following variables are automatically obtained
#			  from the ruby executable: RUBY_VER, RUBY_VERSION,
#			  RUBY_NAME, RUBY_ARCH, RUBY_LIBDIR, RUBY_ARCHLIBDIR,
#			  RUBY_SITELIBDIR, and RUBY_SITEARCHLIBDIR.
# RUBY_VER		- Set to the alternative short version of ruby in the
#			  form of `x.y' (see below for current value).
# USE_RUBY		- Says that the port uses ruby for building and running.
# RUBY_NO_BUILD_DEPENDS	- Says that the port should not build-depend on ruby.
# RUBY_NO_RUN_DEPENDS	- Says that the port should not run-depend on ruby.
# USE_LIBRUBY		- Says that the port uses libruby.
# USE_RUBY_EXTCONF	- Says that the port uses extconf.rb to configure.
#			  Implies USE_RUBY.
# RUBY_EXTCONF		- Set to the alternative name of extconf.rb
#			  (default: extconf.rb).
# RUBY_EXTCONF_SUBDIRS	- Set to list of subdirectories, if multiple modules
#			  are included.
# USE_RUBY_SETUP	- Says that the port uses setup.rb to configure and
#			  build.
# RUBY_SETUP		- Set to the alternative name of setup.rb
#			  (default: setup.rb).
# USE_RUBY_RDTOOL	- Says that the port uses rdtool to generate documents.
# USE_RUBY_RDOC		- Says that the port uses rdoc to generate documents.
# RUBY_REQUIRE		- Set to a Ruby expression to evaluate before building
#			  the port.  The constant "Ruby" is set to the integer
#			  version number of ruby, and the result of the
#			  expression will be set to RUBY_PROVIDED, which is
#			  left undefined if the result is nil, false or a
#			  zero-length string.  Implies USE_RUBY.
# RUBY_RD_FILES		- Specify the RD files which you want to generate HTML
#			  documents from. If this is defined and not empty,
#			  USE_RUBY_RDTOOL is implied and RUBY_RD_HTML_FILES is
#			  defined.
# USE_RUBYGEMS		- Do not use this -- instead USES=gem
#
# [variables that each port should not (re)define]
#
# RUBY_PKGNAMEPREFIX	- Common PKGNAMEPREFIX for ruby ports
#			  (default: ruby${RUBY_SUFFIX}-)
# RUBY_RELVERSION	- Full version of ruby without preview/beta suffix in
#			  the form of `x.y.z' (see below for current value).
# RUBY_RELVERSION_CODE	- Integer version of RUBY_RELVERSION in the form of
#			  `xyz'.
# RUBY_VERSION		- Composite version of RUBY_RELVERSION and
#			  RUBY_PATCHLEVEL in the form of `x.y.z.p'.
#			  (default: ${RUBY_RELVERSION}.${RUBY_PATCHLEVEL})
# RUBY_VERSION_CODE	- Composite integer version of RUBY_VERSION in the form
#			  of `xyzp'.
# RUBY_PORTVERSION	- PORTVERSION for the standard ruby ports (ruby,
#			  ruby-gdbm, etc.).
# RUBY_PORTREVISION	- PORTREVISION for the standard ruby ports.
# RUBY_PORTEPOCH	- PORTEPOCH for the standard ruby ports.
# RUBY_DISTNAME		- DISTNAME for the standard ruby ports, i.e. the
#			  basename of the ruby distribution tarball.
# RUBY_DISTVERSION	- The version number part of RUBY_DISTNAME.
# RUBY_PATCHFILES	- PATCHFILES for the standard ruby ports, i.e. the
#			  basename of the ruby distribution tarball.
# RUBY_WRKSRC		- WRKSRC for the ruby port.
# MASTER_SITE_SUBDIR_RUBY	- MASTER_SITE_SUBDIR for the ruby distfiles.
#
# RUBY_SHLIBVER		- Major version of libruby (see below for current
#			  value).
# RUBY_ARCH		- Set to target architecture name.
#			  (e.g. i386-freebsd7)
# RUBY_SUFFIX		- Suffix for ruby binaries and directories
#			  (${RUBY_VER:S/.//}).
# RUBY_WITHOUT_SUFFIX	- Always ${LOCALBASE}/bin/ruby.
# RUBY_WITH_SUFFIX	- Always ${RUBY_WITHOUT_SUFFIX}${RUBY_SUFFIX}.
# RUBY_NAME		- Ruby's name with trailing suffix.
#
# RUBY_MODNAME		- Set to the module name (default: ${PORTNAME}).
#
# RUBY_RD2		- Full path of rd2 executable.
# RUBY_RDOC		- Full path of rdoc executable.
#
# RUBY_BASE_PORT	- Port path of base ruby without PORTSDIR, without
#			  suffix except version.
# RUBY_PORT		- Port path of ruby without PORTSDIR.
# RUBY_RDTOOL_PORT	- Port path of rdtool without PORTSDIR.
# RUBY_RDOC_PORT	- Port path of rdoc without PORTSDIR.
#
# DEPEND_LIBRUBY	- LIB_DEPENDS entry for libruby.
# DEPEND_RUBY		- BUILD_DEPENDS/RUN_DEPENDS entry for ruby.
# DEPEND_RUBY_RDTOOL	- BUILD_DEPENDS entry for rdtool.
# DEPEND_RUBY_RDOC	- BUILD_DEPENDS entry for rdoc.
#
# RUBY_LIBDIR		- Installation path for architecture independent
#			  libraries.
# RUBY_ARCHLIBDIR	- Installation path for architecture dependent
#			  libraries.
# RUBY_SITELIBDIR	- Installation path for site architecture independent
#			  libraries.
# RUBY_SITEARCHLIBDIR	- Installation path for site architecture dependent
#			  libraries.
# RUBY_DOCDIR		- Installation path for documents.
# RUBY_EXAMPLESDIR	- Installation path for examples.
# RUBY_RIDIR		- Installation path for site architecture independent ri
#			  documents.
# RUBY_SITERIDIR	- Installation path for site architecture dependent ri
#			  documents.
# RUBY_MODDOCDIR	- Installation path for the module's documents.
# RUBY_MODEXAMPLESDIR	- Installation path for the module's examples.
# RUBY_ELISPDIR		- Installation path for emacs lisp files.
#

.include "${PORTSDIR}/Mk/components/default-versions.mk"

.if defined(RUBY_DEFAULT_VER)
WARNING+=	"RUBY_DEFAULT_VER is defined, consider using DEFAULT_VERSIONS=ruby=${RUBY_DEFAULT_VER} instead"
.endif

RUBY_DEFAULT_VER?=	${RUBY_DEFAULT}

RUBY_VER?=		${RUBY_DEFAULT_VER}

.if defined(RUBY)
.if !exists(${RUBY})
IGNORE=	cannot install: you set the variable RUBY to "${RUBY}", but it does not seem to exist.  Please specify an already installed ruby executable.
.endif

_RUBY_TEST!=		${RUBY} -e 'begin; require "rbconfig"; puts "ok" ; rescue LoadError; puts "error"; end'
.if !empty(_RUBY_TEST) && ${_RUBY_TEST} != "ok"
IGNORE=	cannot install: you set the variable RUBY to "${RUBY}", but it failed to include rbconfig.  Please specify a properly installed ruby executable.
.endif

_RUBY_CONFIG=		${RUBY} -r rbconfig -e 'C = RbConfig::CONFIG' -e

RUBY_VERSION!=		${_RUBY_CONFIG} 'puts C["ruby_version"]'
RUBY_SUFFIX?=		# empty

RUBY_ARCH!=		${_RUBY_CONFIG} 'puts C["target"]'
RUBY_NAME!=		${_RUBY_CONFIG} 'puts C["ruby_install_name"]'

_RUBY_SYSLIBDIR!=	${_RUBY_CONFIG} 'puts C["libdir"]'
_RUBY_SITEDIR!=		${_RUBY_CONFIG} 'puts C["sitedir"]'
_RUBY_VENDORDIR!=	${_RUBY_CONFIG} 'puts C["vendordir"]'
.else
RUBY?=			${LOCALBASE}/bin/${RUBY_NAME}

.if defined(RUBY_VER)
# When adding a version, please keep the comment in
# Mk/bsd.default-versions.mk in sync.
. if ${RUBY_VER} == 2.2
#
# Ruby 2.2
#
RUBY_RELVERSION=	2.2.5
RUBY_PORTREVISION=	0
RUBY_PORTEPOCH=		1
RUBY_PATCHLEVEL=	0
RUBY22=			""	# PLIST_SUB helpers

. elif ${RUBY_VER} == 2.3
#
# Ruby 2.3
#
RUBY_RELVERSION=	2.3.1
RUBY_PORTREVISION=	0
RUBY_PORTEPOCH=		1
RUBY_PATCHLEVEL=	0
RUBY23=			""	# PLIST_SUB helpers

. elif ${RUBY_VER} == 2.4
#
# Ruby 2.4
#
RUBY_RELVERSION=	2.4.7
RUBY_PORTREVISION=	0
RUBY_PORTEPOCH=		1
RUBY_PATCHLEVEL=	0
RUBY24=			""	# PLIST_SUB helpers

. elif ${RUBY_VER} == 2.5
#
# Ruby 2.5
#
RUBY_RELVERSION=	2.5.1
RUBY_PORTREVISION=	0
RUBY_PORTEPOCH=		1
RUBY_PATCHLEVEL=	0
RUBY25=			""	# PLIST_SUB helpers

. elif ${RUBY_VER} == 2.6
#
# Ruby 2.6
#
RUBY_RELVERSION=      2.6.6
RUBY_PORTREVISION=    0
RUBY_PORTEPOCH=               1
RUBY_PATCHLEVEL=      0
RUBY26=                       ""      # PLIST_SUB helpers

# When adding a version, please keep the comment in
# Mk/components/default-versions.mk in sync.
. else
#
# Other versions
#
IGNORE=	Only ruby 2.2 and 2.3, 2.4, 2.5, 2.6 are supported
_INVALID_RUBY_VER=	1
. endif
.endif # defined(RUBY_VER)

.if !defined(_INVALID_RUBY_VER)

RUBY22?=		"@comment "
RUBY23?=		"@comment "
RUBY24?=		"@comment "
RUBY25?=		"@comment "
RUBY26?=		"@comment "

.if defined(BROKEN_RUBY${RUBY_VER:R}${RUBY_VER:E})
.if ${BROKEN_RUBY${RUBY_VER:R}${RUBY_VER:E}} == "yes"
BROKEN=			does not build with Ruby ${RUBY_VER}
.else
BROKEN=			${BROKEN_RUBY${RUBY_VER:R}${RUBY_VER:E}}
.endif
.endif

.if ${RUBY_PATCHLEVEL} == 0
RUBY_VERSION?=		${RUBY_RELVERSION}
RUBY_DISTVERSION?=	${RUBY_RELVERSION}
.else
RUBY_VERSION?=		${RUBY_RELVERSION}.${RUBY_PATCHLEVEL}
RUBY_DISTVERSION?=	${RUBY_RELVERSION}-p${RUBY_PATCHLEVEL}
.endif

RUBY_WRKSRC=		${WRKDIR}/ruby-${RUBY_DISTVERSION}

RUBY_CONFIGURE_ARGS+=	--with-rubyhdrdir="${PREFIX}/include/ruby-${RUBY_VER}/" \
			--with-rubylibprefix="${PREFIX}/lib/ruby" \
			--docdir="${RUBY_DOCDIR}" \
			--with-soname=ruby${RUBY_SUFFIX}

CONFIGURE_TARGET?=	${ARCH}-portbld-midnightbsd${OSREL:C/\..*//}

RUBY_ARCH?=		${ARCH}-midnightbsd${OSREL:C/\..*//}
RUBY_NAME?=		ruby${RUBY_SUFFIX}

_RUBY_SYSLIBDIR?=	${PREFIX}/lib
_RUBY_SITEDIR?=		${_RUBY_SYSLIBDIR}/ruby/site_ruby
_RUBY_VENDORDIR?=	${_RUBY_SYSLIBDIR}/ruby/vendor_ruby
.endif
.endif
#      defined(RUBY)

.if !defined(_INVALID_RUBY_VER)

.if defined(LANG) && !empty(LANG)
GEM_ENV+=		LANG=${LANG}
.else
GEM_ENV+=		LANG=en_US.UTF-8
.endif

.if defined(LC_ALL) && !empty(LC_ALL)
GEM_ENV+=		LC_ALL=${LC_ALL}
.else
GEM_ENV+=		LC_ALL=en_US.UTF-8
.endif

.if defined(LC_CTYPE) && !empty(LC_CTYPE)
GEM_ENV+=		LC_CTYPE=${LC_CTYPE}
.else
GEM_ENV+=		LC_CTYPE=UTF-8
.endif

RUBY_DEFAULT_SUFFIX?=	${RUBY_DEFAULT_VER:S/.//}

RUBY_DISTVERSION?=	${RUBY_VERSION}
RUBY_PORTVERSION?=	${RUBY_VERSION}
MASTER_SITE_SUBDIR_RUBY?=	${RUBY_VER}
RUBY_DISTNAME?=		ruby-${RUBY_DISTVERSION}

RUBY_WRKSRC?=		${WRKDIR}/${RUBY_DISTNAME}

RUBY_RELVERSION_CODE?=	${RUBY_RELVERSION:S/.//g}
RUBY_VERSION_CODE?=	${RUBY_VERSION:S/.//g}
RUBY_VER=		${RUBY_VERSION:C/([[:digit:]]+\.[[:digit:]]+).*/\1/}
RUBY_SUFFIX=		${RUBY_VER:S/.//}

RUBY_WITHOUT_SUFFIX?=	${LOCALBASE}/bin/ruby
RUBY_WITH_SUFFIX?=	${RUBY_WITHOUT_SUFFIX}${RUBY_SUFFIX}

RUBY_PKGNAMEPREFIX?=	ruby${RUBY_SUFFIX}-
RUBY_SHLIBVER?=		${RUBY_VER:S/.//}

RUBY_CONFIGURE_ARGS+=	--program-prefix=""

.if ${RUBY_VER} != ${RUBY_DEFAULT_VER}
DEPENDS_ARGS+=		RUBY_VER=${RUBY_VER}
.endif

RUBY_CONFIGURE_ARGS+=	--program-suffix="${RUBY_SUFFIX}"

RUBY_MODNAME?=		${PORTNAME}

# Commands
RUBY_RD2?=		${LOCALBASE}/bin/rd2
RUBY_RDOC?=		${LOCALBASE}/bin/rdoc${RUBY_VER:S/.//}

# Ports
RUBY_BASE_PORT?=	lang/ruby${RUBY_VER:S/.//}
RUBY_PORT?=		${RUBY_BASE_PORT}
RUBY_RDTOOL_PORT?=	textproc/ruby-rdtool

# Depends
DEPEND_LIBRUBY?=	lib${RUBY_NAME}.so.${RUBY_SHLIBVER}:${RUBY_PORT}
DEPEND_RUBY?=		${RUBY}:${RUBY_PORT}
DEPEND_RUBY_RDTOOL?=	${RUBY_RD2}:${RUBY_RDTOOL_PORT}

# Directories
RUBY_LIBDIR?=		${_RUBY_SYSLIBDIR}/ruby/${RUBY_VER}
RUBY_ARCHLIBDIR?=	${RUBY_LIBDIR}/${RUBY_ARCH}
RUBY_SITELIBDIR?=	${_RUBY_SITEDIR}/${RUBY_VER}
RUBY_SITEARCHLIBDIR?=	${RUBY_SITELIBDIR}/${RUBY_ARCH}
RUBY_VENDORLIBDIR?=	${_RUBY_VENDORDIR}/${RUBY_VER}
RUBY_VENDORARCHLIBDIR?=	${RUBY_VENDORLIBDIR}/${RUBY_ARCH}
RUBY_DOCDIR?=		${PREFIX}/share/doc/${RUBY_NAME}
RUBY_EXAMPLESDIR?=	${PREFIX}/share/examples/${RUBY_NAME}
RUBY_RIDIR?=		${PREFIX}/share/ri/${RUBY_VER}/system
RUBY_SITERIDIR?=	${PREFIX}/share/ri/${RUBY_VER}/site
RUBY_MODDOCDIR?=	${RUBY_DOCDIR}/${RUBY_MODNAME}
RUBY_MODEXAMPLESDIR?=	${RUBY_EXAMPLESDIR}/${RUBY_MODNAME}
RUBY_ELISPDIR?=		${PREFIX}/lib/ruby/elisp

# PLIST
PLIST_RUBY_DIRS=	RUBY_LIBDIR="${RUBY_LIBDIR}" \
			RUBY_ARCHLIBDIR="${RUBY_ARCHLIBDIR}" \
			RUBY_SITELIBDIR="${RUBY_SITELIBDIR}" \
			RUBY_SITEARCHLIBDIR="${RUBY_SITEARCHLIBDIR}" \
			RUBY_VENDORLIBDIR="${RUBY_VENDORLIBDIR}" \
			RUBY_VENDORARCHLIBDIR="${RUBY_VENDORARCHLIBDIR}" \
			RUBY_MODDOCDIR="${RUBY_MODDOCDIR}" \
			RUBY_MODEXAMPLESDIR="${RUBY_MODEXAMPLESDIR}" \
			RUBY_DOCDIR="${RUBY_DOCDIR}" \
			RUBY_EXAMPLESDIR="${RUBY_EXAMPLESDIR}" \
			RUBY_RIDIR="${RUBY_RIDIR}" \
			RUBY_SITERIDIR="${RUBY_SITERIDIR}" \
			RUBY_ELISPDIR="${RUBY_ELISPDIR}"

PLIST_SUB+=		${PLIST_RUBY_DIRS:C,DIR="(${LOCALBASE}|${PREFIX})/,DIR=",} \
			RUBY_VERSION="${RUBY_VERSION}" \
			RUBY_VER="${RUBY_VER}" \
			RUBY_SHLIBVER="${RUBY_SHLIBVER}" \
			RUBY_ARCH="${RUBY_ARCH}" \
			RUBY_SUFFIX="${RUBY_SUFFIX}" \
			RUBY_NAME="${RUBY_NAME}" \
			RUBY_DEFAULT_SUFFIX="${RUBY_DEFAULT_SUFFIX}" \
			RUBY21=${RUBY21} \
			RUBY22=${RUBY22} \
			RUBY23=${RUBY23} \
			RUBY24=${RUBY24} \
			RUBY25=${RUBY25}

.if defined(USE_RUBY_RDOC)
MAKE_ENV+=	RUBY_RDOC=${RUBY_RDOC}
.endif

# require check
.if defined(RUBY_REQUIRE)
USE_RUBY=		yes

.if exists(${RUBY})
RUBY_PROVIDED!=		${RUBY} -e '\
	Ruby = ${RUBY_RELVERSION_CODE}; \
	value = begin; ${RUBY_REQUIRE}; end and puts value'
.else
RUBY_PROVIDED=		"should be"	# the latest version is going to be installed
.endif

.if empty(RUBY_PROVIDED)
.undef RUBY_PROVIDED
.endif
.endif

# fix shebang lines
.if defined(RUBY_SHEBANG_FILES) && !empty(RUBY_SHEBANG_FILES)
USE_RUBY=		yes

post-patch:	ruby-shebang-patch

ruby-shebang-patch:
	@cd ${WRKSRC}; for f in ${RUBY_SHEBANG_FILES}; do \
	${ECHO_MSG} "===>  Fixing the #! line of $$f"; \
	TMPFILE=`mktemp -t rubyshebang`; \
	cp $$f $$TMPFILE; \
	${AWK} 'BEGIN {flag = 0;}								\
		{										\
			if (flag == 0) {							\
				if ($$0 ~ /^#!/) {						\
					sub(/#!(.*\/)?(env[[:space:]]+)?ruby/, "#!${RUBY}", $$0);\
					print $$0;						\
				}								\
				else {								\
					print "#!${RUBY}";					\
					print $$0;						\
				}								\
				flag = 1;							\
			} else {								\
				print $$0;							\
			}									\
		}' $$TMPFILE > $$f; \
	rm -f $$TMPFILE; \
	done
.endif

.if ${PORT_OPTIONS:MDEBUG}
RUBY_FLAGS+=	-d
.endif

#
# RubyGems support
#
.if defined(USE_RUBYGEMS)

BUILD_DEPENDS+=	${RUBYGEMBIN}:devel/ruby-gems
RUN_DEPENDS+=	${RUBYGEMBIN}:devel/ruby-gems

PKGNAMEPREFIX?=	rubygem-
EXTRACT_SUFX=	.gem
EXTRACT_ONLY=
DIST_SUBDIR=	rubygem

EXTRACT_DEPENDS+=	${RUBYGEMBIN}:devel/ruby-gems
GEMS_BASE_DIR=	lib/ruby/gems/${RUBY_VER}
GEMS_DIR=	${GEMS_BASE_DIR}/gems
DOC_DIR=	${GEMS_BASE_DIR}/doc
CACHE_DIR=	${GEMS_BASE_DIR}/cache
SPEC_DIR=	${GEMS_BASE_DIR}/specifications
EXT_DIR=	${GEMS_BASE_DIR}/extensions
GEM_NAME?=	${PORTNAME}-${PORTVERSION}
GEM_LIB_DIR?=	${GEMS_DIR}/${GEM_NAME}
GEM_DOC_DIR?=	${DOC_DIR}/${GEM_NAME}
GEM_SPEC?=	${SPEC_DIR}/${GEM_NAME}.gemspec
GEM_CACHE?=	${CACHE_DIR}/${GEM_NAME}.gem

PLIST_SUB+=	PORTVERSION="${PORTVERSION}" \
		REV="${RUBY_GEM}" \
		GEMS_BASE_DIR="lib/ruby/gems/${RUBY_VER}" \
		GEMS_DIR="${GEMS_DIR}" \
		DOC_DIR="${DOC_DIR}" \
		CACHE_DIR="${CACHE_DIR}" \
		SPEC_DIR="${SPEC_DIR}" \
		EXT_DIR="${EXT_DIR}" \
		PORT="${PORTNAME}-${PORTVERSION}" \
		GEM_NAME="${GEM_NAME}" \
		GEM_LIB_DIR="${GEM_LIB_DIR}" \
		GEM_DOC_DIR="${GEM_DOC_DIR}" \
		GEM_SPEC="${GEM_SPEC}" \
		GEM_CACHE="${GEM_CACHE}" \
		EXTRACT_SUFX="${EXTRACT_SUFX}"

RUBYGEMBIN=	${LOCALBASE}/bin/gem${RUBY_VER:S/.//}

. if defined(DISTFILES)
GEMFILES=	${DISTFILES:C/:[^:]+$//}
. else
GEMFILES=	${DISTNAME}${EXTRACT_SUFX}
. endif

GEMSPEC=	${PORTNAME}.gemspec

RUBYGEM_ARGS=-l --no-update-sources --install-dir ${PREFIX}/lib/ruby/gems/${RUBY_VER} --ignore-dependencies --bindir=${PREFIX}/bin
GEM_ENV+=	RB_USER_INSTALL=yes
.if defined(NOPORTDOCS)
RUBYGEM_ARGS+=	--no-rdoc --no-ri
.else
RUBYGEM_ARGS+=	--rdoc --ri
.endif

do-extract:
	@${SETENV} ${GEM_ENV} ${RUBYGEMBIN} unpack --target=${WRKDIR} ${DISTDIR}/${DIST_SUBDIR}/${GEMFILES}
	@(cd ${BUILD_WRKSRC}; if ! ${SETENV} ${GEM_ENV} ${RUBYGEMBIN} spec --ruby ${DISTDIR}/${DIST_SUBDIR}/${GEMFILES} > ${GEMSPEC} ; then \
		if [ -n "${BUILD_FAIL_MESSAGE}" ] ; then \
			${ECHO_MSG} "===> Extraction failed unexpectedly."; \
			(${ECHO_CMD} "${BUILD_FAIL_MESSAGE}") | ${FMT} 75 79 ; \
			fi; \
		${FALSE}; \
		fi)

do-build:
	@(cd ${BUILD_WRKSRC}; if ! ${SETENV} ${GEM_ENV} ${RUBYGEMBIN} build --force ${GEMSPEC} ; then \
		if [ -n "${BUILD_FAIL_MESSAGE}" ] ; then \
			${ECHO_MSG} "===> Compilation failed unexpectedly."; \
			(${ECHO_CMD} "${BUILD_FAIL_MESSAGE}") | ${FMT} 75 79 ; \
			fi; \
		${FALSE}; \
		fi)

do-install:
	(cd ${BUILD_WRKSRC}; ${SETENV} ${GEM_ENV} ${RUBYGEMBIN} install ${RUBYGEM_ARGS} ${GEMFILES} -- --build-args ${CONFIGURE_ARGS})
	${RM} -r ${PREFIX}/${GEMS_BASE_DIR}/build_info/
	${RMDIR} ${PREFIX}/${EXT_DIR} 2> /dev/null || ${TRUE}
.if defined(NOPORTDOCS)
	-@${RMDIR} ${PREFIX}/${DOC_DIR}
.endif

. if defined(RUBYGEM_AUTOPLIST)
.  if !target(post-install-script)
post-install-script:
	@${ECHO} ${GEM_CACHE} >> ${TMPPLIST}
	@${ECHO} ${GEM_SPEC} >> ${TMPPLIST}
.if !defined(NOPORTDOCS)
	@${FIND} -ds ${PREFIX}/${DOC_DIR} -type f -print | ${SED} -E -e \
		's,^${PREFIX}/?,,' >> ${TMPPLIST}
.endif
	@${FIND} -ds ${PREFIX}/${GEM_LIB_DIR} -type f -print | ${SED} -E -e \
		's,^${PREFIX}/?,,' >> ${TMPPLIST}
	@if [ -d ${PREFIX}/${EXT_DIR} ]; then \
		${FIND} -ds ${PREFIX}/${EXT_DIR} -type f -print | ${SED} -E -e \
		's,^${PREFIX}/?,,' >> ${TMPPLIST} ; \
	fi
.  endif
. endif

.endif # USE_RUBYGEMS

#
# extconf.rb support
#
.if defined(USE_RUBY_EXTCONF)
USE_RUBY=		yes

RUBY_EXTCONF?=		extconf.rb
CONFIGURE_ARGS+=	--with-opt-dir="${LOCALBASE}"
CONFIGURE_ENV+=		RB_USER_INSTALL=yes

do-configure:	ruby-extconf-configure

ruby-extconf-configure:
.if defined(RUBY_EXTCONF_SUBDIRS)
.for d in ${RUBY_EXTCONF_SUBDIRS}
	@${ECHO_MSG} "===>  Running ${RUBY_EXTCONF} in ${d} to configure"
	@cd ${CONFIGURE_WRKSRC}/${d}; \
	${SETENV} ${CONFIGURE_ENV} ${RUBY} ${RUBY_FLAGS} ${RUBY_EXTCONF} ${CONFIGURE_ARGS}
.endfor
.else
	@${ECHO_MSG} "===>  Running ${RUBY_EXTCONF} to configure"
	@cd ${CONFIGURE_WRKSRC}; \
	${SETENV} ${CONFIGURE_ENV} ${RUBY} ${RUBY_FLAGS} ${RUBY_EXTCONF} ${CONFIGURE_ARGS}
.endif
.endif

#
# setup.rb support
#
.if defined(USE_RUBY_SETUP)
RUBY_SETUP?=		setup.rb

do-configure:	ruby-setup-configure

ruby-setup-configure:
	@${ECHO_MSG} "===>  Running ${RUBY_SETUP} to configure"
	@cd ${BUILD_WRKSRC}; \
	${SETENV} ${CONFIGURE_ENV} ${RUBY} ${RUBY_FLAGS} ${RUBY_SETUP} config ${CONFIGURE_ARGS}

do-build:	ruby-setup-build

ruby-setup-build:
	@${ECHO_MSG} "===>  Running ${RUBY_SETUP} to build"
	@cd ${BUILD_WRKSRC}; \
	${SETENV} ${MAKE_ENV} ${RUBY} ${RUBY_FLAGS} ${RUBY_SETUP} setup

do-install:	ruby-setup-install

ruby-setup-install:
	@${ECHO_MSG} "===>  Running ${RUBY_SETUP} to install"
	@cd ${INSTALL_WRKSRC}; \
	${SETENV} ${MAKE_ENV} ${RUBY} ${RUBY_FLAGS} ${RUBY_SETUP} install --prefix=${FAKE_DESTDIR}
.endif

.if defined(USE_LIBRUBY)
LIB_DEPENDS+=		${DEPEND_LIBRUBY}
.endif

.if defined(USE_RUBY)
.if !defined(RUBY_NO_BUILD_DEPENDS)
EXTRACT_DEPENDS+=	${DEPEND_RUBY}
PATCH_DEPENDS+=		${DEPEND_RUBY}
BUILD_DEPENDS+=		${DEPEND_RUBY}
.endif
.if !defined(RUBY_NO_RUN_DEPENDS)
RUN_DEPENDS+=		${DEPEND_RUBY}
.endif
.endif

.if defined(USE_RAKE)
BUILD_DEPENDS+=		${LOCALBASE}/bin/rake:devel/rubygem-rake
RAKE_BIN=	${LOCALBASE}/bin/rake
.endif

# documents

RUBY_NO_RD_HTML=	yes

.if defined(RUBY_RD_HTML)
.undef RUBY_NO_RD_HTML
.endif

.if defined(NOPORTDOCS)
RUBY_NO_RD_HTML=	yes
.endif

.if defined(RUBY_RD_FILES) && !defined(RUBY_NO_RD_HTML)
USE_RUBY_RDTOOL=	yes

RUBY_RD_HTML_FILES=	${RUBY_RD_FILES:S/.rb$//:S/.rd././:S/.rd$//:S/$/.html/}

PLIST_SUB+=		RUBY_RD_HTML_FILES=""

pre-install:	ruby-rd-build

ruby-rd-build:
.if !empty(RUBY_RD_FILES)
	@${ECHO_MSG} "===>  Generating HTML documents from RD documents"
	@cd ${WRKSRC}; for rd in ${RUBY_RD_FILES}; do \
		html=$$(echo $$rd | ${SED} 's/\.rb$$//;s/\.rd\././;s/\.rd$$//').html; \
		${ECHO_MSG} "${RUBY_RD2} $$rd > $$html"; \
		${RUBY_RD2} $$rd > $$html; \
	done
.else
	@${DO_NADA}
.endif

.else
RUBY_RD_HTML_FILES=	# empty

PLIST_SUB+=		RUBY_RD_HTML_FILES="@comment "
.endif

.if !defined(NOPORTDOCS) && defined(USE_RUBY_RDTOOL)
BUILD_DEPENDS+=		${DEPEND_RUBY_RDTOOL}
.endif

.endif # _INVALID_RUBY_VER
.endif
