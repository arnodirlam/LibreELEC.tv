################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################


# TODO: update to libssh-0.6.3 fails in xbmc with
#   ld.gold: error: libsmbclient.a: multiple definition of 'string_free'
#   ld.gold: libssh.a: previous definition here

PKG_NAME="libssh"
PKG_VERSION="0.5.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OpenSource"
PKG_SITE="http://www.libssh.org/"
# PKG_URL="http://www.libssh.org/files/0.5/$PKG_NAME-$PKG_VERSION.tar.gz"
# PKG_URL="https://red.libssh.org/attachments/download/51/$PKG_NAME-$PKG_VERSION.tar.gz" # actually down
PKG_URL="http://pkgs.fedoraproject.org/repo/pkgs/libssh/$PKG_NAME-$PKG_VERSION.tar.gz/bb308196756c7255c0969583d917136b/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib libgcrypt"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="libssh: A working SSH implementation by means of a library"
PKG_LONGDESC="The ssh library was designed to be used by programmers needing a working SSH implementation by the mean of a library. The complete control of the client is made by the programmer. With libssh, you can remotely execute programs, transfer files, use a secure and transparent tunnel for your remote programs. With its Secure FTP implementation, you can play with remote files easily, without third-party programs others than libcrypto (from openssl)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DWITH_STATIC_LIB=1 -DWITH_GCRYPT="ON" \
        ..
}

makeinstall_target() {
# install static library only
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp src/libssh.a $SYSROOT_PREFIX/usr/lib
    cp src/threads/libssh_threads.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libssh.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libssh_threads.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/callbacks.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/legacy.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/libssh.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/server.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/sftp.h $SYSROOT_PREFIX/usr/include/libssh
    cp ../include/libssh/ssh2.h $SYSROOT_PREFIX/usr/include/libssh
}
