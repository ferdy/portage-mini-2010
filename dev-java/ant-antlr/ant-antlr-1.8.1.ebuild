# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant-antlr/ant-antlr-1.8.1.ebuild,v 1.5 2010/11/05 03:02:37 halcy0n Exp $

EAPI="2"

# just a runtime dependency
ANT_TASK_DEPNAME=""

inherit ant-tasks

DESCRIPTION="Apache Ant's optional tasks for Antlr"
KEYWORDS="amd64 ~ppc ppc64 x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=">=dev-java/antlr-2.7.5-r3:0[java]"

src_install() {
	ant-tasks_src_install
	java-pkg_register-dependency antlr
}
