# Artix_Freshtomato_Samba4
Samba4 for FreshTomato-mips


Steps needed:
1.) Download source of samba-4.9.16 and extract it into a folder in your home directory.

2.) Create folder for samba4.x in your local freshtomato-mips repo (e.g./release/src/router/samba4)

3.) Copy content of folder with samba-4.9.16 sources into the folder of 2.). 

4.) Download this repo and copy answer_positiv.txt and Makefile_samba4 into the folder of 2.).

5.) Downlaod sources of libtirpc_1.1.4 and extract them into a folder in your home directory.

6.) Create folder for libtirpc in your local freshtomato-mips repo (e.g. release/src/router/libtirpc) and copy content 
    of folder with sources of libtirpc_1.1.4 into the folder.

7.) Start shell script build_ft-mips_samba.sh in folder of this repo.


Rem: For Building Freshtomato (mips) with samba4 in Artix,
  - the sym-link to python in /usr/bin has to be changed from python3 to python2. 
  - Also files release/src/router/common.mak, release/src/router/miniupnpd/Makefile.linux, release/src/router/miniupnpd/genconfig.sh and
    release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (release/src-rt/linux/linux-2.6/scripts/squashfs/mksquashfs.c for 
    mips-RT-N and mips-RT builds) have to be patched.
  - release/src/router/Makefile need some Artix-related patches as documented in 
  - release/src/router/nettle/desdata.stamp has to be removed.
  - As samba4 depends on libtirpc targets for libtirpc have to be implemented in release/src/router/Makefile. 
  - Two of "samba3" passages in release/src/router/Makefile has to be replaced by "samba4" passages.
  
All these steps above are incorporated in shell script build_ft-mips_samba.sh .

BR
st-ty1
