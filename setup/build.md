# Setting Up a Machine for Build Purposes

Many projects have specific requirements to building, and those
requirements are generally documented with the project itself.
However, there is a *common set* of requirements that most projects
require. These are captured here.

Table of Contents:

* [sudo configuration](#sudoers-configuration)
* Machine-specific Setup Requirements
  * [HP-UX openssl.pc files](#hp-ux-openssl.pc-files)

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

#### HP-UX openssl.pc files

Many projects require linking against OpenSSL. For consistency, such
projects often use [pkg-config](https://en.wikipedia.org/wiki/Pkg-config)
