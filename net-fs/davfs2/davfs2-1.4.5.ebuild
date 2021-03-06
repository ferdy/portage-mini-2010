# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/davfs2/davfs2-1.4.5.ebuild,v 1.3 2010/08/17 19:20:50 ssuominen Exp $

EAPI="2"

inherit autotools eutils linux-mod

DESCRIPTION="a Linux file system driver that allows you to mount a WebDAV server as a local disk drive. Davfs2 uses fuse (or coda) for kernel driver and neon for WebDAV interface"
HOMEPAGE="http://savannah.nongnu.org/projects/davfs2"
SRC_URI="http://mirror.lihnidos.org/GNU/savannah/davfs2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-libs/libxml2
		net-libs/neon
		sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc212.patch
	sed -e "s/^NE_REQUIRE_VERSIONS.*29/& 30/" -i configure.ac
	eautoreconf
}

src_configure() {
	econf --enable-largefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README README.translators THANKS TODO

	# Remove wrong locations created by install.
	rm -fr "${D}/usr/share/doc/davfs2"
	rm -fr "${D}/usr/share/davfs2"

	dodir /var/run/mount.davfs
	keepdir /var/run/mount.davfs
	fowners root:users /var/run/mount.davfs
	fperms 1774 /var/run/mount.davfs

	# Ignore nobody's home
	cat>>"${D}/etc/davfs2/davfs2.conf"<<EOF

# nobody is a system account in Gentoo
ignore_home nobody
EOF
}
