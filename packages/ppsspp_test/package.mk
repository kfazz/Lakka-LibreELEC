################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-2016 Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

PKG_NAME="ppsspp_test"
PKG_VERSION="e119d37"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/hrydgard/ppsspp"
#PKG_URL="https://github.com/hrydgard/ppsspp/archive/$PKG_VERSION.tar.gz"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain yasm:host alsa-lib systemd dbus libSM libICE SDL2"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="PPSSPP 1.5.4"
PKG_LONGDESC="PPSSPP is a Playstation Portable Emulator   ."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="SYSROOT_PREFIX=$SYSROOT_PREFIX \
                           "

#pre_configure_target() {
#  LDFLAGS="$LDFLAGS -ldl"
#  cmake ../
#}

PKG_CMAKE_SCRIPT="$PKG_BUILD/CMakeLists.txt"
#PKG_CMAKE_OPTS_HOST="-DTHREADS_PTHREAD_ARG=0"
