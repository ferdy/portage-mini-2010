# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ntl/ntl-5.5.2.ebuild,v 1.6 2010/12/25 12:07:27 grobian Exp $

EAPI=3
inherit toolchain-funcs eutils multilib

DESCRIPTION="High-performance and portable Number Theory C++ library"
HOMEPAGE="http://shoup.net/ntl/"
SRC_URI="http://www.shoup.net/ntl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc"

RDEPEND=">=dev-libs/gmp-4.3
	>=dev-libs/gf2x-0.9"
DEPEND="${RDEPEND}
	dev-lang/perl"

S="${WORKDIR}/${P}/src"

src_prepare() {
	# fix parallel make
	sed -i -e "s/make/make ${MAKEOPTS}/g" WizardAux || die
	cd ..
	# enable compatibility with singular
	epatch "$FILESDIR/${P}-singular.patch"
	# implement a call back framework (submitted upstream)
	epatch "$FILESDIR/${P}-sage-tools.patch"
	# sanitize the makefile and allow the building of shared library
	epatch "$FILESDIR/${P}-shared.patch"
}

src_configure() {
	perl DoConfig \
		PREFIX="${EPREFIX}"/usr \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
		NTL_STD_CXX=on NTL_GMP_LIP=on NTL_GF2X_LIB=on \
		|| die "DoConfig failed"
}

src_compile() {
	# split the targets to allow parallel make to run properly
	emake setup1 setup2 || die "emake setup failed"
	emake setup3 || die "emake setup failed"
	sh Wizard on || die "Tuning wizard failed"
	emake ntl.a  || die "emake static failed"
	local trg=so
	[[ ${CHOST} == *-darwin* ]] && trg=dylib
	emake shared${trg} || die "emake shared failed"
}

src_install() {
	newlib.a ntl.a libntl.a || die "installation of static library failed"
	dolib.so lib*$(get_libname) || die "installation of shared library failed"

	cd ..
	insinto /usr/include
	doins -r include/NTL || die "installation of the headers failed"

	dodoc README
	if use doc ; then
		dodoc doc/*.txt || die
		dohtml doc/* || die
	fi
}
