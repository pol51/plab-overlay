# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Multitouch gesture recognizer"
HOMEPAGE="https://code.google.com/p/touchegg"
SRC_URI="http://touchegg.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXtst
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/utouch-geis"
RDEPEND="${DEPEND}"

