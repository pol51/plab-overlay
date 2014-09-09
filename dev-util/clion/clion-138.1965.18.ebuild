EAPI="5"

inherit eutils

DESCRIPTION="CLion"
HOMEPAGE="www.jetbrains.com/clion/"
SRC_URI="http://download.jetbrains.com/cpp/${PN}-${PV}.tar.gz"

KEYWORDS="~x86 ~amd64"

DEPEND=">=virtual/jre-1.6"
RDEPEND="${DEPEND}"

SLOT="0"

S="${WORKDIR}/${PN}-${PV}"

src_install()
{	
	# copy files
  dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r *
	
  # fix perms
  fperms a+x /opt/${PN}/bin/clion.sh || die "fperms failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "fperms failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "fperms failed"
	fperms a+x /opt/${PN}/bin/inspect.sh || die "fperms failed"
	
  # symlink
  dosym /opt/${PN}/bin/clion.sh /usr/bin/${PN}

  # desktop entry
	mv "bin/clion.svg" "bin/${PN}.svg"
  doicon "bin/${PN}.svg"
	make_desktop_entry ${PN} "CLion" /opt/${PN}/bin/${PN}.svg
}
