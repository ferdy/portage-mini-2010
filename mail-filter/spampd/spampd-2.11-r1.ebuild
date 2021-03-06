# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/spampd/spampd-2.11-r1.ebuild,v 1.7 2007/04/22 09:05:55 ticho Exp $

DESCRIPTION="spampd is a program used within an e-mail delivery system to scan messages for possible Unsolicited Commercial E-mail content."
HOMEPAGE="http://www.worlddesign.com/index.cfm/rd/mta/spampd.htm"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/net-server
	mail-filter/spamassassin"

src_install() {
	dosbin spampd
	dodoc COPYING README.Gentoo changelog.txt spampd-rh-rc-script
	dohtml spampd.html
	newinitd ${FILESDIR}/init spampd
	newconfd ${FILESDIR}/conf spampd
}
