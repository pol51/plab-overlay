# start with: $ steam steam://store
# to bypass beta blockage
#
# i3wm configuration:
# for_window [class="Steam"] floating enable

EAPI=4

inherit eutils

DESCRIPTION="Steam for Linux"

HOMEPAGE="https://steampowered.com"

SRC_URI="http://media.steampowered.com/client/installer/steam.deb"

# /usr/portage/licenses/
LICENSE="GPL-3+"
SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="sys-libs/glibc
app-emulation/emul-linux-x86-baselibs
app-emulation/emul-linux-x86-gtklibs
app-emulation/emul-linux-x86-opengl
app-emulation/emul-linux-x86-sdl
app-emulation/emul-linux-x86-soundlibs
app-emulation/emul-linux-x86-xlibs
"


RDEPEND="$DEPEND"

#S=${WORKDIR}/${P}

src_unpack() {
    cd "$WORKDIR"
    echo "ohhai $(pwd)" 1>&2
    #ar x steam.deb
    unpack $A
    tar xf data.tar.gz
    mkdir -p $S #dirty hack, fix pls
}

src_install() {


    mv $WORKDIR/usr $D/

    # Replace [ ] with [[ ]] in /usr/bin/steam
    sed "s/\[/\[\[/g" -i $D/usr/bin/steam
    sed "s/\]/\]\]/g" -i $D/usr/bin/steam
}