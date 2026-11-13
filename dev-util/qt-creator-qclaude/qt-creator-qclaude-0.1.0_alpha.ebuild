# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV=${PV/_/-}

DESCRIPTION="Claude Code chat panel plugin for Qt Creator"
HOMEPAGE="https://github.com/Diackne/qt-qclaude-plugin"
SRC_URI="https://github.com/Diackne/qt-qclaude-plugin/archive/refs/tags/v${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qt-qclaude-plugin-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	>=dev-qt/qt-creator-19.0.0[plugin-dev]
	dev-qt/qtbase:6[network,widgets]
	dev-qt/qtsvg:6
"
RDEPEND="${DEPEND}
	dev-util/claude-code
"

src_install() {
	cmake_src_install

	# The panel looks for the permission helper next to libQClaude.so.
	exeinto /usr/$(get_libdir)/qtcreator/plugins
	doexe "${BUILD_DIR}"/lib/qtcreator/plugins/qclaude_mcp_permission
}

pkg_postinst() {
	elog "Rebuild this package after each dev-qt/qt-creator upgrade."
	elog "Qt Creator only loads plugins built for its own version."
}
