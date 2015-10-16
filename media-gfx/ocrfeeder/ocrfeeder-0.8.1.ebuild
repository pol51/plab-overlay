# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_7 )

inherit autotools eutils gnome2 python-r1

DESCRIPTION="Document layout analysis and optical character recognition system"
HOMEPAGE="https://wiki.gnome.org/Apps/OCRFeeder"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="
	${PYTHON_DEPS}
	app-text/gtkspell:3[introspection]
	dev-libs/gobject-introspection
	dev-python/lxml[${PYTHON_USEDEP}]
	>=dev-python/odfpy-0.7[${PYTHON_USEDEP}]
	dev-python/pyenchant[${PYTHON_USEDEP}]
	dev-python/pygobject:3
	dev-python/python-sane[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	x11-libs/goocanvas:2.0[introspection]
	x11-libs/gtk+:3[introspection]
"
RDEPEND="${COMMON_DEPEND}
	media-gfx/sane-backends

	app-text/unpaper
	|| (
		app-text/tesseract
		app-text/ocrad
		app-text/gocr
		app-text/cuneiform
	)
"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils[${PYTHON_USEDEP}]
	>=dev-util/intltool-0.35
"

pkg_setup() {
	python_setup
}

src_prepare() {
	# Unbundle odfpy
	#epatch "${FILESDIR}"/0002-Drop-bundled-odfpy-usage.patch
	#rm -rf src/ocrfeeder/odf/ || die

	#eautoreconf
	gnome2_src_prepare
	python_copy_sources
}

src_configure() {
	python_foreach_impl run_in_build_dir gnome2_src_configure
}

src_compile() {
	python_foreach_impl run_in_build_dir emake
}

src_test() {
	python_foreach_impl run_in_build_dir emake check
}

src_install() {
	python_foreach_impl run_in_build_dir gnome2_src_install
	python_fix_shebang "${D}"/usr/bin
}
