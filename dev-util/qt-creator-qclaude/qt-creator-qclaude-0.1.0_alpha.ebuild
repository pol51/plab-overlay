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
	dev-qt/qthttpserver:6
	dev-qt/qtsvg:6
"
RDEPEND="${DEPEND}
	dev-util/claude-code
"

src_prepare() {
	# Qt Creator 20 links to Qt6::HttpServer, so find it before QtCreator.
	sed -i 's/^find_package(QtCreator REQUIRED/find_package(Qt6 REQUIRED COMPONENTS HttpServer)\n&/' \
		CMakeLists.txt || die
	cmake_src_prepare
}

src_install() {
	cmake_src_install

	# The plugin does not need its headers.
	rm -r "${ED}"/usr/include || die

	# The panel looks for the helpers next to libQClaude.so.
	exeinto /usr/$(get_libdir)/qtcreator/plugins
	doexe "${BUILD_DIR}"/$(get_libdir)/qtcreator/plugins/qclaude_{mcp_permission,hook_bridge}
}

pkg_postinst() {
	elog "Rebuild this package after each dev-qt/qt-creator upgrade."
	elog "Qt Creator only loads plugins built for its own version."
}
