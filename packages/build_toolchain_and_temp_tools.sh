#!/bin/bash

set -u
set -e

: << 'END_COMMENT'
echo "extracting, building, and installing cross binutils"
(
  cd $LEWIX_MNT_ROOT_SRC_DIR
  tar -xf binutils-2.42.tar.xz

  cd binutils-2.42
  mkdir -vp build

  cd build
  ../configure --prefix=$LEWIX_MNT_ROOT_TOOLS_DIR \
    --with-sysroot=$LEWIX_MNT_DIR \
    --target=$LEWIX_TGT \
    --disable-nls \
    --enable-gprofng=no \
    --disable-werror
  make -j$(nproc)
  make install
)
END_COMMENT

: << 'END_COMMENT'
echo "extracting, building, and installing cross gcc"
(
  cd $LEWIX_MNT_ROOT_SRC_DIR
  tar -xf gcc-13.2.0.tar.xz
  cd gcc-13.2.0

  tar -xf ../mpfr-4.2.1.tar.xz
  mv -v mpfr-4.2.1 mpfr
  tar -xf ../gmp-6.3.0.tar.xz
  mv -v gmp-6.3.0 gmp
  tar -xf ../mpc-1.3.1.tar.gz
  mv -v mpc-1.3.1 mpc

  case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
    -i.orig gcc/config/i386/t-linux64
    ;;
  esac

  mkdir -vp build
  cd build

  ../configure \
    --target=$LEWIX_TGT \
    --prefix=$LEWIX_MNT_ROOT_TOOLS_DIR \
    --with-glibc-version=2.38 \
    --with-sysroot=$LEWIX_MNT_DIR \
    --with-newlib \
    --without-headers \
    --enable-default-pie \
    --enable-default-ssp \
    --disable-nls \
    --disable-shared \
    --disable-multilib \
    --disable-threads \
    --disable-libatomic \
    --disable-libgomp \
    --disable-libquadmath \
    --disable-libssp \
    --disable-libvtv \
    --disable-libstdcxx \
    --enable-languages=c,c++
  make -j$(nproc)
  make install

  cd ..
  cd $LEWIX_MNT_ROOT_SRC_DIR/gcc-13.2.0
  cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
    `dirname $($LEWIX_MNT_ROOT_TOOLS_DIR/bin/$LEWIX_TGT-gcc -print-libgcc-file-name)`/include/limits.h
)
END_COMMENT

: << 'END_COMMENT'
echo "extracting, building, and installing glibc"
(
  cd $LEWIX_MNT_ROOT_SRC_DIR
  tar -xf linux-6.7.4.tar.xz
  cd linux-6.7.4

  make mrproper
  make headers
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LEWIX_MNT_ROOT_DIR/usr
)
END_COMMENT

# FIXME: build glibc
: << 'END_COMMENT'
echo "extracting and copying Linux API headers"
(
  cd $LEWIX_MNT_ROOT_SRC_DIR
  tar -xf linux-6.7.4.tar.xz
  cd linux-6.7.4

  make mrproper
  make headers
  find usr/include -type f ! -name '*.h' -delete
  cp -rv usr/include $LEWIX_MNT_ROOT_DIR/usr
)
END_COMMENT
