# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libpano13/libpano13-2.9.17_rc1.ebuild,v 1.1 2010/09/04 13:27:04 maekke Exp $

EAPI=2

inherit eutils versionator java-pkg-opt-2 multilib

DESCRIPTION="Helmut Dersch's panorama toolbox library"
HOMEPAGE="http://panotools.sf.net"
SRC_URI="mirror://sourceforge/panotools/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="java static-libs"
DEPEND="
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	java? ( >=virtual/jdk-1.3 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_configure() {
	econf \
		$(use_with java java ${JAVA_HOME}) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README README.linux AUTHORS NEWS doc/*.txt
	if ! use static-libs; then
		find "${D}"/usr/$(get_libdir) -name '*.la' -delete || die
	fi
}

pkg_postinst() {
	ewarn "you should remerge all reverse dependencies (media-gfx/hugin and"
	ewarn "media-gfx/autopano-sift-C) as they might not work anymore"
}