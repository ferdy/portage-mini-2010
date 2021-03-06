# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ibuffer/ibuffer-2.6.1-r1.ebuild,v 1.3 2007/11/09 19:10:44 nixnut Exp $

inherit elisp versionator

DESCRIPTION="Operate on buffers like dired"
HOMEPAGE="http://www.shootybangbang.com/"
# taken from http://www.shootybangbang.com/software/ibuffer.el
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

SITEFILE=51${PN}-gentoo.el

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
