# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeakup/espeakup-9999.ebuild,v 1.6 2011/01/12 23:56:02 williamh Exp $

EGIT_REPO_URI="git://github.com/williamh/espeakup.git"
inherit git

DESCRIPTION="espeakup is a small lightweight connector for espeak and speakup"
HOMEPAGE="http://www.github.com/williamh/espeakup"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="app-accessibility/espeak"
RDEPEND="${DEPEND}
	|| ( >=virtual/linux-sources-2.6.37 app-accessibility/speakup )"

src_compile() {
	emake || die "Compile failed."
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install || die "Install failed."
	dodoc README ToDo
	newconfd "${FILESDIR}"/espeakup.confd espeakup
	newinitd "${FILESDIR}"/espeakup.rc espeakup
}

pkg_postinst() {
	elog "To get espeakup to start automatically, it is currently recommended"
	elog "that you add it to the default run level, by giving the following"
	elog "command as root."
	elog
	elog "rc-update add espeakup default"
	elog
	elog "You can also set a default voice now for espeakup."
	elog "See /etc/conf.d/espeakup for how to do this."
}
