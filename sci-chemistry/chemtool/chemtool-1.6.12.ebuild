# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/chemtool/chemtool-1.6.12.ebuild,v 1.4 2009/11/21 18:25:48 nixnut Exp $

inherit eutils

DESCRIPTION="A GTK program for drawing organic molecules"
HOMEPAGE="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/"
SRC_URI="http://ruby.chemie.uni-freiburg.de/~martin/chemtool/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnome nls"

RDEPEND="media-gfx/transfig
	=x11-libs/gtk+-2*
	x86? ( media-libs/libemf )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local config_opts
	local mycppflags

	unset KDEDIR
	config_opts="${config_opts} --without-kdedir"

	if [ ${ARCH} = "x86"  ]; then
		config_opts="${config_opts} --enable-emf"
		mycppflags="${mycppflags} -I /usr/include/libEMF"
	fi

	sed -e "s:\(^CPPFLAGS.*\):\1 ${mycppflags}:" -i Makefile.in || \
		die "could not append cppflags"

	if use gnome ; then
		config_opts="${config_opts} --with-gnomedir=/usr" ;
	else
		config_opts="${config_opts} --without-gnomedir" ;
	fi

	econf ${config_opts} --enable-menu \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog INSTALL README TODO
	insinto /usr/share/${PN}/examples
	doins "${S}"/examples/*
	if ! use nls; then rm -rf "${D}"/usr/share/locale; fi

	insinto /usr/share/pixmaps
	doins chemtool.xpm
	make_desktop_entry ${PN} Chemtool ${PN} "Education;Science;Chemistry"
}
