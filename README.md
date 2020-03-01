# Artix_Freshtomato_Samba4
How to build Samba4 for FreshTomato-mips


Steps needed:

1.) Download source of samba-4.9.18 (https://download.samba.org/pub/samba/samba-4.9.18.tar.gz) and extract it into a first folder in your home directory.

2.) Download this repo into a second folder in your home directory. Depending on you want compile for MIPSEL- or for ARM-router, also copy Makefile_RT-AC.patch or Makefile_arm.patch, common.mak.patch, genconfig.sh.patch, configure.ac_tor.patch and mksquashfs.c.patch from my github repo Artix_FreshTomato (https://github.com/st-ty1/Artix_FreshTomato) into this folder. 

3.) Download source of libtirpc_1.1.4 (https://sourceforge.net/projects/libtirpc/files/libtirpc/1.1.4/libtirpc-1.1.4.tar.bz2/download) and extract it into a third folder in your home directory.

4.) Start shell script build_ft-mips_samba.sh in folder of this repo.


Rem: To build Freshtomato(mips) with samba4 in Artix,
  - the sym-link to python in /usr/bin has to be changed from python3 to python2. 
  - release/src/router/Makefile need modifications:
      o some Artix-related patches are needed as documented in https://github.com/st-ty1/Artix_FreshTomato/blob/master/modification_FT_sources.txt.
      o as samba4 depends on libtirpc targets for libtirpc have to be implemented in release/src/router/Makefile. 
      o two of "samba3" passages in release/src/router/Makefile has to be replaced by "samba4" passages.
  - release/src/router/nettle/desdata.stamp has to be removed.
  - Makefile in release/src/router/samba has to be replaced.
    Remember that install-target of this Makefile is not optimized yet, i.e. also libfoo.pl has to be adapted because of newer and more libraries to be striped compared to samba-3.6.
  
   All these steps above are incorporated in shell script build_ft-mips_samba.sh.

BR
st-ty1
