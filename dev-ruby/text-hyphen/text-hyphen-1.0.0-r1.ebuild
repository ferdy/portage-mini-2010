# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/text-hyphen/text-hyphen-1.0.0-r1.ebuild,v 1.11 2010/08/29 18:02:19 armin76 Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README Changelog"

inherit ruby-fakegem eutils

DESCRIPTION="Hyphenates various words according to the rules of the language the word is written in."
HOMEPAGE="http://rubyforge.org/projects/text-format"
SRC_URI="mirror://rubyforge/text-format/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ~ppc64 ~sparc x86 ~x86-solaris"
IUSE=""

ruby_add_bdepend "
	test? (
		dev-ruby/archive-tar-minitar
		virtual/ruby-test-unit
	)"

all_ruby_prepare() {
	# Fix rakefile for new rake versions
	sed -i -e 's: if t\.verbose::' Rakefile || die

	epatch "${FILESDIR}/${P}+ruby-1.9.patch"
}
