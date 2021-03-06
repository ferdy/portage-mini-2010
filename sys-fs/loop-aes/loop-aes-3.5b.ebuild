# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.5b.ebuild,v 1.5 2011/01/08 21:34:37 maekke Exp $

EAPI="3"

inherit eutils linux-mod

MY_P="${PN/aes/AES}-v${PV}"

DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ~ppc ~sparc x86"
IUSE="extra-ciphers keyscrub padlock"

DEPEND="|| ( >=sys-apps/util-linux-2.12r[crypt] >=sys-apps/util-linux-2.12r[loop-aes] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-mod_pkg_setup

	CONFIG_CHECK="!BLK_DEV_LOOP"
	MODULE_NAMES="loop(block::tmp-d-kbuild)"
	BUILD_TARGETS="all"

	BUILD_PARAMS=" \
		LINUX_SOURCE=\"${KERNEL_DIR}\" \
		KBUILD_OUTPUT=\"${KBUILD_OUTPUT}\" \
		USE_KBUILD=y MODINST=n RUNDM=n"
	use keyscrub && BUILD_PARAMS="${BUILD_PARAMS} KEYSCRUB=y"
	use padlock && BUILD_PARAMS="${BUILD_PARAMS} PADLOCK=y"

	if use extra-ciphers; then
		MODULE_NAMES="${MODULE_NAMES}
			loop_blowfish(block::tmp-d-kbuild)
			loop_serpent(block::tmp-d-kbuild)
			loop_twofish(block::tmp-d-kbuild)"
		BUILD_PARAMS="${BUILD_PARAMS} EXTRA_CIPHERS=y"
	fi
}

src_prepare() {
	sed -e 's/make/$(MAKE)/g' -i Makefile || die "sed failed"

	# http://loop-aes.sourceforge.net/updates/loop-AES-v3.5b-20101231.diff.bz2
	epatch "${FILESDIR}/loop-AES-v3.5b-20101231.diff"
}

src_install() {
	linux-mod_src_install

	dodoc README || die "dodoc failed"
	dobin loop-aes-keygen || die "dobin failed"
	doman loop-aes-keygen.1 || die "doman failed"
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo
	einfo "For more instructions take a look at examples in README at:"
	einfo "'${EPREFIX}/usr/share/doc/${PF}'"
	einfo
}
