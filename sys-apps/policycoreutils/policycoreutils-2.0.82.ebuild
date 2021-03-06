# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/policycoreutils/policycoreutils-2.0.82.ebuild,v 1.2 2011/02/08 17:29:48 arfrever Exp $

EAPI="2"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit multilib python toolchain-funcs

EXTRAS_VER="1.20"
SEMNG_VER="2.0.45"
SELNX_VER="2.0.94"
SEPOL_VER="2.0.41"

DESCRIPTION="SELinux core utilities"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20100525/devel/${P}.tar.gz
	mirror://gentoo/policycoreutils-extra-${EXTRAS_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

COMMON_DEPS=">=sys-libs/libselinux-${SELNX_VER}[python]
	>=sys-libs/glibc-2.4
	>=sys-process/audit-1.5.1
	>=sys-libs/libcap-1.10-r10
	sys-libs/pam
	>=sys-libs/libsemanage-${SEMNG_VER}[python]
	sys-libs/libcap-ng
	>=sys-libs/libsepol-${SEPOL_VER}"

# pax-utils for scanelf used by rlpkg
RDEPEND="${COMMON_DEPS}
	dev-python/sepolgen
	app-misc/pax-utils"

DEPEND="${COMMON_DEPS}
	nls? ( sys-devel/gettext )"

S2=${WORKDIR}/policycoreutils-extra

src_prepare() {
	# rlpkg is more useful than fixfiles
	sed -i -e '/^all/s/fixfiles//' "${S}/scripts/Makefile" \
		|| die "fixfiles sed 1 failed"
	sed -i -e '/fixfiles/d' "${S}/scripts/Makefile" \
		|| die "fixfiles sed 2 failed"
	# removing sandbox for the time being, need to
	# rename in future to sesandbox?
	sed -i -e 's/sandbox //' "${S}/Makefile" \
		|| die "failed removing sandbox"
}

src_compile() {
	einfo "Compiling policycoreutils"
	emake -C "${S}" AUDIT_LOG_PRIV="y" CC="$(tc-getCC)" || die
	einfo "Compiling policycoreutils-extra"
	emake -C "${S2}" CC="$(tc-getCC)" || die
}

src_install() {
	# Python scripts are present in many places. There are no extension modules.
	installation() {
		einfo "Installing policycoreutils"
		emake -C "${S}" DESTDIR="${T}/images/${PYTHON_ABI}" AUDIT_LOG_PRIV="y" PYLIBVER="python$(python_get_version)" install || return 1

		einfo "Installing policycoreutils-extra"
		emake -C "${S2}" DESTDIR="${T}/images/${PYTHON_ABI}" SHLIBDIR="${D}$(get_libdir)/rc" install || return 1
	}
	python_execute_function installation
	python_merge_intermediate_installation_images "${T}/images"

	# remove redhat-style init script
	rm -fR "${D}/etc/rc.d"

	# compatibility symlinks
	dosym /sbin/setfiles /usr/sbin/setfiles
	dosym /$(get_libdir)/rc/runscript_selinux.so /$(get_libdir)/rcscripts/runscript_selinux.so
}

pkg_postinst() {
	python_mod_optimize seobject.py
}

pkg_postrm() {
	python_mod_cleanup seobject.py
}
