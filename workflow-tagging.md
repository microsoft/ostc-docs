# Workflow for Tagging a Release

Tagging for a release a very simple. There are typically two types of
tagging operations:

1. [Tagging the Superproject](#tagging-the-superproject)
2. [Tagging the Subproject](#tagging-the-subproject)

Note that when you want to tag the subproject (to publish a release on
GitHub, for example), then you still must tag the superproject, as the
superproject captures all of the actual dependencies.

Thus, to tag the subproject, you must perform all steps in this
document.

>**Important: Pick consistent tag names when creating tags!**
>If you fail to to so, then it's harder for cusotmers to find
>predictable tags and potentially link against them. In particular,
>you should avoid sometimes prefixing tags with `v` and sometimes not.

>Here's an example of what NOT to do (done for OMS-Agent-for-Linux):

>```
1.0.0-47
v1.0.0-47
v1.1.0-2
v1.1.0-28
>```

>Tag `1.0.0-47` was created, and external sources linked against
>that. It's traditional for version tags to be prefixed with `v`,
>forcing us to have two tags for the same release.


### Tagging the Superproject

Our projects usually have superprojects to capture all
dependencies. This allows, for example, DSC to capture dependencies
for DSC itself, omi, and the pal, all of which are required to
properly capture the state of a release.

We'll use the [DSC project][] as an example to create tags.

When doing ```git lol``` (if you followed [Setting up git][]) on the [DSC
superproject][], you'll see output such as:

>```
* b574cae (HEAD, origin/master, origin/HEAD, master) Update submodules and version for daily build (v1.1.1-74)
* 4581e1a Update submodules and version for daily build (v1.1.1-73)
* f09ee18 Update submodules and version for daily build (v1.1.1-72)
* 9a3f721 Update submodules and version for daily build (v1.1.1-71)
* 267290e Update submodules and version for daily build (v1.1.1-70)
* 7b91046 Update submodules and version for daily build (v1.1.1-69)
* 6328e68 Update submodules and version for daily build (v1.1.1-68)
* f29305e Update submodules and version for daily build (v1.1.1-67)
* 0429b43 Update submodules and version for daily build (v1.1.1-66)
* 544c0a1 Update submodules and version for daily build (v1.1.1-65)
>```

To create a tag for, say, v1.1.1-70, then you need to identify the
commit hash for version v1.1.1-70. Given the log snippet above, that
commit hash is: `267290e`. Given that, first check out the commit hash
that you wish to tag:

```
git checkout 267290e
```

You will get output like the following:

>```
Note: checking out '267290e'.
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
HEAD is now at 267290e... Update submodules and version for daily build (v1.1.1-70)
>```

In particular, note the last line: it shows the commit message for the
commit hash. That's a great way to verify that you have the proper
commit hash.

Now create a tag for that commit hash in the superproject and push it
to the server:

```
git tag v1.1.1-70
git push --tags
```

That's it. You have now created a tag for the superproject, capturing
all dependencies for that release. Note that this operation can be done
anytime, potentially years after the original release was prepared.

[Setting up git]: setup-git.md
[DSC project]: https://github.com/Microsoft/PowerShell-DSC-for-Linux
[DSC superproject]: https://github.com/Microsoft/Build-PowerShell-DSC-for-Linux

### Tagging the Subproject

Sometimes we wish to tag the subproject, particularly when GitHub is
used as a release vehicle for specific releases (the subproject is the
project where all the activity happens). To do so, we first go to the
superproject, check out the version tag already created (see above),
and set the submodules to refer to that version:

```
cd bld-dsc
git checkout v1.1.1-70
git submodule update
```

This will fetch v1.1.1-70 of the superproject *and set all of the
subprojects to the approprite git commit hash for that release*.

Next, you create a tag on the subproject and push it to the server:

```
cd dsc
git tag v1.1.1-70
git push --tags
```

That's it! The subproject now has the appropriate tag for that
version.

Finally, go to the [DSC Release Page][] on GitHub, create release notes for
that release, and upload the binary packages.

[DSC Release Page]: https://github.com/Microsoft/PowerShell-DSC-for-Linux/releases