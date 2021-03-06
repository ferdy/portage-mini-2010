# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/table/table-1.5.54-r2.ebuild,v 1.6 2008/06/14 23:30:29 ulm Exp $

inherit elisp versionator

DESCRIPTION="Table editor for Emacs"
HOMEPAGE="http://table.sourceforge.net/"
SRC_URI="mirror://sourceforge/table/${P}.el.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_compile() {
	elisp-compile *.el || die "elisp-compile failed"
	elisp-make-autoload-file || die "elisp-make-autoload-file failed"
}

src_install() {
	elisp_src_install
	# prevent inclusion of package dir by subdirs.el
	touch "${D}${SITELISP}/${PN}/.nosearch"
}

pkg_postinst() {
	elisp-site-regen

	if version_is_at_least 22 "$(elisp-emacs-version)"; then
		echo
		elog "Please note that \"${PN}\" is already included with Emacs 22 or"
		elog "later, so ${CATEGORY}/${PN} is only needed for lower versions."
		elog "You may select the active Emacs version with \"eselect emacs\"."
	fi
}
