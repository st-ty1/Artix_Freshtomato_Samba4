#! /bin/sh

## toolchain paths
export PATH="/home/stephan/freshtomato-mips/tools/brcm/hndtools-mipsel-linux/bin:$PATH"
export PATH="/home/stephan/freshtomato-mips/tools/brcm/hndtools-mipsel-uclibc/bin:$PATH"
export PATH="/usr/lib/ccache/bin/:$PATH"

## path to Artix-patch folder for building FT
FT_MIPS_ARTIX_PATCHDIR=$HOME/Dokumente/freshtomato-mips

## path to the FT-repo folder
FT_MIPS_REPODIR=$HOME/freshtomato-mips

## path to your local repo of FT-samba4
FT_SAMBA_DIR=$HOME/Dokumente/freshtomato-samba4

## path to extracted libtirpc-sources
LIBTIRPC_DIR=$HOME/Dokumente/freshtomato-samba4/libtirpc_1.1.4

cd $FT_MIPS_REPODIR 
git clean -dxf 
git reset --hard

## for RT-images:
#git checkout mips-master
## Achtung : libnfs-patch noch nicht enthalten; unklar, ob sinnvoll
#patch -i $FT_SAMBA_DIR/Makefile_master.patch $FT_MIPS_REPODIR/release/src/router/Makefile

## for RT-N- and RT-AC-images:
git checkout mips-RT-AC
patch -i $FT_SAMBA_DIR/Makefile_RT-AC.patch $FT_MIPS_REPODIR/release/src/router/Makefile


## Arch-Linux-patches for all builds
patch -i $FT_MIPS_ARTIX_PATCHDIR/common.mak.patch $FT_MIPS_REPODIR/release/src/router/common.mak
patch -i $FT_MIPS_ARTIX_PATCHDIR/Makefile.linux.patch $FT_MIPS_REPODIR/release/src/router/miniupnpd/Makefile.linux
patch -i $FT_MIPS_ARTIX_PATCHDIR/genconfig.sh.patch $FT_MIPS_REPODIR/release/src/router/miniupnpd/genconfig.sh
rm -f $FT_MIPS_REPODIR/release/src/router/nettle/desdata.stamp

## patches for samba4
mkdir $FT_MIPS_REPODIR/release/src/router/samba4
cp -rf $FT_SAMBA_DIR/samba-4.9.16/* $FT_MIPS_REPODIR/release/src/router/samba4
cp -rf $FT_SAMBA_DIR/answer_positiv.txt $FT_MIPS_REPODIR/release/src/router/samba4/answer.txt
cp -rf $FT_SAMBA_DIR/Makefile_samba4 $FT_MIPS_REPODIR/release/src/router/samba4/Makefile
mkdir $FT_MIPS_REPODIR/release/src/router/libtirpc
cp -rf $LIBTIRPC_DIR/* $FT_MIPS_REPODIR/release/src/router/libtirpc

#
## Arch-Linuc patch for RT-AC-images:
#patch -i $FT_MIPS_ARTIX_PATCHDIR/mksquashfs.c.patch $FT_MIPS_REPODIR/release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c
#cd release/src-rt-6.x
#make clean
make wndr4500v2z ## > build.txt; AIO: z; VPN: e

## only RT-N-Images
cd release/src-rt
patch -i $HOME/Dokumente/freshtomato-mips/mksquashfs.c.patch $HOME/freshtomato-mips/release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c 
make n64z ## > build.txt; AIO: z; VPN: e; 


