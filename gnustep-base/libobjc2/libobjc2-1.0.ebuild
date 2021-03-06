# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/libobjc2/libobjc2-1.0.ebuild,v 1.1 2010/10/13 15:16:41 voyageur Exp $

EAPI=3
inherit multilib

# We need gnustep-make, but gnustep-make can depend on libobjc
# Use a temporary setup to install in /usr/
GSMAKE=gnustep-make-2.4.0
DESCRIPTION="GNUstep Objective-C runtime"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="http://download.gna.org/gnustep/${P}.tar.bz2
	ftp://ftp.gnustep.org/pub/gnustep/core/${GSMAKE}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/gcc-3.3[objc]
	>=sys-devel/make-3.75"
RDEPEND=""

S=${WORKDIR}/${PN}
GSMAKE_S=${WORKDIR}/${GSMAKE}

src_prepare() {
	# Multilib-strict
	cd "${GSMAKE_S}"
	sed -e "s/lib/$(get_libdir)/g" \
		-i FilesystemLayouts/fhs-system || die "multilib path sed failed"
}

src_configure() {
	cd "${GSMAKE_S}"
	econf --with-layout=fhs-system
}

src_compile() {
	emake GNUSTEP_MAKEFILES="${GSMAKE_S}" || die "compilation failed"
}

src_install() {
	emake GNUSTEP_MAKEFILES="${GSMAKE_S}" \
		GNUSTEP_CONFIG_FILE="${GSMAKE_S}"/GNUstep.conf \
		GNUSTEP_INSTALLATION_DOMAIN=SYSTEM \
		DESTDIR="${D}" install || die "install has failed"
}
