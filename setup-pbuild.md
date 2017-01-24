# Setting up for PBUILD

[pbuild]: https://github.com/Microsoft/pbuild
[OMI]: https://github.com/Microsoft/omi
[OSTC Documentation]: https://github.com/Microsoft/ostc-docs

[pbuild][] is a tool used as part of our development process to
verify that the proposed code changes do not impact regression
tests.  Running [pbuild][] a mandatory step in the development
process, and must be done before changes are submitted for review.

### Assumptions

Pbuild is a generic test tool that can be used across a variety of
projects.

Users are assumed to be familiar with Git, Github and general OSTC
development practices. For additional information, refer to other
pages in [OSTC Documentation][].

### Set up your [pbuild][] environment

1. Clone a copy of [pbuild][] on your machine,
2. Get a sample .pbuild file from [Jeff Coffler's dotfiles repository]
(https://github.com/jeffaco/dotfiles/blob/master/nix/pbuild/pbuild).
3. Place the .pbuild file in your home directory, and edit the section
relevant to your project according to your needs. Note that lines that
start with `#` are ignored by pbuild. Fields in this file are explained
in the header section of .pbuild file.
4. Create the log files directories for pbuild:

```
mkdir ~/pbuild_logs ~/pbuild_logs/prior
```

### Set up base user files

For machines to work properly with [pbuild][], you must create a base
`.bash_profile`, `.bashrc`, and SSH keys.

If you don't already have `.bash_profile` and `.bashrc`, you can grab
the ones used by the [build systems]
(https://github.com/Microsoft/ostc-tools/tree/master/build). These can
be used as a starting point for you to customize your own files to set
up your environment however you would like.

Create your SSH keys by following [these instructions]
(https://github.com/Microsoft/ostc-docs/blob/master/setup-sshkeys.md).
Once done create a `tar` file that contains your setup files like this:

```
tar cf base-unix.tar .bash_profile .bashrc ssh.tar
```

Keep this `tar` file handy for the steps below. If you have other
configuration files you wish to use (emacs configuration files or
whatever), you can add those to `base-unix.tar` as well.
	
### Set up individual pbuild machines

Your .pbuild file describes a set of machines that your tests will run
on, in parallel. These machines are typically shared amongst
developers, and support simultaneous builds by multiple developers.
To support this test environment, each developer needs to set up
his/her own account on the test system, and tests are run essentially
using the OpenSSH `ssh` command.

#### Create User Accounts

Each test machine needs an account. For ssh to work effectively, the
account name should match the user name that you normally use.  For
purpose of this document, let's say if your normal user name is
`username`. You should then create a login of `username` on the pbuild
machines.

Note that our builds routinely require `sudo` operations without a
password prompt. You can edit the `/etc/sudoers` file, but since these
files generally allow allow group `scxdev` to execute commands without
a password, it's easier to make sure you belong to that group. Also,
specific commands may vary between our platforms.

For these reasons, it's easiest to use Jeff Coffler's [addme]
(https://github.com/jeffaco/msft-bin/blob/master/addme) script. If you
use this script, **be sure to edit** `myuid` and `myuname`, both at the
beginning of the file.

- Create a user account on the machine:

```
scp ~/bin/addme root@machine_name
ssh root@machine_name
sh ~/bin/addme
rm ~/bin/addme
exit
```

For most Linux/Unix systems, the `addme` script is sufficient to create
the user. On MAC systems, however, th GUI must be used. Use [VNC Viewer]
(https://www.realvnc.com/download/viewer/) to connect to the Mac system
(username `admin`, standard root password) and then use
`System Preferences -> Users & Groups` to create the account.

- Copy `tar` file to remote system and extract contents

```
scp base-unix.tar ssh.tar machine_name:
ssh machine_name
tar xf base-unix.tar
tar xf ssh.tar
rm base-unix.tar ssh.tar
chmod 700 .ssh
exit
```

- Verify that your account is set up properly with SSH keys

If you `ssh machine_name`, you should now get no login prompt (you should
be directly logged in).

Verify proper `sudo` configuration with a command like `sudo ls`, and you
should get no password prompt.

#### Rince and Repeat

Now that you have set up one machine in the .pbuild list, you need to
repeat this for every other machine.
