# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/sgml-common/sgml-common-0.6.3-r5.ebuild,v 1.22 2011/02/13 20:48:32 grobian Exp $

EAPI="3"

inherit autotools eutils prefix

DESCRIPTION="Base ISO character entities and utilities for SGML"
HOMEPAGE="http://www.iso.ch/cate/3524030.html"
SRC_URI="mirror://kde/devel/docbook/SOURCES/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	# We use a hacked version of install-catalog that supports the ROOT
	# variable, puts quotes around the CATALOG files, and can be prefixed.
	cp "${FILESDIR}/${P}-install-catalog.in" "${S}/bin/install-catalog.in"

	epatch "${FILESDIR}"/${P}-prefix.patch
	eprefixify bin/install-catalog.in bin/sgmlwhich config/sgml.conf

	epatch "${FILESDIR}"/${P}-configure.in.patch
	epatch "${FILESDIR}"/${P}-man_MANS.patch

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	local installer="${EROOT}usr/bin/install-catalog"
	if [[ ! -x ${installer} ]]; then
		eerror "install-catalog not found! Something went wrong!"
		die "install-catalog not found! Something went wrong!"
	fi

	einfo "Installing Catalogs..."
	"$installer" --add \
		"${EPREFIX}"/etc/sgml/sgml-ent.cat \
		"${EPREFIX}"/usr/share/sgml/sgml-iso-entities-8879.1986/catalog
	"$installer" --add \
		"${EPREFIX}"/etc/sgml/sgml-docbook.cat \
		"${EPREFIX}"/etc/sgml/sgml-ent.cat

	local file
	for file in `find "${EROOT}etc/sgml/" -name "*.cat"` "${EROOT}etc/sgml/catalog"
	do
		einfo "Fixing ${file}"
		awk '/"$/ { print $1 " " $2 }
			! /"$/ { print $1 " \"" $2 "\"" }' ${file} > ${file}.new
		mv ${file}.new ${file}
	done
}

pkg_prerm() {
	cp "${EROOT}usr/bin/install-catalog" "${T}"
}

pkg_postrm() {
	if [ ! -x  "${T}/install-catalog" ]; then
		return
	fi

	einfo "Removing Catalogs..."
	if [ -e "${EROOT}etc/sgml/sgml-ent.cat" ]; then
		"${T}"/install-catalog --remove \
			"${EPREFIX}"/etc/sgml/sgml-ent.cat \
			"${EPREFIX}"/usr/share/sgml/sgml-iso-entities-8879.1986/catalog
	fi

	if [ -e "${EROOT}etc/sgml/sgml-docbook.cat" ]; then
		"${T}"/install-catalog --remove \
			"${EPREFIX}"/etc/sgml/sgml-docbook.cat \
			"${EPREFIX}"/etc/sgml/sgml-ent.cat
	fi
}
