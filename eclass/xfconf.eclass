# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/xfconf.eclass,v 1.24 2011/02/14 19:52:14 ssuominen Exp $

# @ECLASS: xfconf.eclass
# @MAINTAINER:
# XFCE maintainers <xfce@gentoo.org>
# @BLURB: Default XFCE ebuild layout
# @DESCRIPTION:
# Default XFCE ebuild layout

# @ECLASS-VARIABLE: EAUTORECONF
# @DESCRIPTION:
# Run eautoreconf instead of elibtoolize if set "yes"

# @ECLASS-VARIABLE: EINTLTOOLIZE
# @DESCRIPTION:
# Run intltoolize --force --copy --automake if set "yes"

# @ECLASS-VARIABLE: DOCS
# @DESCRIPTION:
# Define documentation to install

# @ECLASS-VARIABLE: PATCHES
# @DESCRIPTION:
# Define patches to apply

# @ECLASS-VARIABLE: XFCONF
# @DESCRIPTION:
# Define options for econf

inherit autotools base eutils fdo-mime gnome2-utils libtool

if ! [[ ${MY_P} ]]; then
	MY_P=${P}
else
	S=${WORKDIR}/${MY_P}
fi

SRC_URI="mirror://xfce/xfce/${PV}/src/${MY_P}.tar.bz2"

if [[ "${EINTLTOOLIZE}" == "yes" ]]; then
	_xfce4_intltool="dev-util/intltool"
fi

if [[ "${EAUTORECONF}" == "yes" ]]; then
	_xfce4_m4=">=dev-util/xfce4-dev-tools-4.8.0"
fi

RDEPEND=""
DEPEND="${_xfce4_intltool}
	${_xfce4_m4}"

unset _xfce4_intltool
unset _xfce4_m4

case ${EAPI:-0} in
	4|3) ;;
	*) die "Unknown EAPI." ;;
esac

EXPORT_FUNCTIONS src_prepare src_configure src_install pkg_preinst pkg_postinst pkg_postrm

# @FUNCTION: xfconf_use_debug
# @DESCRIPTION:
# Return --enable-debug, null, --enable-debug=full or --disable-debug based on
# XFCONF_FULL_DEBUG variable and USE debug
xfconf_use_debug() {
	if has debug ${IUSE}; then
		if use debug; then
			if [[ -n $XFCONF_FULL_DEBUG ]]; then
				echo "--enable-debug=full"
			else
				echo "--enable-debug"
			fi
		else
			if [[ -n $XFCONF_FULL_DEBUG ]]; then
				echo "--disable-debug"
			fi
		fi
	fi
}

# @FUNCTION: xfconf_src_prepare
# @DESCRIPTION:
# Run base_src_util autopatch and eautoreconf or elibtoolize
xfconf_src_prepare() {
	debug-print-function ${FUNCNAME} "$@"
	base_src_prepare

	if [[ "${EINTLTOOLIZE}" == "yes" ]]; then
		intltoolize --force --copy --automake || die
	fi

	if [[ "${EAUTORECONF}" == "yes" ]]; then
		AT_M4DIR="${EPREFIX}/usr/share/xfce4/dev-tools/m4macros" eautoreconf
	else
		elibtoolize
	fi
}

# @FUNCTION: xfconf_src_configure
# @DESCRIPTION:
# Run econf with opts in XFCONF array
xfconf_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	# Convert XFCONF to an array, see base.eclass for original code
	if [[ "$(declare -p XFCONF 2>/dev/null 2>&1)" != "declare -a"* ]]; then
		XFCONF=( ${XFCONF} )
	fi

	econf ${XFCONF[@]}
}

# @FUNCTION: xfconf_src_install
# @DESCRIPTION:
# Run emake install and install documentation in DOCS variable
xfconf_src_install() {
	debug-print-function ${FUNCNAME} "$@"
	emake DESTDIR="${D}" "$@" install || die

	if [[ -n ${DOCS} ]]; then
		dodoc ${DOCS} || die
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +

	validate_desktop_entries
}

# @FUNCTION: xfconf_pkg_preinst
# @DESCRIPTION:
# Run gnome2_icon_savelist
xfconf_pkg_preinst() {
	debug-print-function ${FUNCNAME} "$@"
	gnome2_icon_savelist
}

# @FUNCTION: xfconf_pkg_postinst
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfconf_pkg_postinst() {
	debug-print-function ${FUNCNAME} "$@"
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

# @FUNCTION: xfconf_pkg_postrm
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfconf_pkg_postrm() {
	debug-print-function ${FUNCNAME} "$@"
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}
