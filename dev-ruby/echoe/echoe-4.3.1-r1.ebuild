# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/echoe/echoe-4.3.1-r1.ebuild,v 1.4 2010/12/31 12:53:17 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_TASK_DOC="docs"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO"

RUBY_FAKEGEM_EXTRAINSTALL="vendor"

RUBY_FAKEGEM_GEMSPEC="echoe.gemspec"

inherit ruby-fakegem

DESCRIPTION="Packaging tool that provides Rake tasks for common operations"
HOMEPAGE="http://blog.evanweaver.com/files/doc/fauna/echoe/files/"

LICENSE="AFL-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_rdepend "dev-ruby/highline dev-ruby/rubyforge"

all_ruby_prepare() {
	# gemcutter is an optional dependency that is not important for
	# Gentoo itself.
	sed -i '/gemcutter/d' echoe.gemspec || die
}
