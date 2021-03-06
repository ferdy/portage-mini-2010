# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/quixml/quixml-0.2.1-r1.ebuild,v 1.7 2010/05/22 15:36:54 flameeyes Exp $

inherit ruby

USE_RUBY="ruby18"

DESCRIPTION="A fast Ruby XML API written in C"
HOMEPAGE="http://quixml.rubyforge.org/"
SRC_URI="http://rubyforge.org/download.php/89/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa ppc sparc x86"
IUSE=""

DEPEND="dev-libs/expat"

src_install() {
	ruby_einstall || die

	dodoc BUGS CHANGELOG README
	dohtml DOC.html
}
