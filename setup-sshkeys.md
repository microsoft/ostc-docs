# Setting up SSH Public/Private Keys

We recommend setting up SSH public/private keys to access UNIX/Linux
systems quickly and effectively:

1. [What is a public-private key](#what-is-a-public-private-key)
2. [How to create a public-private key](#how-to-create-a-public-private-key)
3. [Keeping remote systems up to date](#keeping-remote-systems-up-to-date)

-----

#### What is a Public-Private key

SSH (on UNIX/Linux systems) supports login via public/private key.
The idea here is that you never get prompted for username or password
again when logging on to UNIX/Linux systems. It works from putty on
Windows as well, along with SecureCRT and other popular terminal
emulators supporting the SSH protocol. Very, very useful.

Also, [PBUILD](https://github.com/Microsoft/pbuild) requires use of
public/private keys to work properly. This mechanism only works if you
use a non-shared account. **We do not** recommend that you set this up on
some shared account (i.e. root).


#### How to Create a Public-Private Key

To create a public/private key:

* Use ssh-keygen. Do this from your “primary” UNIX machine (where you do
most of your development). This will be something like:
```
ssh-keygen -t rsa -b 2048 -C "Microsoft-internal"
```

Resulting output will be something like:

>
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/jeffcof/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/jeffcof/.ssh/id_rsa.
Your public key has been saved in /home/jeffcof/.ssh/id_rsa.pub.
The key fingerprint is:
68:8e:50:3c:8d:cc:fa:77:2b:ad:cc:88:d6:5f:2f:4a Microsoft-internal
```
>

* In general, we don't recommend the use of a passphrase, although
that is up to you. Most UNIX/Linux systems are shared systems with
sudo access (i.e. inherently insecure). If you do use a passphrase,
then you’ll need to use ssh-agent to cache that (or set up your
[terminal emulator](setup-git.md) to cache that), or you’ll need to
type the passphrase many, many times. We strongly recommend use a
passphrase if connecting remotely and SSH is passed through the
firewall (i.e. when connecting from work to home, that has a
passphrase), or if you're connecting to a secure system. But that’s
not the case here.

* This will create two files in your .ssh directory: id_rsa and id_rsa.pub

* Create a link for authorized keys (basically, this is the list of keys
that can be remotely used to log in):
  * Create a link from id_rsa.pub with a command like:<br>
        `(cd ~/.ssh; ln -s id_rsa.pub authorized_keys)`
  * Tar up your .ssh directory: `tar –cf ssh.tar .ssh`
  * Copy the ssh.tar file to each of your remote systems and untar it.
  * Be sure that the .ssh directory has a permission of 700 or things won’t work! Also, the private key file (id_rsa) must have a permission of 600.

So, to summarize: Create the public/private key. Copy the key files to each
of your remote systems. On each remote system, .ssh/id_rsa.pub should exist,
.ssh/id_rsa (the private key) should exist, and authorized_keys should exist
and should be a link to .ssh/id_rsa.pub.

This gets you the ability to SSH and SCP from Linux/Unix system to Linux/Unix
system without password prompts. You can use this same public/private key,
if you wish, to avoid password prompts when SSHing from Windows to UNIX as well.
I do that as well. Same key files work fine. To do this from putty, use the
‘puttygen’ program to import your key into putty.


#### Keeping remote systems up to date

As an aside, you can keep remote systems up to date via two mechanisms:

1. Create some shell scripts to distribute the latest/greatest
.bash_profile file (and any other files you’d like) to a list of
remote systems.  This lets you maintain the same environment
everywhere.

2. Use something like [dotfiles](https://github.com/jeffaco/dotfiles)
to store important common files. Then a 'git pull' will update your system.
