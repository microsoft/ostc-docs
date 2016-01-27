# Guidelines and Rules for Development

- [Rules](#rules)
- [New to Git?](#new-to-git)
- [Rebase and Fast-Forward Merge Pull Requests](#rebase-and-fast-forward-merge-pull-requests)
- [Submodules](#submodules)

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
