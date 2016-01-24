# Installing git on AIX

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
