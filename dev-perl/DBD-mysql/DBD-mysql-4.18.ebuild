# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBD-mysql/DBD-mysql-4.18.ebuild,v 1.1 2011/01/14 11:55:52 tove Exp $

EAPI=3

MODULE_AUTHOR="CAPTTOFU"
MODULE_VERSION=4.018
inherit eutils perl-module

DESCRIPTION="The Perl DBD:mysql Module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/DBI
	virtual/mysql"
DEPEND="${RDEPEND}"

mydoc="ToDo"
