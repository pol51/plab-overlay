# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Generated headers and sources for OpenXR loader."
HOMEPAGE="https://github.com/KhronosGroup/OpenXR-SDK"

if [[ ${PV} == 9999 ]]; then
   EGIT_REPO_URI="https://github.com/OpenHMD/OpenHMD.git"
   inherit git-r3
else
   SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz"
   KEYWORDS="~amd64"
fi

S="${WORKDIR}/OpenHMD-${PV}"

LICENSE="Boost-1.0"
SLOT="0"
IUSE="egl opengl X rift rifts deepon wmr psvr vive nolo xgvr vrtek +external android"
REQUIRED_USE=""

DEPEND="
	dev-libs/libusb
	>=media-libs/gulkan-0.13.0
	media-libs/openvr
	>=x11-libs/gtk+-3.22
	dev-libs/hidapi
	egl? ( media-libs/mesa[egl] )
	opengl?
	(
		media-libs/glew
		media-libs/glfw
	)
	X? ( x11-base/xorg-server )
"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	sed -i "s/DESTINATION lib/DESTINATION $(get_libdir)/g" CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		"OPENHMD_DRIVER_OCULUS_RIFT=$(usex rift ON OFF)"
		"OPENHMD_DRIVER_OCULUS_RIFT_S=$(usex rifts ON OFF)"
		"OPENHMD_DRIVER_DEEPOON=$(usex deepon ON OFF)"
		"OPENHMD_DRIVER_WMR=$(usex wmr ON OFF)"
		"OPENHMD_DRIVER_PSVR=$(usex psvr ON OFF)"
		"OPENHMD_DRIVER_HTC_VIVE=$(usex vive ON OFF)"
		"OPENHMD_DRIVER_NOLO=$(usex nolo ON OFF)"
		"OPENHMD_DRIVER_XGVR=$(usex xgvr ON OFF)"
		"OPENHMD_DRIVER_VRTEK=$(usex vrtek ON OFF)"
		"OPENHMD_DRIVER_EXTERNAL=$(usex external ON OFF)"
		"OPENHMD_DRIVER_ANDROID=$(usex android ON OFF)"
	)
	CMAKE_BUILD_TYPE=Release
	cmake_src_configure
}

