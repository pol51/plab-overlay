EAPI=2
inherit eutils

DESCRIPTION="Altassian HipChat native client"
HOMEPAGE="http://hipchat.com"

KEYWORDS="~amd64"
SLOT="1"

SRC_URI="http://downloads.hipchat.com/linux/arch/x86_64/hipchat-${PV}-x86_64.pkg.tar.xz"

S=$WORKDIR

src_install() {
  insinto /opt/
  doins -r $S/opt/HipChat
  fperms ugo+x /opt/HipChat/bin/hipchat
  fperms ugo+x /opt/HipChat/lib/hipchat.bin
  dosym /opt/HipChat/bin/hipchat /usr/bin/hipchat
}