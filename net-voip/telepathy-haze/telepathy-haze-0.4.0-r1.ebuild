# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-haze/telepathy-haze-0.4.0-r1.ebuild,v 1.1 2010/09/30 08:23:17 pacho Exp $

DESCRIPTION="Telepathy connection manager providing libpurple supported
protocols."
HOMEPAGE="http://developer.pidgin.im/wiki/Telepathy"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=">=net-im/pidgin-2.6
	>=net-libs/telepathy-glib-0.9.2
	>=dev-libs/glib-2.22
	>=dev-libs/dbus-glib-0.73"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	test? ( dev-python/twisted-words
		>=dev-lang/python-2.5 )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README || die

	# Remove haze.manager (as Fedora and Debian are doing) to prevent
	# connection problems reported in bug #331713
	rm -f "${D}"/usr/share/telepathy/managers/haze.manager || die
}