# Installing git on AIX

Topics in this document:

* [Problems with Common Repositories](#problems-with-common-repositories)
* [Instructions for Installing git](#instructions-for-installing-git)

-----

##### Problems with Common Repositories

Why did we not use common repositories to install git on AIX?

File ```/usr/lib/libssl.a``` has binary references to the SSL library,
libssl.so.0.9.8. When common repositories installed git, they
installed a newer version of SSL with it (in /usr/local).

This caused problems with Jenkins; Jenkins was unable to properly use
git (via Java) because SSL 1.0.x wasn't referenced in
```/usr/lib/libssl.a```. By replacing the file with a newer one from
the /usr/local directory, this caused OMI to link against SSL 1.0.x,
would result in customers being unable to install OMI properly.


##### Instructions for Installing git

The instructions to install git work properly on both AIX 6.1 and AIX 7.1:

1. Install RPM dependencies from [IBM](http://www-03.ibm.com/systems/power/software/aix/linux/toolbox/alpha.html)
  - autoconf
  - m4
  - zlib
  - zlib-devel
2. Extract git v2.7 source from [Github](https://github.com/git/git/releases/tag/v2.7.0)
3. Configure git
  - `cd git-2.7.0/; make configure; ./configure --without-tcltk`
4. Build and install
  - `sudo make install`
