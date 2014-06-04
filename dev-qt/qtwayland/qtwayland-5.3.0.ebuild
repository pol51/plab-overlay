# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build git-2

DESCRIPTION="Wayland platform plugin for Qt"
HOMEPAGE="http://qt-project.org/wiki/QtWayland"
KEYWORDS="~amd64"

EGIT_REPO_URI="git://gitorious.org/qt/qtwayland.git"
EGIT_PROJECT="djmt"
EGIT_BRANCH="stable"

IUSE="egl qml wayland-compositor xcomposite"

DEPEND="
	>=dev-libs/wayland-1.5.0
	>=dev-qt/qtcore-${PV}:5[debug=]
	>=dev-qt/qtgui-${PV}:5[debug=,egl=,opengl]
	media-libs/mesa[egl?]
	>=x11-libs/libxkbcommon-0.2.0
	qml? ( >=dev-qt/qtdeclarative-${PV}:5[debug=] )
	xcomposite? (
		x11-libs/libX11
		x11-libs/libXcomposite
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	if use wayland-compositor; then
		echo "CONFIG += wayland-compositor" >> "${QT5_BUILD_DIR}"/.qmake.cache
	fi

	if ! use xcomposite; then
		echo "CONFIG += done_config_xcomposite" >> "${QT5_BUILD_DIR}"/.qmake.cache
	fi

	qt5-build_src_configure
}
