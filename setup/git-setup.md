# Setting up your environment for use with git

We recommend following some basic steps to use git effectively:

1. [Set up authentication](#setting-up-authentication) with GitHub
2. [Configure git](#configuring-git)

-----

#### Setting up authentication

Authentication with GitHub can be a hassle unless you set up an SSH
key via your github account. We would **strongly** suggest setting up an
SSH key with a **strong passphrase**, adding the public key to your
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

Based on our workflow, we suggest that git is configured in specific
ways to facilitate the way that we use the software.

The mandatory settings (below) **must** be set for git to even
function properly.

The strongly suggested settings should generally be taken verbatim
unless you have specific strong reasons for deviating, and you know
what you're doing.

The preference settings are useful to many, although your milage may
vary.

Finally, in common workflows with git, the aliases may make your work
with git faster and easier.

* Mandatory settings (**replace name/email with your own**):
```
git config --global user.name "Your Name"
git config --global user.email youremailaddress@yourdomain.com
```

* Strongly suggested settings:
```
git config --global am.threeWay true
git config --global apply.ignoreWhitespace change
git config --global core.excludesfile ~/.gitignore
git config --global log.decorate short
git config --global pull.ff only
git config --global push.default current
git config --global rerere.enabled true
git config --global rerere.autoUpdate true
```

* Preference Settings:
```
git config --global color.ui true
git config --global core.editor "emacs -nw"
git config --global credential.helper store
git config --global help.autoCorrect -1
git config --global log.abbrevCommit true
git config --global log.date local
git config --global url."git@github.com:".insteadOf "https://github.com/"
```

* Useful Aliases:
```
git config --global alias.co-master '!git submodule foreach git checkout master'
git config --global alias.lol 'log --oneline --graph'
git config --global alias.nuke '!git clean -fdx && git submodule foreach git clean -fdx'
git config --global alias.sub-status '!git submodule foreach git status'
git config --global alias.sync-subs '!git pull && git remote prune origin && git submodule foreach git pull && git submodule foreach git remote prune origin'
git config --global alias.rmrbranch 'push origin --delete'  # <Branch-name> supplied by user 
git config --global alias.rmrprune 'remote prune origin'
```
