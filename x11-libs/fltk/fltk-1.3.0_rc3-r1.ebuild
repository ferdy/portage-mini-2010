# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fltk/fltk-1.3.0_rc3-r1.ebuild,v 1.3 2011/01/18 20:38:29 jlec Exp $

EAPI=3

inherit eutils autotools versionator fdo-mime

MY_P=${P/_}

DESCRIPTION="C++ user interface toolkit for X and OpenGL"
HOMEPAGE="http://www.fltk.org"
SRC_URI="mirror://easysw/${PN}/${PV/_}/${P/_}-source.tar.gz"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
LICENSE="FLTK LGPL-2"

SLOT="1.1" # because 1.3 is API compatible with 1.1

IUSE="cairo debug doc examples games opengl pdf threads xft xinerama"

#RESTRICT="strip"

RDEPEND="x11-libs/libXext
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXt
	virtual/jpeg
	media-libs/libpng
	sys-libs/zlib
	opengl? ( virtual/opengl )
	xinerama? ( x11-libs/libXinerama )
	xft? ( x11-libs/libXft )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	doc? (
		app-doc/doxygen
		pdf? ( dev-texlive/texlive-latex )
	)
	xinerama? ( x11-proto/xineramaproto )"

INCDIR=${EPREFIX}/usr/include/fltk-${SLOT}
LIBDIR=${EPREFIX}/usr/$(get_libdir)/fltk-${SLOT}

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-share.patch \
		"${FILESDIR}"/${P}-conf-tests.patch
	sed \
		-e 's:@HLINKS@::g' -i FL/Makefile.in || die
	sed -i \
		-e '/C\(XX\)\?FLAGS=/s:@C\(XX\)\?FLAGS@::' \
		-e '/^LDFLAGS=/d' \
		"${S}/fltk-config.in" || die
	# some fixes introduced because slotting
	sed -i \
		-e '/RANLIB/s:$(libdir)/\(.*LIBNAME)\):$(libdir)/`basename \1`:g' \
		src/Makefile || die
	# docs in proper docdir
	sed -i \
		-e "/^docdir/s:fltk:${PF}/html:" \
		-e "/SILENT:/d" \
		makeinclude.in || die
	sed -e "s/7/$(get_version_component_range 3)/" \
		"${FILESDIR}"/FLTKConfig.cmake > CMake/FLTKConfig.cmake
	eautoconf
}

src_configure() {
	econf \
		--includedir=${INCDIR}\
		--libdir=${LIBDIR} \
		--docdir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--enable-largefile \
		--enable-shared \
		--enable-xdbe \
		--disable-localjpeg \
		--disable-localpng \
		--disable-localzlib \
		$(use_enable debug) \
		$(use_enable cairo) \
		$(use_enable opengl gl) \
		$(use_enable threads) \
		$(use_enable xft) \
		$(use_enable xinerama)
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd "${S}"/documentation
		emake html || die "emake doc failed"
		if use pdf; then
			emake pdf || die "emake doc failed"
		fi
	fi
	if use games; then
		cd "${S}"/test
		emake blocks checkers sudoku || die "emake games failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	emake -C fluid \
			DESTDIR="${D}" install-linux || die "emake install fluid failed"
	if use doc; then
		emake -C documentation \
			DESTDIR="${D}" install || die "emake install doc failed"
	fi
	local apps="fluid"
	if use games; then
		emake -C test \
			DESTDIR="${D}" install-linux || die "emake install games failed"
		emake -C documentation \
			DESTDIR="${D}" install-linux || die "emake install doc games failed"
		apps="${apps} sudoku blocks checkers"
	fi
	for app in ${apps}; do
		dosym /usr/share/icons/hicolor/32x32/apps/${app}.png \
			/usr/share/pixmaps/${app}.png
	done
	dodoc CHANGES README CREDITS ANNOUNCEMENT || die

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/*.{h,cxx,fl} test/demo.menu
	fi

	insinto /usr/share/cmake/Modules
	doins CMake/FLTK*.cmake

	echo "LDPATH=${LIBDIR}" > 99fltk-${SLOT}
	echo "FLTK_DOCDIR=/usr/share/doc/${PF}/html" >> 99fltk-${SLOT}
	doenvd 99fltk-${SLOT}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	echo
	ewarn "PLEASE PLEASE take note of this"
	ewarn "Please make *sure* to run revdep-rebuild now"
	ewarn "You must recompile everything that depend on fltk!"
	echo
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
