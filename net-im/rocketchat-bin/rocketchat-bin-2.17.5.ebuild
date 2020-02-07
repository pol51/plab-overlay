# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN%-bin}"

inherit eutils gnome2-utils unpacker xdg-utils

DESCRIPTION="Have your own Slack like online chat, built with Meteor."
HOMEPAGE="https://rocket.chat"

BASE_URI="https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/${PV}"
          https://github.com/RocketChat/Rocket.Chat.Electron/releases/download/2.17.5/rocketchat_2.17.5_amd64.deb

SRC_URI="
	amd64? ( "${BASE_URI}/${PN%-bin}_${PV}_amd64.deb" )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT=""

RDEPEND="
	dev-libs/atk:0
	dev-libs/expat:0
	dev-libs/glib:2
	dev-libs/nspr:0
	dev-libs/nss:0
	gnome-base/gconf:2
	media-libs/alsa-lib:0
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	net-print/cups:0
	sys-apps/dbus:0
	sys-libs/glibc:2.2
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11:0
	x11-libs/libxcb:0/1.12
	x11-libs/libXcomposite:0
	x11-libs/libXcursor:0
	x11-libs/libXdamage:0
	x11-libs/libXext:0
	x11-libs/libXfixes:0
	x11-libs/libXi:0
	x11-libs/libXrandr:0
	x11-libs/libXrender:0
	x11-libs/libXScrnSaver:0
	x11-libs/libXtst:0
	x11-libs/pango:0
"

QA_PREBUILT="opt/${MY_PN}/${MY_PN} opt/${MY_PN}/libnode.so opt/${MY_PN}/libffmpeg.so"

S="${WORKDIR}"

src_prepare() {
	sed -r \
		-e "s/Rocket.Chat/${MY_PN}/g" \
		-i "usr/share/applications/${MY_PN}-desktop.desktop"
	default
}

src_install() {
	rm -r usr/share/doc

	newicon -s 512 "usr/share/icons/hicolor/512x512/apps/${MY_PN}-desktop.png" "${MY_PN}-desktop.png"
	domenu "usr/share/applications/${MY_PN}-desktop.desktop"

  mv opt/Rocket.Chat ${MY_PN}
  insinto /opt/
	doins -r ${MY_PN}
	
	fperms +x "/opt/${MY_PN}/${MY_PN}-desktop"
	make_wrapper "${MY_PN}" "${EPREFIX}/opt/${MY_PN}/${MY_PN}-desktop" "${EPREFIX}/opt/${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}