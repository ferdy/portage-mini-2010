# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-2.1-r1.ebuild,v 1.2 2011/02/18 12:19:44 scarabeus Exp $

EAPI=4

inherit autotools eutils virtualx

DESCRIPTION="GTK+ bindings for guile"
HOMEPAGE="http://www.gnu.org/software/guile-gtk/"
SRC_URI="ftp://ftp.gnu.org/gnu/guile-gtk/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-scheme/guile[deprecated(+)]
	=x11-libs/gtk+-2*
	=gnome-base/libglade-2*
	>=x11-libs/gtkglarea-1.90"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0-g-object-ref.diff"
	epatch "${FILESDIR}"/${PV}-prll-install.patch
	epatch "${FILESDIR}"/${PV}-brokentest.patch
	eautoreconf
}

src_test() {
	Xemake check
}

src_install() {
	# bug #298803
	emake DESTDIR="${D}" install
	dodoc README AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/doc/${PF}/
	doins -r examples
}
