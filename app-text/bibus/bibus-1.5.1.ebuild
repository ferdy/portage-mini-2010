# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibus/bibus-1.5.1.ebuild,v 1.5 2010/09/13 21:13:21 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit multilib eutils python versionator

DESCRIPTION="Bibliographic and reference management software, integrates with OO.o and MS Word"
HOMEPAGE="http://bibus-biblio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}-biblio/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="mysql"

# Most of this mess is designed to give the choice of sqlite or mysql
# but prefer sqlite. We also need to default to sqlite if neither is requested.
# bibus fails to start with app-office/openoffice-bin (bug #288232).
RDEPEND="app-office/openoffice
	=dev-python/wxpython-2.8*
	dev-python/pysqlite
	dev-db/sqliteodbc
	mysql? (
		dev-python/mysql-python
		dev-db/myodbc
	)
	dev-db/unixODBC"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.5.0-install.patch
	epatch "${FILESDIR}"/${PN}-1.5.0-pysqlite.patch
	sed -e "s:gentoo-python:python$(python_get_version):g" \
		-i Makefile Setup/Makefile Setup/bibus.cfg Setup/bibus.sh \
		|| die "Failed to adjust python paths"

	# Disable byte-compilation of Python modules.
	sed -e '/\$(compile)/d' -i Makefile || die "sed failed"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install || die "emake install failed"
	emake \
		DESTDIR="${D}" \
		oopath="/usr/$(get_libdir)/openoffice/program" \
		prefix='$(DESTDIR)/usr' \
		sysconfdir='$(DESTDIR)/etc' \
		install-doc-en || die "emake install failed"
}

pkg_postinst() {
	python_mod_optimize bibus
}

pkg_postrm() {
	python_mod_cleanup bibus
}
