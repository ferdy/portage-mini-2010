# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/fricas/fricas-1.1.0.ebuild,v 1.1 2010/07/10 06:32:44 grozin Exp $
EAPI=2
inherit multilib elisp-common

DESCRIPTION="FriCAS is a fork of Axiom computer algebra system"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-full.tar.bz2"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Supported lisps, number 0 is the default
LISPS=( sbcl cmucl gcl ecl    clisp clozurecl )
# . means just dev-lisp/${LISP}; foo-x.y.z means >=dev-lisp/foo-x.y.z
DEPS=(  .    .     .   ecls-9 .     .         )
# command name: . means just ${LISP}
COMS=(  .    lisp  .   .      .     ccl       )

IUSE="${LISPS[*]} X emacs"
RDEPEND="X? ( x11-libs/libXpm x11-libs/libICE )
	emacs? ( virtual/emacs )"

# Generating lisp deps
n=${#LISPS[*]}
for ((n--; n > 0; n--)); do
	LISP=${LISPS[$n]}
	DEP=${DEPS[$n]}
	if [ "${DEP}" = "." ]; then
		DEP="dev-lisp/${LISP}"
	else
		DEP=">=dev-lisp/${DEP}"
	fi
	RDEPEND="${RDEPEND} ${LISP}? ( ${DEP} ) !${LISP}? ("
done
RDEPEND="${RDEPEND} dev-lisp/${LISPS[0]}"
n=${#LISPS[*]}
for ((n--; n > 0; n--)); do
	RDEPEND="${RDEPEND} )"
done

DEPEND="${RDEPEND}"

# necessary for clisp and gcl
RESTRICT="strip"

src_configure() {
	local LISP n
	LISP=sbcl
	n=${#LISPS[*]}
	for ((n--; n > 0; n--)); do
		if use ${LISPS[$n]}; then
			LISP=${COMS[$n]}
			if [ "${LISP}" = "." ]; then
				LISP=${LISPS[$n]}
			fi
		fi
	done
	einfo "Using lisp: ${LISP}"

	# aldor is not yet in portage
	econf --disable-aldor --with-lisp=${LISP} $(use_with X x)
}

src_compile() {
	# bug #300132
	emake -j1 || die "emake failed"
}

src_test() {
	emake -j1 all-input
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die 'emake install failed'
	dodoc README FAQ || die "dodoc failed"

	if use emacs; then
		sed -e "s|(setq load-path (cons (quote \"/usr/$(get_libdir)/fricas/emacs\") load-path)) ||" \
			-i "${D}"/usr/bin/efricas \
			|| die "sed efricas failed"
		elisp-install ${PN} "${D}"/usr/$(get_libdir)/${PN}/emacs/*.el
		elisp-site-file-install "${FILESDIR}"/64${PN}-gentoo.el
	else
		rm "${D}"/usr/bin/efricas || die "rm efricas failed"
	fi
	rm -r "${D}"/usr/$(get_libdir)/${PN}/emacs || die "rm -r emacs failed"
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
