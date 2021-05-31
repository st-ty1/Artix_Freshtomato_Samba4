#! /bin/sh

## path to Artix-patch folder for building FT
FT_PATCHES_DIR=$HOME/Documents/freshtomato-mips

## path to the FT-repo folder
FT_REPO_DIR=$HOME/freshtomato-mips

## path to your local repo of FT-samba4
FT_SAMBA_DIR=$HOME/Documents/freshtomato-samba4

## path to extracted libtirpc-sources
LIBTIRPC_DIR=$FT_SAMBA_DIR/libtirpc_1.1.4

## toolchain paths
export PATH="$FT_REPO_DIR/tools/brcm/hndtools-mipsel-linux/bin:$PATH"
export PATH="$FT_REPO_DIR/tools/brcm/hndtools-mipsel-uclibc/bin:$PATH"

cd $FT_REPO_DIR 
git clean -dxf 
git reset --hard

## for RT-images:
#git checkout mips-master
## for RT-N- and RT-AC-images:
git checkout mips-RT-AC

## Arch-Linux-patches for all builds
patch -i $FT_PATCHES_DIR/Makefile_mips.patch $FT_REPO_DIR/release/src/router/Makefile
patch -i $FT_PATCHES_DIR/miniupnpd_config.patch $FT_REPO_DIR/release/src/router/miniupnpd/configure
patch -i $FT_PATCHES_DIR/configure.in_apcupsd.patch $FT_REPO_DIR/release/src/router/apcupsd/autoconf/configure.in
patch -i  $FT_PATCHES_DIR/configure.ac_transmission.patch $FT_REPO_DIR/release/src/router/transmission/configure.ac

## patches for samba4
mkdir $FT_REPO_DIR/release/src/router/samba4
cp -rf $FT_SAMBA_DIR/samba-4.9.16/* $FT_REPO_DIR/release/src/router/samba4
cp -rf $FT_SAMBA_DIR/answer_positiv.txt $FT_REPO_DIR/release/src/router/samba4/answer.txt
cp -rf $FT_SAMBA_DIR/Makefile_samba4 $FT_REPO_DIR/release/src/router/samba4/Makefile
patch -i $FT_SAMBA_DIR/Makefile_samba_libtirpc.patch $FT_REPO_DIR/release/src/router/Makefile
mkdir $FT_REPO_DIR/release/src/router/libtirpc
cp -rf $LIBTIRPC_DIR/* $FT_REPO_DIR/release/src/router/libtirpc

## for RT-AC-images:
cd release/src-rt-6.x
make wndr4500v2z ## > build.txt; AIO: z; VPN: e

## only RT-N-Images
#cd release/src-rt
#make n64z ## > build.txt; AIO: z; VPN: e; 


