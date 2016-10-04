# Build System Dependencies

For cost efficiency purposes, most UNIX-based projects on GitHub will
have minimum supported versions for platform support. This will allow
the OSTC team to efficiently utilize new hardware to support our
`build` and `development` systems.

The following indicates minimum supported versions for the following
platforms:

- AIX (IBM) Systems
  - [AIX 6.1](#aix-61)
  - [AIX 7.1](#aix-71)
- [HPUX 11.31 IA](#hpux-1131-ia)
- Solaris Platforms
  - [Solaris 10 Sparc](#solaris-10-sparc)
  - [Solaris 10 x86](#solaris-10-x86)
  - [Solaris 11 Sparc](#solaris-11-sparc)
  - [Solaris 11 x86](#solaris-11-x86)
- [SuSE Linux Enterprise Server](#suse-linux-enterprise-server)

-----

### AIX 6.1

Component | Version
--------- | -------
OS version | 6100-07-06-1241
xlC.rte | 11.1.0.2
OpenSSL/openssl.base | 0.9.8.1800

### AIX 7.1

Component | Version
--------- | -------
OS version | 7100-01-06-1241
xlC.rte | 11.1.0.2
OpenSSL/openssl.base | 0.9.8.1800

### HPUX 11.31 IA

On HP-UX, PAM is part of the core operating system components. There
are no other dependencies.

Component | Version
--------- | -------
HPUX11i-OE | B.11.31.1109
OS-Core.MinimumRuntime.CORE-SHLIBS | B.11.31 
SysMgmtMin | B.11.31.1109
SysMgmtMin.openssl | A.00.09.08q.003
PAM | Part of Core O/S

### Solaris 10 Sparc

Component | Version | Revision
--------- | ------- | --------
Release | Oracle Solaris 10 1/13 | s10s_u11wos_24a SPARC
SUNWlibC | 5.10 | REV-2004.12.22
SUNWlibmsr | 5.10 | REV=2004.11.23 
SUNWcslr | 11.10.0 | REV=2005.01.21.15.53
SUNWcsl | 11.10.0 | REV=2005.01.21.15.53
SUNWcsr | 11.10.0 | REV=2005.01.21.15.53
SUNWopenssl-libraries | 11.10.0 | REV=2005.01.21.15.53

### Solaris 10 x86

Component | Version | Revision
--------- | ------- | --------
Release | Oracle Solaris 10 9/10 | s10x_u9wos_14a X86
SUNWlibC | 5.10 | REV=2004.12.20
SUNWlibmsr | 5.10 | REV=2004.12.18
SUNWcslr | 11.10.0 | REV=2005.01.21.16.34
SUNWcsl | 11.10.0 | REV=2005.01.21.16.34
SUNWcsr | 11.10.0 | REV=2005.01.21.16.34
SUNWopenssl-libraries | 11.10.0 | REV=2005.01.21.16.34

### Solaris 11 Sparc

Component | Version | Revision
--------- | ------- | --------
Release | Oracle Solaris 11 11/11 SPARC
SUNWlibC | 5.11 | REV=2011.04.11
SUNWlibmsr | 5.11 | REV=2011.04.11
SUNWcslr | 11.11 | REV=2009.11.11
SUNWcsl | 11.11 | REV=2009.11.11
SUNWcsr | 11.11 | REV=2009.11.11
SUNWopenssl-libraries | 11.11.0 | REV=2010.05.25.01.00

### Solaris 11 x86

Component | Version | Revision
--------- | ------- | --------
Release | Oracle Solaris 11 11/11 X86
SUNWlibC | 5.11 | REV=2011.04.11
SUNWlibmsr | 5.11 | REV=2011.04.11
SUNWcslr | 11.11 | REV=2009.11.11
SUNWcsl | 11.11 | REV=2009.11.11
SUNWcsr | 11.11 | REV=2009.11.11
SUNWopenssl-libraries | 11.11.0 | REV=2010.05.25.01.00

### SuSE Linux Enterprise Server

Note that SuSE Linux 10 (SP1) for both i586 and x86_64 are used as
universal build systems for all other Linux platforms.

Required Package | Description | Minimum Version
---------------- | ----------- | --------------- 
glibc-2.4-31.30 | C Standard shared library | 2.4-31.30
OpenSSL | OpenSSL Libraries; Secure Network Communications Protocol | 0.9.8a-18.15
PAM | Pluggable Authentication Modules | 0.99.6.3-28.8
