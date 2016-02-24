# Workflow for Creating a Hotfix Release

Creating a hotfix for a release is very simple. As an example, I'll
use the [OMS project][], creating a mythical hotfix solely for example
purposes.

The basic steps to creating a hotfix release are:

1. [Check in your patches](#check-in-your-patches)
2. [Set subproject references](#set-subproject-references)
3. [Set up superproject](#set-up-superproject)
4. [Build your project](#build-your-project)
5. [Create tags and clean up](#create-tags-and-clean-up)

All command examples assume you followed [Setting up git][] guidelines.

-----

### Check in your patches

For reference, the [OMS project][] has five subprojects:

1. dsc
2. omi
3. omsagent
4. opsmgr
5. pal

First, you should probably be sure that your projects are completely
up to date, and that you're set to the master branch for each
subproject:

```
cd ~/dev/bld-omsagent
git co-master
git sync-subs
```

For our hotfix, let's assume we need to modify the OMS Agent
configuration file, [omsagent.conf][]. First, we modify the file and
check in the modified result into a new branch:

```
cd omsagent
git checkout -b jeff-hotfix
emacs installer/conf/omsagent.conf
git commit -m "Fix parameters passed to omsadmin.sh for onboarding"
```

Obviously, other changes can be made to other files as part of this
hotfix.

### Set subproject references

Now that we have a hotfix checked into the [omsagent.conf][] file, we
need to set up other subprojects as desired. For purposes of discussion,
let's say that we need to choose a prior version of [DSC][] than what is
checked into mainline.

We last left our shell cd'ed into the omsagent subproject. So, we'll
issue a `git lol` command against DSC as follows:

```
cd ../dsc
git lol
```

You'll see output such as:

>```
* a9ccdf5 (HEAD, origin/master, origin/dywu-nxOMSPlugin, origin/HEAD, master) Fix formatting and link in readme
* 2c3cb16 Update readme.md
* 6a41725 Update readme.md
* 087b08f Correct Debian version format of OMI to x.y.z.r (rather than x.y.z-r)
* d0e6421 (tag: v1.1.1-70) Fix up log rotation for OMI (consider moving to OMI project later)
* b88c2f7 Explicitly disable -Werror in ./configure
* 3b8679c Fix compile warnings in EngineHelper
* 499a8a5 Add instructions to build from source
>```

Let's say we don't want to ship the three most recent commits in the
hotfix, instead shipping with "Correct Debian version format" and
earlier. To do so:

```
git checkout 087b08f
```

This will result in output such as:

>```
Note: checking out '087b08f'.
>
You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.
>
If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:
>
  git checkout -b new_branch_name
>
HEAD is now at 087b08f... Correct Debian version format of OMI to x.y.z.r (rather than x.y.z-r)
>```

Note that the last line helpfully shows the log message for the commit
hash. This allows you to easily verify that you picked the correct git
hash.

At this point, go to each of the other subprojects, making sure that
the latest commits are what you want. If necessary, you can exclude
some of the latest commits to the master branch, or you can make edits
to other projects as described under
[Check in your patches](#check-in-your-patches).

### Set up superproject

Change your directory back to the superproject with a command like `cd ..`.

You need to pick an appropriate version number to build your hotfix
with. One way to achieve this is to bump file `omsagent.version` to a
later version on the master branch. For example purposes, file
`omsagent.version` currently contains:

>```
# -*- mode: Makefile; -*-
#--------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation.  All rights reserved.
#--------------------------------------------------------------------------------
# 2015-10-06
#--------------------------------------------------------------------------------
>
OMS_BUILDVERSION_MAJOR=1
OMS_BUILDVERSION_MINOR=1
OMS_BUILDVERSION_PATCH=0
OMS_BUILDVERSION_BUILDNR=63
OMS_BUILDVERSION_DATE=20160224
OMS_BUILDVERSION_STATUS=Developer_Build
>```

Edit the `OMS_BUILDVERSION_BUILDNR` tag to a larger number, like 64
(note that a regular build will increment this before building). By
incrementing to 64, that will leave 64 available for your
hotfix. After editing, commit your change to the master branch:

```
git add omsagent.version
git commit -m "Bump omsagent.version file so v1.1.0-64 is available for hotfix"
git push
```

Next, set the `omsagent.version` file as needed for your hotfix to
contain the following lines:

>```
OMS_BUILDVERSION_BUILDNR=64
OMS_BUILDVERSION_DATE=20160224
OMS_BUILDVERSION_STATUS=Release_Build
>```

We will use v1.1.0-64 for the hotfix, we anticipate our build date to
be 02-24-2016, and this will be a *Release_Build* (not a
*Developer_Build*).

If you now issue a `git status` command, you'll see output like:

>```
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   dsc (new commits)
#       modified:   omsagent (new commits)
#       modified:   omsagent.version
#
no changes added to commit (use "git add" and/or "git commit -a")
>```

The `dsc` and `omsagent` commit hashes have changed due to our changes
above. If other subprojects have changed for your hotfix, be certain
to `git add` those subprojects to capture the changes. Create a new
branch on the superproject and commit all of these files to that
branch:

```
git checkout -b jeff-hotfix
git add dsc omsagent omsagent.version
git commit -m "Hotfix (v1.1.0-64) to resolve onboarding parameters"
git push
```

### Build your project

We now have the superproject set up with a branch (`jeff-hotfix`) to
reflect the exact changes that we need to build our hotfix with, but
in terms of the omsagent.verison file and in terms of the commit
hashes for each of the subprojects.

To build this, under Jenkins, we have a special build job called
`OMSAgent-Manual`. This differs from the regular `OMSAgent-Build` job
in two ways:

1. It makes no changes at all to omsagent.version, nor to any commit
hashes for subprojects, and
2. When `OMSAgent-Manual` is run, it prompts for a tag or branch to
build with.

Run the `OMSAgent-Manual` and supply to branch to the superproject
that should be used with the build (`jeff-hotfix`).

If there are build failures, fix the sources as needed to resolve them
(consider using `commit --amend` as documented in
[Workflow for Development](workflow-workflow.md)
to keep the commit logs clean). Be sure to update the superproject to
the new commit hashes before trying any additional builds.

Once you have built successfully and verified that the kit has the
required fixes for your hotfix, you need to *clean up* as specified
next.

### Create tags and clean up

As described in [Git Tagging/Branching Mechanisms][], we don't
generally keep branches around unless they are needed for ongoing
development. As a result, we must delete the temporary branches and
create tags so git will not [garbage collect][] our changes.

**When creating tags, it is important to pick consisent tag names. For
further information, see [Workflow for Tagging a Release][].**

In the above example/exercise, the state of our subprojects are as follows:

Subproject | State
---------- | -----
dsc | Chagned to a prior commit hash
omi | No changes from master branch
omsagent | Created new branch, `jeff-hotfix`, for changes
opsmgr | No changes from master branch
pal | No changes from master branch

We should delete the branches and create tags for each of the
subprojects where files were changed (in this case, `omsagent` and the
superproject itself).

First, for the omsagent subproject:

```
cd omsagent
git lol
```

will result in output like:

>```
* e971421 (HEAD, origin/jeff-hotfix, jeff-hotfix) Fix parameters passed to omsagent.sh for onboarding
* a7a0a13 (origin/master, origin/HEAD, master) Adding encoding check function to the output plugin
>```

We want to go to the master branch, delete branch `jeff-hotfix` (both
locally and on the server), and create a tag for it instead:

```
git checkout master
git branch -D jeff-hotfix
git rmrbranch jeff-hotfix
git checkout e971421
git tag v1.1.0-64-hotfix
git push --tags
```

Next, we perform the identical procedure to the superproject:

```
cd ..
git checkout master
git tag -D jeff-hotfix
```

Note the output from `git tag -D jeff-hotfix`:

>```
Deleted branch jeff-hotfix (was d30524d).
>```

That (helpfully) gives the commit hash that you need to tag:

```
git rmrbranch jeff-hotfix
git checkout d30524d
git tag v1.1.0-64-hotfix
git push --tags
```

You've deleted all of your temporary branches and created tags, so
we're done!


[Setting up git]: setup-git.md
[Workflow for Tagging a Release]: workflow-tagging.md
[DSC]: https://github.com/Microsoft/PowerShell-DSC-for-Linux
[OMS project]: https://github.com/Microsoft/Build-OMS-Agent-for-Linux
[OMS subproject]: https://github.com/Microsoft/OMS-Agent-for-Linux
[omsagent.conf]: https://github.com/Microsoft/OMS-Agent-for-Linux/blob/master/installer/conf/omsagent.conf
[Git Tagging/Branching Mechanisms]: workflow-branching.md
[garbage collect]: http://think-like-a-git.net/sections/graphs-and-git/garbage-collection.html