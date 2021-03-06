# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cucumber-rails/cucumber-rails-0.3.2-r1.ebuild,v 1.2 2011/01/10 18:29:35 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""

# There are also cucumber features which depend on aruba which we
# don't have in our tree yet.
RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_EXTRAINSTALL="generators templates"
RUBY_FAKEGEM_EXTRADOC="HACKING.rdoc History.txt README.rdoc"

inherit ruby-fakegem

DESCRIPTION="Executable feature scenarios for Rails"
HOMEPAGE="http://github.com/aslakhellesoy/cucumber/wikis"
LICENSE="Ruby"

KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

ruby_add_bdepend test dev-ruby/rspec

ruby_add_rdepend ">=dev-util/cucumber-0.6.2"

each_ruby_install() {
	each_fakegem_install

	ruby_fakegem_doins VERSION
}
