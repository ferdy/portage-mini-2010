# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/eruby/eruby-1.0.5-r2.ebuild,v 1.1 2010/06/21 05:12:29 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng

IUSE="vim-syntax examples"

DESCRIPTION="eRuby interprets a Ruby code embedded text file"
HOMEPAGE="http://www.modruby.net/"
SRC_URI="http://www.modruby.net/archive/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
PDEPEND="vim-syntax? ( app-vim/eruby-syntax )"

RUBY_PATCHES=( "${FILESDIR}"/${P}-missing-xldflags.patch )

each_ruby_configure() {
	${RUBY} configure.rb || die
}

each_ruby_compile() {
	emake || die
}

each_ruby_install() {
	emake install DESTDIR="${D}" || die
}

all_ruby_install() {
	dodoc ChangeLog README*
}
