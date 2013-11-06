# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Android Studio from Google (the official Android IDE based on IntelliJ IDEA)"
HOMEPAGE="http://developer.android.com/sdk/installing/studio.html"
SRC_URI="https://dl.google.com/android/studio/android-studio-bundle-${PV}-linux.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	# copy files
  dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r *

  # fix perms
  fperms a+x /opt/${PN}/bin/studio.sh || die "fperms failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "fperms failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "fperms failed"
	fperms a+x /opt/${PN}/bin/inspect.sh || die "fperms failed"
	
  # symlink
  dosym /opt/${PN}/bin/studio.sh /usr/bin/${PN}

  # desktop entry
	doicon "bin/idea.png"
	make_desktop_entry ${PN} "Android Studio" /opt/${PN}/bin/idea.png
}
