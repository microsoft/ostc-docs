# Installing git on HP-UX

Topics in this document:

* [Installing via Depot Packages](#installing-via-depot-packages)
* [Installing via Internet](#installing-via-internet)
  * [Caching Depot Packages](#caching-depot-packages)
* [Installing via Source Code](#installing-via-source-code)
* [Basic git functionality test](#basic-git-functionality-test)

## Installing via Depot packages

This is the recommended install method if you have read access to the wsscfs network share.

* Login as root on the target HPv3 system : `ssh root@myHPv3system`
* Create a temporary folder to hold the depot files : `mkdir -p /root/GIT`
* Copy over the depot packages to `/root/GIT`
  * HPv3 ia64 : `\\redmond\wsscfs\OSTCData\NixArchive\SourceCodeManagement\git\HP-UX\v3ia64`
  * HPv3 parisc : `\\redmond\wsscfs\OSTCData\NixArchive\SourceCodeManagement\git\HP-UX\v3risc`
* Unzip the compressed depot files : `gunzip /root/GIT/*.gz`
* Install the git dependencies then git itself. The dependencies were [obtained using depothelper](#caching-depot-packages).

For HPv3 ia64:
```shell
swinstall -s /root/GIT/bzip2-1.0.6-ia64-11.31.depot bzip2
swinstall -s /root/GIT/curl-7.46.0-ia64-11.31.depot curl
swinstall -s /root/GIT/cyrus_sasl-2.1.26-ia64-11.31.depot cyrus_sasl
swinstall -s /root/GIT/db-6.0.20-ia64-11.31.depot db
# swinstall -s /root/GIT/depothelper-2.00-ia64-11.31.depot depothelper
swinstall -s /root/GIT/editline-2.9-ia64-11.31.depot editline
swinstall -s /root/GIT/expat-2.1.0-ia64-11.31.depot expat
swinstall -s /root/GIT/flex-2.5.39-ia64-11.31.depot flex
swinstall -s /root/GIT/fontconfig-2.11.1-ia64-11.31.depot fontconfig
swinstall -s /root/GIT/freetype-2.6.2-ia64-11.31.depot freetype
swinstall -s /root/GIT/gdbm-1.10-ia64-11.31.depot gdbm
swinstall -s /root/GIT/gettext-0.19.7-ia64-11.31.depot gettext
swinstall -s /root/GIT/heimdal-1.5.2-ia64-11.31.depot heimdal
swinstall -s /root/GIT/libXft-2.3.2-ia64-11.31.depot libXft
swinstall -s /root/GIT/libXrender-0.9.9-ia64-11.31.depot libXrender
swinstall -s /root/GIT/libiconv-1.14-ia64-11.31.depot libiconv
swinstall -s /root/GIT/libidn-1.32-ia64-11.31.depot libidn
swinstall -s /root/GIT/libpng-1.6.8-ia64-11.31.depot libpng
swinstall -s /root/GIT/m4-1.4.17-ia64-11.31.depot m4
swinstall -s /root/GIT/openldap-2.4.43-ia64-11.31.depot openldap
swinstall -s /root/GIT/openssl-1.0.2e-ia64-11.31.depot openssl
swinstall -s /root/GIT/packages-ia64-11.31 packages
swinstall -s /root/GIT/perl-5.10.1-ia64-11.31.depot perl
swinstall -s /root/GIT/tcltk-8.5.18-ia64-11.31.depot tcltk
swinstall -s /root/GIT/termcap-1.3.1-ia64-11.31.depot termcap
swinstall -s /root/GIT/zlib-1.2.8-ia64-11.31.depot zlib

swinstall -s /root/GIT/git-2.7.0-ia64-11.31.depot git
```
* [Test the installation](#basic-git-functionality-test)
* Cleanup : `rm -rf /root/GIT`

## Installing via internet

This method should be used if you don't already have access to the downloaded packages or if you want the latest versions of the packages installed. 
* Get the correct depothelper version for your flavor of HP from [hpux.connect.org](http://hpux.connect.org.uk/hppd/hpux/Sysadmin/depothelper-2.00/)
* Install depothelper for example: `swinstall -s depothelper-2.00-hppa-11.31.depot depothelper`
* Install git with depothelper : `/usr/local/bin/depothelper git`
* [Test the installation](#basic-git-functionality-test)

### Caching Depot Packages
To get a copy of the required depot packages required, depothelper can be run with these qualifiers:
```
depothelper -n -c /root/GIT git

Options used:
-n will download the depots but not install them.
-c <cache directory> specifies the cache directory for downloaded files
```

## Installing via Source Code

It is possible that the git binary installed through depothelper does not work because the configuration of your system is different. Simply rebuild git from source.
* Get the appropriate HP ported version of git source code from [hpux.connect.org](http://hpux.connect.org.uk/hppd/hpux/Development/Tools/git-2.7.0/). It is the one that has the package type : Source Code.
* Although the file is named "tar.gz" it might just be a regular tar file. Verify with `file git-2.7.0-src-11.31.tar.gz`
* Untar the git source `tar -x git-2.7.0-src-11.31.tar.gz`
* Configure git for your system : `cd git-2.7.0/; ./configure`
* Build git : `make`
* Make sure an old version of git is not present : `sudo swremove git`
* Install git : `sudo make install`
* Test the installation by trying to clone a repo, create a commit in a new branch and push it upstream.
* If the [basic functionality test](#basic-git-functionality-test) fails, you might have to reconfigure git using non default options.

## Basic git functionality test
```shell
git clone --recursive git@github.com:Microsoft/Build-SCXcore.git
cd Build-SCXcore/
git checkout -b test-branch
echo test > test.txt
git add test.txt
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git config --global push.default current
git commit -m "test message"
git push
git push origin --delete test-branch
```
