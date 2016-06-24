# Guidelines and Rules for Development

- [Rules](#rules)
- [New to Git?](#new-to-git)
- [Rebase and Fast-Forward Merge Pull Requests](#rebase-and-fast-forward-merge-pull-requests)
- [Submodules](#submodules)
- [How We Use Submodules](#how-we-use-submodules)

-----

### Rules

**Do not commit code changes directory to the master branch!**

**Read the documentation on [submodules][]!**

**Do not commit submodule updates accidentally!**

Don't forget to commit early and often!


### New to Git?

If you're new to Git, learn the following commands: `checkout`, `branch`,
`pull`, `push`, `rebase`, `merge`.

Use GitHub's [Hello World][] to learn how to create a feature branch,
commit changes, and issue a pull request.

The user name and email must be set in order to commit changes:

```sh
git config --global user.name "First Last"
git config --global user.email "alias@microsoft.com"

git config --global pull.ff only
git config --global push.default current
```

[submodules]: https://www.git-scm.com/book/en/v2/Git-Tools-Submodules
[hello world]: https://guides.github.com/activities/hello-world/
[guides]: https://guides.github.com/activities/hello-world/


### Rebase and Fast-Forward Merge Pull Requests

Because GitHub's "Merge Pull Request" button merges with `--no-ff`, an
extra merge commit will always be created. This can be especially
annoying when trying to commit updates to submodules. Therefore our
policy is to merge using the Git CLI after approval, with a rebase
onto master to enable a fast-forward merge. If you are uncomfortable
doing this, please ask @andschwa to merge.


### Submodules

Many of our projects are superprojects with a several
[submodules][]. **DO NOT** commit updates unless absolutely
necessary. Our daily build uses the master branch, and we don't want
to disturb those. When submodules must be updated, a separate Pull
Request must be submitted, reviewed, and merged before updating the
superproject.

[submodules]: https://www.git-scm.com/book/en/v2/Git-Tools-Submodules



### How We Use Submodules

Many of our products are dependent on other projects. We need two
things when we build projects that make use of dependencies:

1. Many of our builds require dependent projects to be in known
specific locations so one project can trigger a build of a related
project. For example, several projects are dependent on the
[pal](https://github.com/Microsoft/pal) and/or
[omi](https://github.com/Microsoft/omi), and require those projects
to be at the same directory path as the project itself, and

2. For support purposes, we need to be able to identify the specific
sources used to build a complete project, even if the project includes
other common components. This allows us to review actual files used
for the build when defects or bugs are reported.

That is exactly how we use super-projects and submodules. The
super-project contains the list of all repositories that are to be
used to build the overall project **and** where those projects are
checked out relative to one another, thus satisfying #1 above.

Since the super-project also contains specific commit hashes for each
subproject used to perform the build, this satisfies #2 above.

This use of super-projects has the advantage where the super-project
contains the daily commit history for build versioning. Thus, we avoid
cluttering up the source repo(s) with needless daily build commit
history.

Finally, when cloning, super-projects can be cloned recursively. This
makes it fast and easy to trivially capture all required dependenies
to build a complete project in a single step.

This is a sharp contrast to our prior use of TFS, where interdependent
projects needed to be set up manually for the build to run properly.