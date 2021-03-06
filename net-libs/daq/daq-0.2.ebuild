# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/daq/daq-0.2.ebuild,v 1.1 2010/11/02 18:11:18 patrick Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Data Acquisition library, for packet I/O"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/downloads/263 -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 afpacket dump +pcap"

DEPEND="pcap? ( >=net-libs/libpcap-1.0.0 )
		dump? ( >=net-libs/libpcap-1.0.0 )"

RDEPEND="${DEPEND}"

src_configure() {

	econf \
		$(use_enable ipv6) \
		$(use_enable pcap pcap-module) \
		$(use_enable afpacket afpacket-module) \
		$(use_enable dump dump-module) \
		--disable-ipfw-module \
		--disable-bundled-modules

}

src_install() {

	emake DESTDIR="${D}" install || die "make install failed"

	dodoc ChangeLog README

}

pkg_postinst() {

	elog
	elog "The Data Acquisition library (DAQ) for packet I/O replaces direct"
	elog "calls to PCAP functions with an abstraction layer that facilitates"
	elog "operation on a variety of hardware and software interfaces without"
	elog "requiring changes to application such as Snort."
	elog
	elog "The only DAQ modules supported with this ebuild are AFpacket, PCAP,"
	elog "and Dump. IPQ and NFQ will be supported in future versions of this"
	elog "package."
	elog
	elog "Please see the README file for DAQ for information about specific"
	elog "DAQ modules."
	ewarn
	ewarn "If you are reinstalling this package, you should also reinstall"
	ewarn "packages that use this library for packet capture."
	ewarn

}
