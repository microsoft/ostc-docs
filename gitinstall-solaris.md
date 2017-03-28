# Installing git on Solaris

We were able to use [common packages](https://www.opencsw.org/)
to install git on Solaris. There are two mechanisms to install git:

Topics in this document:

* [Installing via Internet](#installing-via-internet)
* [Installing via saved streams](#installing-via-saved-streams)

-----

##### Installing via Internet

The process to install git is very simple. First, you need a program
called pkgutil to deal with the .pkg files from [The OpenCSW Project]
(https://www.opencsw.org/). The following command will both install
the pkgutil package and then install git from the CSWgit package:

```
pkgadd -d http://get.opencsw.org/now
/opt/csw/bin/pkgutil -U
/opt/csw/bin/pkgutil -y -i git
```

To list the packages that were installed:

```
/usr/sbin/pkgchk -L CSWgit # list files
```


##### Installing via Saved Streams

[The OpenCSW Project]: https://www.opencsw.org/
[streams]: https://www.opencsw.org/manual/for-administrators/no-internet-access.html#no-internet-access

[The OpenCSW Project][] allows *streams* to
be downloaded locally, and for installation of git to happen from
those streams. To guarentee that we can always install git, even if
[The OpenCSW Project][] is no longer available,
we have saved [streams][] to install git on Solaris.

The file share that contains the Solaris files is:

```
\\redmond\wsscfs\OSTCData\NixArchive\SourceCodeManagement\git\Solaris
```

The following table describes the subdirectory for each of our supported
Solaris platforms. Each location contains a stream file for the associated
platform (called *git-and-others.pkg*), a command script to install it, and
a download.log file showing the commands used to create the *stream* file
(in case the stream file becomes corrupted):

Version | Architecture | Directory | Command Script
------- | ------------ | --------- | --------------
5.10 | sparc | 5.10/sparc | install_git_Solaris_5.10_sparc.sh
5.10 | x86 | 5.10/i386 | install_git_Solaris_5.10_i386.sh
5.11 | sparc | 5.11/sparc | install_git_Solaris_5.11_sparc.sh
5.11 | x86 | 5.11/i386 | install_git_Solaris_5.11_i386.sh

To install git, download the package and the shell script to a directory.
The follow command sequence shows the appropriate steps for installation:

```
cd <directory-with-files>
sudo bash
chmod +x <command-script-from-table-above>
./<command-script-from-table-above>
```
