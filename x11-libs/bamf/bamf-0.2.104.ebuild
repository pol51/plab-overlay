# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools

DESCRIPTION="BAMF Application Matching Framework"

SRC_URI="http://launchpad.net/bamf/0.2/0.2.204/+download/bamf-${PV}.tar.gz"
HOMEPAGE="https://launchpad.net/bamf"
KEYWORDS="~x86 ~amd64"
SLOT="0" 
LICENSE="LGPL3"
IUSE=""

DEPEND=">=dev-lang/vala-0.11.7
		dev-util/gtk-doc
		>=x11-libs/libwnck-3.0.0"

src_unpack() {
    unpack ${A}
    cd "${S}"

    sed -i -e 's/vapigen/vapigen-0.12/' configure.in

    eautoreconf
}

src_configure() {
    econf
}

src_compile() {
    emake || die
#    vapigen-0.12 --library=Bamf-0.2 --directory=${D}/lib/libbamf ${D}/lib/libbamf/Bamf-0.2.gir 
}

src_install() {
    emake DESTDIR="${D}" install || die
}
