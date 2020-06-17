# Advanced Git Guides

## Changing a commit

`git rebase -i HEAD~n` use a commit before the one you want to change

Use VIM to pick/reword/... (actually rewrite pick into "reword" or whatever other command)

`git push` (sometimes need `--force`)

## Archiving Branches

[Source](https://stackoverflow.com/questions/35738790/how-to-close-a-branch-in-git)

`git tag archive/<branchname> <branchname>`

`git branch -d <branchname>`

`git checkout master`

Retrieving the archived branch

`git checkout -b new_branch_name archive/<branchname>`

My solution (from remote)

`git tag archive/<branchname> remotes/origin/<branchname>`

`git push origin --delete <branchname>`

Then, update remote

`git push --tags`

## Overwrite Local Branch

[Source](https://www.freecodecamp.org/forum/t/git-pull-how-to-override-local-files-with-git-pull/13216)

`git fetch (--all)`

`git reset (--hard <remote>/<branch_name>)` i.e. `git reset --hard origin/master`

## Overwrite Remote Branch

`git push --force-with-lease` (better way, won't push if unknown state)

`git push --force` (unsafe way)

## Delete Sensitive Files from Git

[Source](https://help.github.com/en/github/authenticating-to-github/removing-sensitive-data-from-a-repository)

See [BFG guide](https://rtyley.github.io/bfg-repo-cleaner/) use `bfg` instead of the java commands (make sure to mirror)

Can also use `git filter-branch` (more details in source)

## Forking Workflow

[Source](https://docs.qmk.fm/#/newbs_git_using_your_master_branch)

For some development projects, you might want to fork an existing repository and keep the master branch updated with the fork, and only work off in a development branch in the fork.

## Keeping the master branch updated

* Add the source repo as your as a remote alias `git remote add upstream <repolink.git>`

  * Here we used `upstream` by convention, but you can name it anything you want

* Verify that the repository has been added by running `git remote -v` (the `<repolink.git>` should be displayed right next to the alias you chose (`upstream` in this case))

* Now you can check for updates in the source repo by using `git fetch <alias>` (`git fetch upstream`).

To update your fork's master branch, run the following (with `Enter` key after each line):

```bash
git checkout master
git fetch upstream
git pull upstream master
git push origin master
```
