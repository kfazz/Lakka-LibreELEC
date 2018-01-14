################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="ppsspp"
#PKG_VERSION="91452871ba7e5e9289069695108ac9b7bb4e319d" #Version 1.0.1+ #Works
#PKG_VERSION="4a36a16ded7ba617e2740f00a010b51c817338de" #Version 1.1.0  #Works
#PKG_VERSION="ba86acd1c04be890d4f14d45c7d51cfc1a446b37" #Version 1.1.1  #Works
#PKG_VERSION="44d6df27d3d0e6eaaf5bd664bc009b2642b2bf78" #Version 1.2    #Broken, crashes on fmv unload
#PKG_VERSION="b11a1fd8d070a2c6fe00de035a11c161cebe892b" #Version 1.2.2  #Works
#PKG_VERSION="2f31b5fddbcc5d54b406edf09a07752f8fdc0d18" #version 1.3    #works
#PKG_VERSION="25d58c0b1923649b4ca2c6289bd01219892bf7f0" #version 1.4 incomplete
#PKG_VERSION="dd73f9110d49a83478216672ea4880a1998c1ed2"  #libretro latest
PKG_VERSION="89326cbc79cf746036be5765545882c62921fa06"  #version 1.5.4+ git master 


#new test 1.3+ towards v1.4 until it breaks

#working builds ony work using buffered rendering

#PKG_VERSION="75d7e2810ed951973fc590201ed66a54ff09b76c" 	Works
#PKG_VERSION="7c31c86f25afaca4abd85b7357667724bb15c973"	#Works
#PKG_VERSION="e837ef681bd177c3292bda19b8715f1376af22a2" #works
#PKG_VERSION="62a8b5976e0f0138c3f3d44016fe611df4568914" #test #7 works

#PKG_VERSION="6d964f47d3ece0cf1fba1aa0655e4cd007563990" #test #8 Broken, black screen  
#fbo changes broke it, now carrying deleted funcs forwards on branch hackup

#PKG_VERSION="1a6e94854521a690948d368ae8b85d7b1e4ab44b" #hackup start
#PKG_VERSION="18623638e9cfb24a09949b04c7ffb7f4dd981a82" #hackup 2 ok
#PKG_VERSION="39175dc5642ece3ac9766d99a4b7c315a0178b25" #d05ef4a ok
#PKG_VERSION="6ebb68b2109eb61a56d17cec5dee7b6dc8f8f25a"  #hackup branch HEAD broken

PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/kfazz/ppsspp"
PKG_URL="https://github.com/kfazz/libretro-ppsspp/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of PPSSPP"
PKG_LONGDESC="A fast and portable PSP emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="no"

post_unpack() {
  rm -rf $BUILD/$PKG_NAME-$PKG_VERSION/
  git clone https://github.com/kfazz/libretro-ppsspp.git $BUILD/$PKG_NAME-$PKG_VERSION/
  cd $BUILD/$PKG_NAME-$PKG_VERSION/
  git checkout $PKG_VERSION
  git submodule update --init
  cd $ROOT
}

pre_configure_target() {
  strip_lto
}

make_target() {
  cd $PKG_BUILD/libretro
  CFLAGS="$CFLAGS -DGLEW_NO_GLU"
  if [ "$OPENGLES" == "gpu-viv-bin-mx6q" -o "$OPENGLES" == "imx-gpu-viv" ]; then
    CFLAGS="$CFLAGS -DLINUX -DEGL_API_FB"
    CXXFLAGS="$CXXFLAGS -DLINUX -DEGL_API_FB"
  fi
  if [ "$OPENGLES" == "bcm2835-driver" ]; then
    CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
    CXXFLAGS="$CXXFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
  fi
  if [ "$ARCH" == "arm" ]; then
    SYSROOT_PREFIX=$SYSROOT_PREFIX make platform=imx6
  else
    make
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../libretro/ppsspp_libretro.so $INSTALL/usr/lib/libretro/
}
