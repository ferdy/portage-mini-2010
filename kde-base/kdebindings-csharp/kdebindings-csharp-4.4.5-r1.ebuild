# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-csharp/kdebindings-csharp-4.4.5-r1.ebuild,v 1.3 2011/01/29 17:36:05 hwoarang Exp $

EAPI="3"

KMNAME="kdebindings"
KMMODULE="csharp"
WEBKIT_REQUIRED="optional"
inherit kde4-meta mono

DESCRIPTION="C# bindings for KDE and Qt"
KEYWORDS="amd64 ~ppc x86"
IUSE="akonadi debug +phonon plasma qimageblitz qscintilla semantic-desktop"

DEPEND="
	>=dev-lang/mono-2.8
	$(add_kdebase_dep smoke 'akonadi?,phonon?,qimageblitz?,qscintilla?,semantic-desktop?,webkit?')
	semantic-desktop? ( >=dev-libs/soprano-2.3.73[clucene] )
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="smoke/"

PATCHES=( "${FILESDIR}"/${PN}-4.4.1-make-stuff-optional.patch
	"${FILESDIR}/${P}"-mono-2.8.patch )

pkg_setup() {
	kde4-meta_pkg_setup

	if use plasma && ! use webkit; then
		eerror
		eerror "The plasma USE flag requires the webkit USE flag to be enabled."
		eerror
		eerror "Please enable webkit or disable plasma."
		die "plasma requires webkit"
	fi
}

src_prepare() {
	kde4-meta_src_prepare

	# Disable soprano index (clucene) bindings
	rm -f csharp/soprano/soprano/Soprano_Index_{CLuceneIndex,IndexFilterModel}.cs || die
	sed -e 's/\${SOPRANO_INDEX_LIBRARIES}//g' \
		-i csharp/soprano/CMakeLists.txt || die 'failed to remove clucene from link'

	sed -e "/add_subdirectory( examples )/ s:^:#:" \
		-i csharp/plasma/CMakeLists.txt || die 'failed to disable examples'
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with akonadi)
		$(cmake-utils_use_with akonadi KdepimLibs)
		$(cmake-utils_use_enable plasma PLASMA_SHARP)
		$(cmake-utils_use_enable phonon PHONON_SHARP)
		$(cmake-utils_use_enable qimageblitz QIMAGEBLITZ_SHARP)
		$(cmake-utils_use_enable qscintilla QSCINTILLA_SHARP)
		$(cmake-utils_use_with semantic-desktop Nepomuk)
		$(cmake-utils_use_with semantic-desktop Soprano)
		$(cmake-utils_use_enable webkit QTWEBKIT_SHARP)
	)
	kde4-meta_src_configure
}
