# Artix_Freshtomato_Samba4
Samba4 for FreshTomato-mips


For Building Freshtomato (mips) with samba4 in Artix,
- the sym-link to python in /usr/bin has to be changed from python3 to python2. 
- Also files release/src/router/common.mak, release/src/router/miniupnpd/Makefile.linux, release/src/router/miniupnpd/genconfig.sh 
and release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c (release/src-rt-6.x/linux/linux-2.6/scripts/squashfs/mksquashfs.c for RT-N build) 
have to be patched.
- release/src/router/Makefile need some Artix-related patches as documented in 
- release/src/router/nettle/desdata.stamp has to be removed.
- As samba4 depends on libtirpc  a target for libtirpc has to be implemented in release/src/router/Makefile  and one of "samba3" passages in
  release/src/router/Makefile have to be replaced by "samba4" passages.

All these steps above are incorporated in a shell script.

2. Download source of samba-4.9.16 and extract it into an folder in your home directory.
3. Create folder for samba4.x in your local freshtomato-mips repo (e.g./release/src/router/samba4)
4. Copy content of folder with samba-4.9.16 sources into the folder of 3.). 
5. Download this repo and copy answer_positiv.txt and Makefile_samba4 into the folder of 3.).
6. Downlaod sources of libtirpc_1.1.4 and extract them into an folder in your home directory.
7. Create folder for libtirpc in your local freshtomato-mips repo. (e.g. release/src/router/libtirpc)
9. Copy content of folder with sources of  libtirpc_1.1.4 into the folder of 7.).
10. start shell script in your local copy of this repo of 

BR
st-ty1
