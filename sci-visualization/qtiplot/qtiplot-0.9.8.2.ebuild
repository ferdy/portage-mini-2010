# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/qtiplot/qtiplot-0.9.8.2.ebuild,v 1.1 2010/09/03 06:12:37 jlec Exp $

EAPI=3

PYTHON_DEPEND="python? 2"

inherit eutils qt4-r2 fdo-mime python

DESCRIPTION="Qt based clone of the Origin plotting package"
HOMEPAGE="http://soft.proindependent.com/qtiplot.html"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc python ods"

LANGS="cn cz de es fr ro ru ja sv"
for l in ${LANGS}; do
	lu=${l/cz/cs}
	lu=${lu/cn/zh_CN}
	IUSE="${IUSE} linguas_${lu}"
done

# qwtplot3d much modified from original upstream
# >=x11-libs/qwt-5.3 they are using trunk checkouts
CDEPEND="
	x11-libs/qt-opengl:4
	x11-libs/qt-qt3support:4
	x11-libs/qt-assistant:4
	x11-libs/qt-svg:4
	>=x11-libs/gl2ps-1.3.5
	>=dev-cpp/muParser-1.32
	>=dev-libs/boost-1.35.0
	>=sci-libs/liborigin-20100903:2
	sci-libs/gsl
	dev-libs/boost
	dev-tex/qtexengine
	ods? ( dev-libs/quazip )"
# Still unable to build
#	emf? ( media-libs/libemf
#		media-libs/emfengine )

DEPEND="${CDEPEND}
	dev-util/pkgconfig
	python? ( >=dev-python/sip-4.9 )
	doc? ( app-text/docbook-sgml-utils
		   >=app-text/docbook-xml-dtd-4.4-r2:4.4 )"

RDEPEND="${CDEPEND}
	python? (
		dev-python/PyQt4[X]
		dev-python/pygsl
		dev-python/rpy
		sci-libs/scipy )"

PATCHES=(
	"${FILESDIR}/${PN}-0.9.7.12-system-QTeXEngine.patch"
	"${FILESDIR}/${PN}-0.9.7.14-system-liborigin.patch"
	"${FILESDIR}/${PN}-0.9.7.12-system-gl2ps.patch"
	"${FILESDIR}/${PN}-0.9.7.10-dont-install-qwt.patch"
	"${FILESDIR}/${PN}-0.9.8.2-syslibs.patch"
	)

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	qt4-r2_src_prepare

	rm -rf 3rdparty/{liborigin,QTeXEngine,/qwtplot3d/3rdparty/gl2ps/}

	# Check build.conf for changes on bump.
	cat >build.conf <<-EOF
	# Automatically generated by Gentoo ebuild
	isEmpty( QTI_ROOT ) {
	  message( "each file including this config needs to set QTI_ROOT to the dir containing this file!" )
	}

	MUPARSER_LIBS = \$\$system(pkg-config --libs muparser)
	GSL_LIBS = \$\$system(pkg-config --libs gsl)
	BOOST_INCLUDEPATH = "${EPREFIX}/usr/include/boost"
	BOOST_LIBS = -lboost_date_time-mt -lboost_thread-mt
	QWT_INCLUDEPATH = \$\$QTI_ROOT/3rdparty/qwt/src
	QWT_LIBS = \$\$QTI_ROOT/3rdparty/qwt/lib/libqwt.a
	QWT3D_INCLUDEPATH = \$\$QTI_ROOT/3rdparty/qwtplot3d/include
	QWT3D_LIBS = \$\$QTI_ROOT/3rdparty/qwtplot3d/lib/libqwtplot3d.a
	LIB_ORIGIN_INCLUDEPATH = "${EPREFIX}/usr/include/liborigin2"
	LIB_ORIGIN_LIBS = -lorigin2
	QTEXENGINE_LIBS = -lQTeXEngine
	SYS_LIBS = -lgl2ps

	PYTHON = python
	LUPDATE = lupdate
	LRELEASE = lrelease

	SCRIPTING_LANGS += muParser

	CONFIG          += release
	CONFIG          += CustomInstall
	DEFINES         += SCRIPTING_CONSOLE

	EOF

	use python && echo "SCRIPTING_LANGS += Python" >> build.conf
	if use ods; then
		echo "QUAZIP_INCLUDEPATH = ${EPREFIX}/usr/include/quazip" >> build.conf
		echo "QUAZIP_LIBS = -lquazip" >> build.conf
	fi

	sed '/^INSTALLS/d;' -i 3rdparty/qwtplot3d/qwtplot3d.pro || die

	# Fails to build...
	#if use emf; then
	#	echo "EMF_ENGINE_INCLUDEPATH = /usr/include/libEMF" >> build.conf
	#	echo "EMF_ENGINE_LIBS = -lEMF" >> build.conf
	#fi

	sed -e "s:doc/${PN}/manual:doc/${PN}/html:" \
		-e "s:/usr/local/${PN}:$(python_get_sitedir)/qtiplot:" \
			-i qtiplot/qtiplot.pro || die

	sed -e '/INSTALLS.*documentation/d' \
		-e '/INSTALLS.*manual/d' \
			-i qtiplot/qtiplot.pro || die
	sed -e '/manual/d' -i qtiplot.pro || die

	# Drop langs only if LINGUAS is not empty
	if [[ -n ${LINGUAS} ]]; then
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} || \
				sed -e "s:translations/qtiplot_${l}.[tq][sm]::" \
						-i qtiplot/qtiplot.pro || die
		done
	fi
	chmod -x qtiplot/qti_wordlist.txt

	# sed out debian paths
	sed -e 's:\(/usr/share/sgml/\)docbook/stylesheet/dsssl/modular\(/html/docbook.dsl\):\1stylesheets/dsssl/docbook\2:' \
		-i manual/qtiplot.dsl || die
	sed -e 's:\(/usr/share/\)xml/docbook/stylesheet/nwalsh\(/html/chunk.xsl\):\1sgml/docbook/xsl-stylesheets\2:' \
		-i manual/qtiplot_html.xsl || die
}

src_configure() {
	use amd64 && export QMAKESPEC="linux-g++-64"
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	lrelease qtiplot/qtiplot.pro || die
	if use doc; then
		cd manual
		emake web || die "html docbook building failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die 'emake install failed'
	newicon qtiplot_logo.png qtiplot.png
	make_desktop_entry qtiplot "QtiPlot Scientific Plotting" qtiplot
	if use doc; then
		insinto /usr/share/doc/${PN}/html
		doins -r manual/html/* || die "install manual failed"
	fi

	if [[ -n ${LINGUAS} ]]; then
		insinto /usr/share/${PN}/translations
		for l in ${LANGS}; do
			lu=${l/cz/cs}
			lu=${lu/cn/zh_CN}
			use linguas_${lu} && \
				doins qtiplot/translations/qtiplot_${l}.qm
		done
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	python_mod_optimize ${PN}
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup ${PN}
}