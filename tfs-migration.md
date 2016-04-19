# TFS Migration

The OSTC team has tried several tools to migrate our source
repositories from TFS to Git. We ended up using [Git-Tf]
(https://gittf.codeplex.com/), which did the job. All of the TFS to
Git migrations to date were made using git-tf-2.0.3.20131219.zip. This
can be downloaded via [codeplex](https://gittf.codeplex.com), or can
be copied from: `\\redmond\wsscfs\OSTCData\NixArchive\SourceCodeManagement\git`.

Some basic observations when using the tool:

- The tool maintains commit history by doing a commit for each
Teamprise checkin. This can take a while for very active repositories.

- The tool isn't "great" about memory usage, so it can take a fair
chunk of memory. In general, when running a Linux VM under Hyper-V
using LIS drivers, this doesn't pose any issue. Just be aware of this.

- The tool will create a tag for each TFS checkin, which we don't
really need. These can be removed with a command like:
`git tag | xargs git tag -d`

To clone a Teamprise branch to git using git-tf, you must first install
the git-tf tool. This can be done with something like:

```
unzip git-tf-2.0.3.20131219.zip
export PATH=$PATH:`pwd`/git-tf-2.0.3.20131219
```

Then, to run git-tf, you can use a command like:

```
git tf clone http://cdmvstf.corp.microsoft.com:8080/tfs/cdm $/CDM_SFE/Branches/OnPrem/Imp/SCX_Dev/omsagent --deep
```

Note that this does NOT require tfprox.

Project-specific notes:

Project | Issue
------- | -----
CM | When cloning CM project, some files are too big for github. The test/Tools/SuiteP2 directory contains a large file, and is fortunately no longer required for storage. Rewrite headers in git to eliminate this directory prior to pushing repository up to GitHub. (GitHub has a limit of 100MB for a single file.)

Other steps after migrating to Git:

1. Search for and remove all .tpattributes files, setting the execute
bits via git with a command like `git update-index --chmod=+x <files>`.
2. Create a .gitignore file to remove build artifacts from `git status`
commands.
3. Remove any MSBuild-specific files (bootstrap, build/TeamBuildTypes,
etc).
4. Create a superproject to capture all dependencies, if appropriate.
5. If a superproject was created, any build version file should live
with the superproject to avoid daily checkins to the active project.
6. Create a Jenkins build definition on the [Jenkins](http://jenkins-02.scx.com/)
server, verify that it works properly. Take care to only publish bits
that we really need to the build disk; intermediate files should **not**
be published to the build disk.
