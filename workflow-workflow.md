# Workflow when Developing with git

This will serve as a general workflow when doing development on a
project.

- [Setup](#setup)
- [Code](#code)
- [Pull Requests](#pull-requests)
- [Reviewing Changes](#reviewing-changes)
- [Merge](#merge)
- [Cleanup](#cleanup)

Other common operations that you may find useful include:

- [Resolving Merge Conflicts](#resolving-merge-conflicts)
- [Squashing Commit Messages](#squashing-commit-messages)
- [Managing Submodules](#managing-submodules)

-----

#### Setup

- Most of our repositories have a superproject to capture all
dependencies (Apache, dsc, MySQL, OMS-Agent, and SCXCore are all
examples of this).

- Fork the repository recursively to get the submodules. The name
of the project will vary based on what you're developing. The table
below is not intended to be exhaustive:

Project | Super-project Clone Command
------- | ---------------------------
Apache | ```clone --recursive git@github.com:Microsoft/Build-Apache-Provider.git```
DSC | ```clone --recursive git@github.com:Microsoft/Build-PowerShell-DSC-for-Linux.git```
MySQL | ```clone --recursive git@github.com:Microsoft/Build-MySQL-Provider.git```
OMS-Agent | ```clone --recursive git@github.com:Microsoft/Build-OMS-Agent-for-Linux.git```
SCXCore | ```clone --recursive git@github.com:Microsoft/Build-SCXcore.git```

- If you are contributing in a submodule (dsc, omi, omsagent, opsmgr,
pal, etc) chekout the *master* branch since it is where active
development is being made:<br>```git fetch; git checkout master```<br>
If you have just cloned the super-project, you can also use an alias
like ```git co-master``` if you followed [Configuring git](setup-git.md)
recommendations.

- From the master branch, create a feature branch where you will add
your contribution. By convention, for feature branch names, we use the
format ```<username>-<feature_name>```, like:<br> ```git checkout -b
jeff-service```

- Commit messages should be no more than about 70 bytes per line. If
you need a longer commit message than that, please use a multi-line
commit message, like this:

> Short summary of your change
>
> Longer description of your change. This description can contain as
> many lines as needed to describe what you have done. Each line
> should be no more than about 70 bytes in length.

- Use of 'git rebase' is suggested to keep feature branches up to
date. [Configure git](setup-git.md) for this to work
properly.  See [rerere documentation](https://git-scm.com/docs/git-rerere)
and [rebasing documentation](https://www.git-scm.com/book/en/v2/Git-Branching-Rebasing)
for further details, but the general workflow is:

```
git checkout master
git pull
git checkout <branch-name>
git rebase master
```

#### Code

- Create and switch to a new branch as mentioned above with a command like:<br>`git checkout -b user-featurename`.

- Make the changes as needed, test them out

- Commit the changes:

```shell
git add <changed files>
git commit -m "commit message"
```

- Push the changes to the server:<br>```git push```

- If you need to modify a prior commit, you can amend it (to avoid
squashing commits later) with a workflow like:

```shell
git add <changed files>
git commit --amend -m "commit message"
git push --force
```

If you use `git commit --amend`, an editor will be launched for you
to change the commit message. To use the identical commit message as
earlier, use `git commit --amend --no-edit`.

- If you do need to squash commit messages, see
[Squashing Commit Messages](#squashing-commit-messages).

- When your code is tested, you are ready to create a
[Pull Request](#pull-requests) to ask for code reviews.

#### Pull Requests

- On the GitHub page for the project that you are modifying, create a
new pull request. The following list is a list of pages for some of
our projects. This list is not intended to be exhaustive.
  - [Apache](https://github.com/Microsoft/Apache-Provider)
  - [dsc](https://github.com/Microsoft/PowerShell-DSC-for-Linux)
  - [MySQL](https://github.com/Microsoft/MySQL-Provider)
  - [omi](https://github.com/Microsoft/omi)
  - [OMS-Agent](https://github.com/Microsoft/OMS-Agent-for-Linux)
  - [pal](https://github.com/Microsoft/pal)
  - [SCXcore](https://github.com/Microsoft/SCXcore)

- The pull request should only show your changes. Be sure there is a
relevant subject for the pull request, and enter any comments to
clarify your changes for the reviewers. Also include an @team mention
to notify your fellow developers of the change.<br><br>
The @team mention can be satisfied with a line like ```@ostc-devs```
or ```@omsagent-devs```. See fellow developers to get the team list
that is appropriate for reviews on your project.

- If you need to make new changes based on review, you can just update
your branch with further commits and ask for additional reviews.

#### Reviewing Changes

- Reviewers can sign off by leaving a comment on the *conversation*
tab of the pull request.

- Experience dictates that Internet Explorer is slow for large pull
requests (with long lists of changes). Chrome is faster for purposes
of reviewing long pull requests.

- Note that [CodeFlow](http://codeflow/content/workflows-github-pullrequest.html)
now works with GitHub ([CodeFlow](http://codeflow/content/welcome.html)
is a Microsoft internal tool). Give that a try if you prefer that
interface.

#### Merge

Once the pull request is reviewed, it can be merged to the master
branch. While github itself can perform the merge easily, it uses the
`--no-ff` option (no fast-forward), resulting in somewhat messy git
logs. **As a result, we do not suggest use of github for merging your
changes.** Instead, we recommend use of the command line.

- Merge latest changes to your feature branch from the master branch:
```
git checkout master
git pull
git checkout <branch-name>
git rebase master
```

- Resolve any merge conflicts that may be necessary. If changes are
necessary, be certain to commit them to your feature branch. If you
need help on how to resolve a merge conflict, see
[below](#resolving-merge-conflicts).

- Go to the master branch:<br>```git checkout master```

- Merge your changes to the master branch:<br>```git merge <branch-name>```

- Push the merge to GitHub:<br>```git push```

#### Cleanup
You should clean up your old branches. To do so:

- Delete remote branch. If you [configured git](setup-git.md),
<br>```git rmrbranch <branch-name>```

- Delete local branch:<br>```git branch -d <branch-name>```

#### Resolving Merge Conflicts

When rebasing your changes to the master branch, you may get a merge
conflict. If that happens, you'll see output like:

```
$ git rebase master
First, rewinding head to replay your work on top of it...
Applying: Add --enable-microsoft to configure, enable native installation kits
Using index info to reconstruct a base tree...
M       Unix/configure
<stdin>:77: trailing whitespace.
    case "`uname -m`" in    
<stdin>:82: trailing whitespace.
        
warning: 2 lines add whitespace errors.
Falling back to patching base and 3-way merge...
Auto-merging Unix/configure
CONFLICT (content): Merge conflict in Unix/configure
Recorded preimage for 'Unix/configure'
Failed to merge in the changes.
Patch failed at 0001 Add --enable-microsoft to configure, enable native installation kits
The copy of the patch that failed is found in:
   /home/jeffcof/dev/bld-omi/.git/modules/omi/rebase-apply/patch
```

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

In this particular case, there was a problem merging changes to file `Unix/configure`.
For merge conflicts, the output from `git status` is very useful:

```
$ git status
# HEAD detached at 05ada53
# You are currently rebasing branch 'jeff-msft-build' on '05ada53'.
#   (fix conflicts and then run "git rebase --continue")
#   (use "git rebase --skip" to skip this patch)
#   (use "git rebase --abort" to check out the original branch)
#
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   Unix/build.mak
#
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#       both modified:      Unix/configure
#
```

This clearly shows what your options are (in the first few lines of the status
message). Furthermore, you can see that `Unix/configure` is unmerged. Looking at
this file with an editor will show the follow changes to this file:

```
<<<<<<< HEAD
    --show-version)
        echo $version
        exit 0
        ;;
=======
    --enable-microsoft)
      enable_preexec=1
      prefix=/opt/omi
      localstatedir=/var/opt/omi
      sysconfdir=/etc/opt/omi/conf
      certsdir=/etc/opt/omi/ssl
      enable_native_kits=1

      if [ "`uname -s`" = "Linux" ]; then
          enable_ulinux=1
      fi
      ;;

    --enable-native-kits)
      enable_native_kits=1
      ;;

    --enable-ulinux)
      if [ "`uname -s`" != "Linux" ]; then
          echo "The --enable-ulinux option is only valid on the Linux platform."
          exit 1
      fi

      enable_ulinux=1
      ;;
>>>>>>> Add --enable-microsoft to configure, enable native installation kits
```

This indicates the changes before your change, as well as the changes that
you have made to the file. Running command `git checkout --conflict=diff3` might
be useful as well. After running the command, the conflict in `Unix/configure`
looks like this:

```
<<<<<<< ours
    --show-version)
        echo $version
        exit 0
        ;;

||||||| base
=======
    --enable-microsoft)
      enable_preexec=1
      prefix=/opt/omi
      localstatedir=/var/opt/omi
      sysconfdir=/etc/opt/omi/conf
      certsdir=/etc/opt/omi/ssl
      enable_native_kits=1

      if [ "`uname -s`" = "Linux" ]; then
          enable_ulinux=1
      fi
      ;;

    --enable-native-kits)
      enable_native_kits=1
      ;;

    --enable-ulinux)
      if [ "`uname -s`" != "Linux" ]; then
          echo "The --enable-ulinux option is only valid on the Linux platform."
          exit 1
      fi

      enable_ulinux=1
      ;;

>>>>>>> theirs
```

This shows the original (base) change, the change causing the conflict
(labeled as `ours`), and your change (labeled as `theirs`).

In this particular case, all that's necessary is to remove the markers
added by git (to show the conflict). Both `--show-version` and `--enable-microsoft`
are correct, as follows:

```
    --show-version)
        echo $version
        exit 0
        ;;

    --enable-microsoft)
      enable_preexec=1
      prefix=/opt/omi
      localstatedir=/var/opt/omi
      sysconfdir=/etc/opt/omi/conf
      certsdir=/etc/opt/omi/ssl
      enable_native_kits=1

      if [ "`uname -s`" = "Linux" ]; then
          enable_ulinux=1 
      fi
      ;;

    --enable-native-kits)
      enable_native_kits=1
      ;;

    --enable-ulinux)
      if [ "`uname -s`" != "Linux" ]; then
          echo "The --enable-ulinux option is only valid on the Linux platform."
          exit 1 
      fi

      enable_ulinux=1
      ;;
```

At this point, you add the modified file to the commit list and follow
the instructions in the `git status` output:

```
jeffcof:omi> git add Unix/configure
jeffcof:omi> git rebase --continue
Applying: Add --enable-microsoft to configure, enable native installation kits
Recorded resolution for 'Unix/configure'.
jeffcof:omi>
```

Output from `git status` now shows that your merge is complete:

```
> git status
# On branch jeff-msft-build
# Your branch and 'origin/jeff-msft-build' have diverged,
# and have 1 and 1 different commit each, respectively.
#   (use "git pull" to merge the remote branch into yours)
#
Nothing to commit, working directory clean
> 
```

You can update your branch on the server with a command like `git push --force`.

#### Squashing Commit Messages

If you committed lots of changes in the scope of a single change (say lots
of iterations), you will likely want to "squash" your commits to a single
commit message appropriate for final checkin. Fortunately, the `git rebase`
command makes this easy.

As an example, say `git lol` produces output such as:

```
* b69be6f (HEAD, origin/v-brucc-master-pbuild, v-brucc-master-pbuild) Ending comma breaks solaris build
* 3334a09 MI_Application_InitializeV1 not available in libmiapi.a so link libmi.so
* f39d250 line endings break solaris
* 529b908 Return breaks build on solaris
* ab31a8b Changes required by aix
* 27fdc33 More changes for pbuild
* 0f8c298 changes to make pbuild owrk
* 81ebc04 (origin/master, origin/HEAD, master) Removed dos file endings (#73)
```

We can see that commit hashes 0f8c298..b69be6f are all part of a "single
change", and should be squashed to a single commit message. Let's do this
through interactive rebasing with a command like:

```
git rebase -i 0f8c298..b69be6f
```

This could also be done with a command like:

```
git rebase -i HEAD~7
```

to pick up the prior 7 commits.

This will launch your editor of choice (from `git config` settings) with
output similar to:

```
pick 0f8c298 changes to make pbuild owrk
pick 27fdc33 More changes for pbuild
pick ab31a8b Changes required by aix
pick 529b908 Return breaks build on solaris
pick f39d250 line endings break solaris
pick 3334a09 MI_Application_InitializeV1 not available in libmiapi.a so link libmi.so
pick b69be6f Ending comma breaks solaris build

# Rebase 60709da..b69be6f onto 60709da
#
# Commands:
#  p, pick = use commit
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#
```

As you can see, you have plenty of options available to you from this
screen. To squash everything into one commit, change the first lines
of the file as follows.

```
pick 0f8c298 changes to make pbuild owrk
squash 27fdc33 More changes for pbuild
squash ab31a8b Changes required by aix
squash 529b908 Return breaks build on solaris
squash f39d250 line endings break solaris
squash 3334a09 MI_Application_InitializeV1 not available in libmiapi.a so link libmi.so
squash b69be6f Ending comma breaks solaris build

# Rebase 60709da..b69be6f onto 60709da
#
# Commands:
#  p, pick = use commit
#  e, edit = use commit, but stop for amending
#  s, squash = use commit, but meld into previous commit
#
# If you remove a line here THAT COMMIT WILL BE LOST.
# However, if you remove everything, the rebase will be aborted.
#
```

This tells git to combine all seven commits into the first commit in
the list. Once this is done and saved, another editor pops up with the
following:

```
# This is a combination of 7 commits.
# The first commit's message is:
changes to make pbuild owrk

# Thisis the 2nd commit message:

More changes for pbuild

# This is the 3rd commit message:

Changes required by aix

# This is the 4th commit message:

Return breaks build on solaris

# This is the 5th commit message:

line endings break solaris

# This is the 6th commit message:

MI_Application_InitializeV1 not available in libmiapi.a so link libmi.so

# This is the 7th commit message:

Ending comma breaks solaris build

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# HEAD detached from 0f8c298
# You are currently editing a commit while rebasing branch 'v-brucc-master-pbuild' on 5a6e8f7
#
# Changes to be committed:
#   (use "git reset HEAD^1 <file>..." to unstage)
#
#       modified:   Unix/base/messages.h
#       modified:   Unix/build.mak
#       modified:   Unix/buildtool
#       modified:   Unix/codec/mof/parser/mof.qualifiers.h
#       modified:   Unix/codec/mof/parser/moflex.c
#       modified:   Unix/codec/mof/parser/mofy.redef.h
#       modified:   Unix/common/MI.h
#       modified:   Unix/common/common.h
#       modified:   Unix/configure
#       modified:   Unix/disp/agentmgr.c
#       modified:   Unix/mak/rules.mak
#       modified:   Unix/midll/GNUmakefile
#       new file:   Unix/midll/libmi.exp
#       modified:   Unix/pal/palcommon.h
#       modified:   Unix/providers/identify/GNUmakefile
#       modified:   Unix/tests/codec/mof/blue/consts.c
#       modified:   Unix/tests/codec/mof/blue/test_lex.cpp
#       modified:   Unix/tests/codec/mof/blue/test_mofserializer.cpp
#       modified:   Unix/tests/codec/mof/blue/test_parser.cpp
#
```

Since we're combining so many commits, git allows you to modify the
new commit's message based on the rest of the commits involved in the
process. Edit the message as you see fit, as shown below:

```
Changes to build & run regress on AIX, HP, and Solaris platforms

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# HEAD detached from 0f8c298
# You are currently editing a commit while rebasing branch 'v-brucc-master-pbuild' on 5a6e8f7
#
# Changes to be committed:
#   (use "git reset HEAD^1 <file>..." to unstage)
#
#       modified:   Unix/base/messages.h
#       modified:   Unix/build.mak
#       modified:   Unix/buildtool
#       modified:   Unix/codec/mof/parser/mof.qualifiers.h
#       modified:   Unix/codec/mof/parser/moflex.c
#       modified:   Unix/codec/mof/parser/mofy.redef.h
#       modified:   Unix/common/MI.h
#       modified:   Unix/common/common.h
#       modified:   Unix/configure
#       modified:   Unix/disp/agentmgr.c
#       modified:   Unix/mak/rules.mak
#       modified:   Unix/midll/GNUmakefile
#       new file:   Unix/midll/libmi.exp
#       modified:   Unix/pal/palcommon.h
#       modified:   Unix/providers/identify/GNUmakefile
#       modified:   Unix/tests/codec/mof/blue/consts.c
#       modified:   Unix/tests/codec/mof/blue/test_lex.cpp
#       modified:   Unix/tests/codec/mof/blue/test_mofserializer.cpp
#       modified:   Unix/tests/codec/mof/blue/test_parser.cpp
#
```

Save the file and exit the editor. Once that's done, your commits have
been successfully squashed!

If we now do a `git log`, we see output such as:

```
commit 5a6e8f7 (HEAD, v-brucc-master-pbuild)
Author: Bruce Campbell <yakman2020@users.noreply.github.com>
Date:   Fri Sep 23 09:56:16 2016

    Changes to build & run regress on AIX, HP, and Solaris platforms
    
commit 81ebc04 (origin/master, origin/HEAD, master)
Author: Bruce Campbell <yakman2020@users.noreply.github.com>
Date:   Wed Sep 21 07:50:34 2016

    Removed dos file endings (#73)
```

The `git status` command indicates:

```
# On branch v-brucc-master-pbuild
# Your branch and 'origin/v-brucc-master-pbuild' have diverged,
# and have 1 and 7 different commits each, respectively.
#   (use "git pull" to merge the remote branch into yours)
#
nothing to commit, working directory clean
```

Because the `v-brucc-master-pbuild` branch is now divergent from
the server branch (as indicated in the above status output), the
branch must be force-pushed to the server:

```
> git push --force
Counting objects: 72, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (34/34), done.
Writing objects: 100% (37/37), 7.99 KiB | 0 bytes/s, done.
Total 37 (delta 28), reused 5 (delta 2)
remote: Resolving deltas: 100% (28/28), completed with 28 local objects.
To git@github.com:Microsoft/omi.git
 + b69be6f...3d49ff1 HEAD -> v-brucc-master-pbuild (forced update)
>
```

#### Managing submodules

Assuming you [configured git](setup-git.md), the following
show common ways to manage all the submodules (all from the 
super-project):

```shell
# Switch to the master branch
git co-master

# Pull latest changes, delete stale remote-tracking branches
git sync-subs

# Show commit references for all the branches
git submodule foreach git branch -vv
```
