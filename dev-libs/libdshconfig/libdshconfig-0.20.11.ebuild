# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libdshconfig/libdshconfig-0.20.11.ebuild,v 1.2 2009/09/23 17:21:58 patrick Exp $

DESCRIPTION="Library for parsing dsh.style configuration files"
HOMEPAGE="http://www.netfort.gr.jp/~dancer/software/downloads/"
SRC_URI="http://www.netfort.gr.jp/~dancer/software/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=""
RDEPEND="virtual/ssh"

src_install() {
	make install DESTDIR=${D} || die
}
