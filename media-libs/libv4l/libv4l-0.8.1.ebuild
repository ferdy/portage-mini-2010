# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libv4l/libv4l-0.8.1.ebuild,v 1.8 2011/01/04 00:52:12 xmw Exp $

EAPI=3
inherit linux-info multilib toolchain-funcs

MY_P=v4l-utils-${PV}

DESCRIPTION="Separate libraries ebuild from upstream v4l-utils package"
HOMEPAGE="http://git.linuxtv.org/v4l-utils.git"
SRC_URI="http://linuxtv.org/downloads/v4l-utils/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND=">=sys-kernel/linux-headers-2.6.30-r1"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="~SHMEM"

src_compile() {
	tc-export CC
	pushd lib
	emake PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		CFLAGS="${CFLAGS}" || die
	popd
}

src_install() {
	pushd lib
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)" install || die
	popd
	dodoc ChangeLog README.lib* TODO || die
}
