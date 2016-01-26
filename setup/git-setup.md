# Setting up your environment for use with git

We recommend following some basic steps to use git effectively:

1. [Set up authentication](#setting-up-authentication) with GitHub
2. [Configure git](#configuring-git)

-----

#### Setting up authentication

Authentication with GitHub can be a hassle unless you set up an SSH
key via your github account. We would strongly suggest setting up an
SSH key with a (strong) passphrase, adding the public key to your
github account, and then add the private key to your SSH program to
act as an SSH agent.

The basic steps are:

1. [Create an SSH key for github] (https://help.github.com/articles/generating-ssh-keys/)
2. Configure your SSH program to act as an SSH agent. Our team uses a
variety of SSH programs. Some examples are:
  1. [Putty] (http://www.chiark.greenend.org.uk/~sgtatham/putty/), [Using Pageant](http://the.earth.li/~sgtatham/putty/0.58/htmldoc/Chapter9.html)
  2. [SecureCRT](https://www.vandyke.com/products/securecrt/index.html)/[SecureFX]
     (https://www.vandyke.com/products/securefx/index.html) bundle, [Configure SecureCRT]
     (https://www.vandyke.com/support/tips/agent_forwarding.html#agent)
  3. [MobaXterm] (http://mobaxterm.mobatek.net/), [Configure MobaXterm] (MobaXterm-config.md)

Other SSH programs exist as well, or you can use the
[SSH Agent] (http://sshkeychain.sourceforge.net/mirrors/SSH-with-Keys-HOWTO/SSH-with-Keys-HOWTO-6.html)
that is included as part of [OpenSSH] (https://en.wikipedia.org/wiki/OpenSSH)
as well (although this only works for a single Linux session).

The end result of this mechanism: You specify the passphrase once when
you start your SSH program or agent, and then you never type the
passphrase again.


#### Configuring git

*To be supplied at a later date*
