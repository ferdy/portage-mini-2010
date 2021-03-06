# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec-core/rspec-core-2.4.0.ebuild,v 1.2 2011/02/02 14:12:44 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_TASK_DOC="none"

RUBY_FAKEGEM_EXTRADOC="History.markdown README.md Upgrade.markdown"

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="${RDEPEND} !<dev-ruby/rspec-1.3.1-r1"

ruby_add_bdepend "test? (
		dev-ruby/syntax
		dev-ruby/rspec-expectations:2
		dev-ruby/rspec-mocks:2
	)"

#	>=dev-ruby/cucumber-0.5.3
#	>=dev-ruby/autotest-4.2.9
#	dev-ruby/aruba"

all_ruby_prepare() {
	# Don't set up bundler: it doesn't understand our setup.
	sed -i -e '/[Bb]undler/d' Rakefile || die

	# Remove the Gemfile to avoid running through 'bundle exec'
	rm Gemfile || die

	# Also clean the /usr/lib/rubyee path (which is our own invention).
	sed -i -e 's#lib\\d\*\\/ruby\\/#lib\\d*\\/ruby(ee|)\\/#' lib/rspec/core/configuration.rb || die

	epatch "${FILESDIR}"/${P}-tests.patch
}

all_ruby_compile() {
	if use doc ; then
		RUBYLIB="${S}/lib" rake rdoc || die "Unable to create documentation."
	fi
}

each_ruby_test() {
	PATH="${S}/bin:${PATH}" RUBYLIB="${S}/lib" ${RUBY} -S rake spec || die "Tests failed."

	# There are features but they require aruba which we don't have yet.
}
