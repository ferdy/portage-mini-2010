# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/gibbler/gibbler-0.8.7.ebuild,v 1.1 2011/02/09 08:02:06 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST=""

RUBY_FAKEGEM_TASK_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.txt README.rdoc"

RUBY_FAKEGEM_BINWRAP=""

inherit ruby-fakegem

DESCRIPTION="Git-like hashes for Ruby objects"
HOMEPAGE="http://solutious.com/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/attic-0.4.0"

ruby_add_bdepend "test? ( dev-ruby/tryouts:2 )"

SRC_URI="https://github.com/delano/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/delano-${PN}-*"

each_ruby_test() {
	${RUBY} -S try || die "tests failed"
}
