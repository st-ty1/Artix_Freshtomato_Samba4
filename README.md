# Artix_Freshtomato_Samba4
How to build Samba4 for FreshTomato-mips


Steps needed:

1.) Download source of samba-4.9.16 and extract it into a first folder in your home directory.

2.) Download this repo into a second folder in your home directory. Depending on you want compile for MIPSEL- or for ARM-router, also copy Makefile_RT-AC.patch or Makefile_arm.patch, common.mak.patch, genconfig.sh.patch, configure.ac_tor.patch and mksquashfs.c.patch from my github repo Artix_FreshTomato (https://github.com/st-ty1/Artix_FreshTomato) into this folder. 

3.) Download sources of libtirpc_1.1.4 and extract them into a folder in your home directory.

4.) Start shell script build_ft-mips_samba.sh in folder of this repo.


Rem: To build Freshtomato(mips) with samba4 in Artix,
  - the sym-link to python in /usr/bin has to be changed from python3 to python2. 
  - Also the FT-source files release/src/router/common.mak, release/src/router/miniupnpd/genconfig.sh and
    release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c for mips-RT-N and mips-RT builds) have to be patched.
  - release/src/router/Makefile need some Artix-related patches as documented in https://github.com/st-ty1/Artix_FreshTomato/blob/master/modification_FT_sources.txt.
  - As samba4 depends on libtirpc targets for libtirpc have to be implemented in release/src/router/Makefile. 
  - Two of "samba3" passages in release/src/router/Makefile has to be replaced by "samba4" passages.
  - release/src/router/nettle/desdata.stamp has to be removed.
  
All these steps above are incorporated in shell script build_ft-mips_samba.sh .

BR
st-ty1
