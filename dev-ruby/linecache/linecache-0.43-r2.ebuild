# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/linecache/linecache-0.43-r2.ebuild,v 1.3 2011/01/23 21:49:13 xarthisius Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="AUTHORS ChangeLog NEWS README"

inherit ruby-fakegem

DESCRIPTION="Caches files as might be used in a debugger or a tool that works with sets of Ruby source files."
HOMEPAGE="http://rubyforge.org/projects/rocky-hacks/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend "dev-ruby/rake
	test? ( virtual/ruby-test-unit )"

each_ruby_compile() {
	${RUBY} -S rake lib || die "build failed"
}

each_ruby_install() {
	each_fakegem_install
	ruby_fakegem_newins ext/trace_nums.so lib/trace_nums.so
}
