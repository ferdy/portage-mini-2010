# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lua/luadoc/luadoc-3.0.1.ebuild,v 1.1 2010/11/05 23:32:31 rafaelmartins Exp $

inherit multilib
DESCRIPTION="LuaDoc is a documentation tool for Lua source code"
HOMEPAGE="http://luadoc.luaforge.net/"
SRC_URI="http://luaforge.net/frs/download.php/3185/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/lua-5.1.3
	dev-lua/luafilesystem"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s|/usr/local|\$(DESTDIR)/usr|" \
		-e "s|lib|$(get_libdir)|" \
		-e "s|lua5.1|lua|" \
		config || die

	# lua-5.1.3
	find . -name '*.lua' | xargs sed -i -e "s/gfind/gmatch/g" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
	dohtml -r doc/us/*
}
