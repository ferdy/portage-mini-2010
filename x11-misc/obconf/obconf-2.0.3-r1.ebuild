# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/obconf/obconf-2.0.3-r1.ebuild,v 1.1 2010/09/07 11:25:39 hwoarang Exp $

EAPI="2"

inherit eutils fdo-mime

DESCRIPTION="ObConf is a tool for configuring the Openbox window manager."
HOMEPAGE="http://icculus.org/openbox/index.php/ObConf:About"
SRC_URI="http://icculus.org/openbox/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=gnome-base/libglade-2
	>=x11-libs/gtk+-2
	x11-libs/startup-notification
	>=x11-wm/openbox-3.4.2
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# fix segfault on hardened. Bug #335736
	epatch "${FILESDIR}/${P}-hardened.patch"
}

src_compile() {
	econf \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}