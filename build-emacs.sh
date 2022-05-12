#!/bin/bash
# Builds emacs from the git repo
set -e

PKG_CONFIG_PATH=$(fd -s -td pkgconfig /usr /lib | paste -s -d":")

CFLAGS=$(dpkg-buildflags --get CFLAGS)
CFLAGS+=" -Wall"
LDFLAGS=$(dpkg-buildflags --get LDFLAGS)
CPPFLAGS=$(dpkg-buildflags --get CPPFLAGS)

# common configure flags
confflags="--sharedstatedir=/var/lib"
confflags+=" --libexecdir=/usr/lib"
confflags+=" --localstatedir=/var/lib"
confflags+=" --infodir=/usr/share/info"
confflags+=" --mandir=/usr/share/man"
confflags+=" --with-pop=yes"
confflags+=" --with-sound=alsa"
confflags+=" --without-gconf"
confflags+=" --with-mailutils"
confflags+=" --with-json"
confflags+=" --with-modules"
confflags+=" --without-compress-install"
confflags+=" --with-gnutls"
confflags+=" --without-gconf"
confflags+=" --without-xwidgets"
confflags+=" --without-toolkit-scroll-bars"
confflags+=" --without-xaw3d"
confflags+=" --without-gsettings"
confflags+=" --with-native-compilation"
confflags+=" --with-json"
confflags+=" --with-harfbuzz"
confflags+=" --with-jpeg"
confflags+=" --with-png"
confflags+=" --with-rsvg"
confflags+=" --with-tiff"
confflags+=" --with-wide-int"
confflags+=" --with-xft"
confflags+=" --with-xml2"
confflags+=" --with-xpm"

# x configure flags
confflags+=" --with-cairo"
confflags+=" --with-x=yes"

./autogen.sh

PKG_CONFIG_PATH="$PKG_CONFIG_PATH" CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" CPPFLAGS="$CPPFLAGS" ./configure $confflags

make
