# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/pointless/pointless-1.5.12.ebuild,v 1.2 2011/01/16 12:22:09 xarthisius Exp $

EAPI="3"

PYTHON_DEPEND="2"

inherit eutils multilib python toolchain-funcs

DESCRIPTION="Scores crystallographic Laue and space groups"
HOMEPAGE="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/pointless.html"
SRC_URI="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/${P}.tar.gz"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="test"

RDEPEND="
	sci-chemistry/ccp4-apps
	>=sci-libs/ccp4-libs-6.1.3
	>=sci-libs/cctbx-2010.03.29.2334-r3"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/1.5.1-gcc4.4.patch
}

src_compile() {
	emake  \
		-f Makefile.make \
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}" \
		LFLAGS="${LDFLAGS}" \
		CLIB="${EPREFIX}/usr/$(get_libdir)" \
		CCTBX_VERSION=2010 \
		ICCP4=-I"${EPREFIX}/usr/include/ccp4" \
		ITBX="-I${EPREFIX}/usr/include" \
		ICLPR="-I${EPREFIX}/$(python_get_sitedir)/" \
		LTBX="-L${EPREFIX}/usr/$(get_libdir)/cctbx/cctbx_build/lib -lcctbx" \
		SLIB="$(gcc-config -L | awk -F: '{for(i=1; i<=NF; i++) printf " -L%s", $i}') -L${EPREFIX}/usr/$(get_libdir) -lgfortran -lgfortranbegin" \
		|| die
}

src_install() {
	dobin pointless othercell || die
}
