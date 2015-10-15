# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit eutils

DESCRIPTION="Indents C/C++ source code"
HOMEPAGE="http://invisible-island.net/bcpp/"
SRC_URI="ftp://invisible-island.net/bcpp/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES MANIFEST README VERSION txtdocs/hirachy.txt \
		txtdocs/manual.txt || die "dodoc failed"
}
