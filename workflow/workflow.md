# Workflow when Developing with git

This will serve as a general workflow when doing development on a
project.

- [Setup](#setup)
- [Code](#code)
- [Review](#review)
- [Cleanup](#cleanup)
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
like ```git co-master``` if you followed [Configuring git]
(../setup/git-setup.md) recommendations.

- From the master branch, create a feature branch where you will add
your contribution. By convention, for feature branch names, we use the
format ```<username>-<feature_name>```, like:<br> ```git checkout -b
jeff-service```

- Use of 'git rebase' is suggested to keep feature branches up to
date. [Configure git](../setup/git-setup.md) for this to work
properly.  See [rerere documentation]
(https://git-scm.com/docs/git-rerere) and [rebasing documentation]
(https://www.git-scm.com/book/en/v2/Git-Branching-Rebasing) for
further details, but the general workflow is:

```
git checkout master
git pull
git checkout <branch-name>
git rebase master
```

#### Code

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

- When your code is tested, you are ready to [review](#review).

#### Review

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

- Reviewers can sign off by leaving a comment on the *conversation*
tab of the pull request.

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
necessary, be certain to commit them to your feature branch.

- Go to the master branch:<br>```git checkout master```

- Merge your changes to the master branch:<br>```git merge <branch-name>```

- Push the merge to GitHub:<br>```git push```

#### Cleanup
You should clean up your old branches. To do so:

- Delete remote branch. If you [configured git](../setup/git-setup.md),
<br>```git rmrbranch <branch-name>```

- Delete local branch:<br>```git branch -d <branch-name>```

#### Managing submodules

Assuming you [configured git](../setup/git-setup.md), the following
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
