#! /bin/sh

FT_MIPS_REPO_DIR=path/to/your/local/ft-mips-repo

export PATH="$PATH:FT_MIPS_REPO_DIR/tools/brcm/hndtools-mipsel-linux/bin"
export PATH="$PATH:FT_MIPS_REPO_DIR/tools/brcm/hndtools-mipsel-uclibc/bin"

export INSTALLDIR=$HOME/temp
export HOSTDIR=$HOME/documents/freshtomato-samba4/samba-host

rm -rf $INSTALLDIR/samba4
rm -rf samba4
mkdir samba4
cp -r samba-4.9.16/* samba4
cp answer_positiv.txt samba4/answer.txt

cd samba4

#+++++ following lines are used for 1st time to get asn1_compile and compile_et of host, they can be commented out later.

##                configure of host-samba (arguments and variables)

python_LDFLAGS="" python_LIBDIR="" CC=gcc LD=ld CFLAGS="-O2" \
./configure --disable-cups --disable-iprint --disable-cephfs --disable-fault-handling \
--disable-glusterfs --disable-rpath --disable-rpath-install --disable-rpath-private-install --enable-fhs \
--without-automount --without-iconv --without-lttng --without-ntvfs-fileserver --without-pam --without-systemd --without-utmp --without-json \
--without-dmapi --without-fam --without-gettext --without-regedit --without-gpgme \
--nonshared-binary=asn1_compile \
--disable-avahi --without-quotas --without-acl-support --without-winbind --without-ad-dc --without-libarchive \
--without-json-audit --disable-gnutls --disable-python --nopyc --nopyo --without-dnsupdate --without-ads --without-ldap 

## arguments --target=, --host=, --build=, --program-prefix=, --program-suffix=, --disable-nls und --disable-ipv6 not working anymore.
## openwrt additionally with:
##    --with-static-modules=!DEFAULT,!FORCED \ 
##    --with-shared-modules=!DEFAULT,!FORCED 

##               compile of host-samba

python_LDFLAGS="" python_LIBDIR="" CC=gcc LD=ld CFLAGS="-O2" ./buildtools/bin/waf build --targets=asn1_compile,compile_et 

##               install of host-samba

install -d $HOSTDIR
install bin/asn1_compile $HOSTDIR/asn1_compile_host 
install bin/compile_et $HOSTDIR/compile_et_host

#+++++ can be commented out to this line after 1st make. 

#+++++ following lines can used after 1st make with generation of asn1_compile and compile_et of host.

#export USING_SYSTEM_ASN1_COMPILE=1
#export ASN1_COMPILE="$HOSTDIR/asn1_compile_host"  
#export USING_SYSTEM_COMPILE_ET=1
#export COMPILE_ET="$HOSTDIR/compile_et_host"

#+++++ can be commented out to this line after 1st make.

##               configure of target-samba

python_LDFLAGS="" python_LIBDIR="" \
CFLAGS="-Wall -ffunction-sections -fdata-sections -fPIC -I/usr/include/tirpc" \
CPPFLAGS="-Wall -ffunction-sections -fdata-sections -fPIC" \
LDFLAGS="-ffunction-sections -fdata-sections -Wl,--gc-sections -L/home/stephan/Dokumente/freshtomato-samba4/libtirpc_1.1.4/src/.libs -ltirpc" \
CC=mipsel-linux-gcc AR=mipsel-linux-ar CPP=mipsel-linux-cpp LD=mipsel-linux-ld RANLIB=mipsel-linux-ranlib ./configure --cross-compile --cross-answers=answer.txt \
--disable-cups \
--disable-iprint \
--disable-cephfs \
--disable-fault-handling \
--disable-glusterfs \
--disable-rpath \
--disable-rpath-install \
--disable-rpath-private-install \
--enable-fhs \
--without-automount \
--without-iconv \
--without-lttng \
--without-ntvfs-fileserver \
--without-pam \
--without-systemd \
--without-utmp \
--without-dmapi \
--without-fam \
--without-gettext \
--without-regedit \
--without-gpgme \
--without-quotas \
--with-lockdir=/tmp/var/lock \
--with-logfilebase=/tmp/var/log \
--with-piddir=/tmp/var/run \
--with-privatedir=/etc/samba \
--with-privatelibdir=/usr/lib \
--localstatedir=/tmp/var \
--disable-avahi \
--without-winbind \
--without-acl-support \
--without-ad-dc \
--without-libarchive \
--disable-python --nopyc --nopyo \
--without-dnsupdate --without-ads --without-ldap \
--disable-gnutls \
--without-json \
--accel-aes=none \
--prefix=/usr \
--bundled-libraries=talloc,tevent,tevent-util,texpect,tdb,ldb,tdr,cmocka,replace,com_err,popt,z,roken,wind,hx509,asn1,heimbase,hcrypto,krb5,gssapi,heimntlm,hdb,kdc,NONE \
--nonshared-binary=pdb_smbpasswd,pdb_tdbsam,auth_builtin,auth_sam,auth_unix,auth_script,smbd,smbclient,cifsdd 

##             compiling of target-samba

./buildtools/bin/waf build

#             installing of target-samba

./buildtools/bin/waf install --destdir=$INSTALLDIR/samba4 
