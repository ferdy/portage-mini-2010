# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/mdadm/mdadm-3.1.4.ebuild,v 1.8 2010/11/09 19:17:44 armin76 Exp $

inherit eutils flag-o-matic

DESCRIPTION="A useful tool for running RAID systems - it can be used as a replacement for the raidtools"
HOMEPAGE="http://neil.brown.name/blog/mdadm"
SRC_URI="mirror://kernel/linux/utils/raid/mdadm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="static"

DEPEND=""
RDEPEND=">=sys-apps/util-linux-2.16"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-3.0-dont-make-man.patch
	epatch "${FILESDIR}"/${PN}-2.6-syslog-updates.patch
	epatch "${FILESDIR}"/${PN}-2.6.4-mdassemble.patch #211426
	use static && append-ldflags -static

	sed -i -e 's:-z now::' Makefile || die #331653
}

src_compile() {
	emake \
		CROSS_COMPILE=${CHOST}- \
		CWFLAGS="-Wall" \
		CXFLAGS="${CFLAGS}" \
		all mdassemble \
		|| die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	into /
	dosbin mdassemble || die
	dodoc ChangeLog INSTALL TODO README* ANNOUNCE-${PV}

	exeinto /$(get_libdir)/rcscripts/addons
	newexe "${FILESDIR}"/raid-start.sh-3.0 raid-start.sh || die
	newexe "${FILESDIR}"/raid-stop.sh raid-stop.sh || die

	insinto /etc
	newins mdadm.conf-example mdadm.conf
	newinitd "${FILESDIR}"/mdadm.rc mdadm || die
	newconfd "${FILESDIR}"/mdadm.confd mdadm || die
	newinitd "${FILESDIR}"/mdraid.rc-3.1.1 mdraid || die
	newconfd "${FILESDIR}"/mdraid.confd mdraid || die

	# do not rely on /lib -> /libXX link
	sed -i \
		-e "s-/lib/rcscripts/-/$(get_libdir)/rcscripts/-" \
		"${D}"/etc/init.d/*
}

pkg_postinst() {
	elog "If using baselayout-2 and not relying on kernel auto-detect"
	elog "of your RAID devices, you need to add 'mdraid' to your 'boot'"
	elog "runlevel. Run the following command:"
	elog "rc-update add mdraid boot"
}
