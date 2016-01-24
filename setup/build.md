# Setting Up a Machine for Build Purposes

Many projects have specific requirements to building, and those
requirements are generally documented with the project itself.
However, there is a *common set* of requirements that most projects
require. These are captured here.

Table of Contents:

* [sudo configuration](#sudoers-configuration)
* Machine-specific Setup Requirements
  * [HP-UX openssl.pc files](#hp-ux-openssl-pkg-config-files)

-----

#### Sudoers configuration

Two changes should be made to your sudoers configuration for omsagent
to build properly. We suggest using ```visudo``` program unless you
are confident on how to change /etc/sudoers properly.

1. Configure sudoers to not require a TTY.

 Some platforms require a TTY be default, and this can be problematic for
 background builds. If you have a line like:

 ```Defaults    requiretty```

 then comment it out (like this):

 ```#Defaults    requiretty```

2. Configure your account to not require a password by adding the
NOPASSWD: qualifier to the appropriate line that affects your
account. After the correct changes are applied to /etc/sudoers, test
under your personal account with the following sequence:

 ```shell
 sudo -k
 sudo ls
 ```

 If there is no password prompt, then /etc/sudoers was correctly modified.

-----

#### HP-UX openssl pkg-config files

Many projects require linking against OpenSSL. For consistency, such
projects often use [pkg-config](https://en.wikipedia.org/wiki/Pkg-config)
to get include file and linkage library information. Unfortunately, on the
HP-UX platform, these files are wrong, causing problems when programs are
later installed on the destination system.

A sample openssl.pc file (for HP-UX 11.23 ia64) looks like this:

```
prefix=/opt/openssl
exec_prefix=${prefix}
libdir=${exec_prefix}/lib/hpux32
includedir=${prefix}/include

Name: OpenSSL
Description: Secure Sockets Layer and cryptography libraries and tools
Version: 0.9.7l
Requires: 
Libs: -L${libdir} -lssl -lcrypto  -Wl,+s -ldl
Cflags: -I${includedir} 
```

Two changes were made:

* The *libdir* line has appended ```/hpux32``` to actually properly refer
to the library location.
* The *Libs* line has ```-lz``` removed from the end. In reality, OpenSSL
does not appear to require libz.sl or libz.so, and including that here can
cause problems if the destination system does not have that library.

These errors are consistent for HP-UX openssl.pc files. Changes must be
made to four sets of OpenSSL libraries:

Version | Architecture | File Path
------- | ------------ | ---------
11.23 | ia64 | /opt/openssl/lib/hpux32/pkgconfig/openssl.pc
11.23 | parisc | /opt/openssl/lib/hpux32/pkgconfig/openssl.pc
11.31 | ia64 | /opt/openssl/lib/pkgconfig/openssl.pc
11.31 | parisc | /opt/openssl/lib/pkgconfig/openssl.pc
