# Git Commands

## Getting & Creating Projects

| Command | Description |
| ------- | ----------- |
| `git init` | Initialize a local Git repository |
| `git clone ssh://git@github.com/[username]/[repository-name].git` | Create a local copy of a remote repository |

## Basic Snapshotting

| Command | Description |
| ------- | ----------- |
| `git status` | Check status (also -s for short, --porcelain for pretty)|
| `git add [file-name.txt]` | Add a file to the staging area |
| `git add -A` | Add all new and changed files to the staging area |
| `git commit -m "[commit message]"` | Commit changes |
| `git rm -r [file-name.txt]` | Remove a file (or folder) |

## Branching & Merging

| Command | Description |
| ------- | ----------- |
| `git branch` | List branches (the asterisk denotes the current branch) |
| `git branch -a` | List all branches (local and remote) |
| `git branch [branch name]` | Create a new branch |
| `git branch -d [branch name]` | Delete a branch |
| `git push origin --delete [branch name]` | Delete a remote branch |
| `git checkout -b [branch name]` | Create a new branch and switch to it |
| `git checkout -b [branch name] origin/[branch name]` | Clone a remote branch and switch to it |
| `git branch -m [old branch name] [new branch name]` | Rename a local branch |
| `git checkout [branch name]` | Switch to a branch |
| `git checkout -` | Switch to the branch last checked out |
| `git checkout -- [file-name.txt]` | Discard changes to a file |
| `git merge [branch name]` | Merge a branch into the active branch |
| `git merge [source branch] [target branch]` | Merge a branch into a target branch |
| `git stash` | Stash changes in a dirty working directory [see Stash section](#stashing) |
| `git stash clear` | Remove all stashed entries |

## Sharing & Updating Projects

| Command | Description |
| ------- | ----------- |
| `git push origin [branch name]` | Push a branch to your remote repository |
| `git push -u origin [branch name]` | Push changes to remote repository (and remember the branch) |
| `git push` | Push changes to remote repository (remembered branch) |
| `git push origin --delete [branch name]` | Delete a remote branch |
| `git pull` | Update local repository to the newest commit |
| `git pull origin [branch name]` | Pull changes from remote repository |
| `git remote add origin ssh://git@github.com/[user]/[repo].git` | Add a remote repository |
| `git remote set-url origin ssh://git@github.com/[user]/[repo].git` | Set a repository's origin branch to SSH |

## Inspection & Comparison

| Command | Description |
| ------- | ----------- |
| `git log` | View changes |
| `git log --summary` | View changes (detailed) |
| `git log --oneline` | View changes (briefly) |
| `git diff [source branch] [target branch]` | Preview changes before merging |

## Stashing

Git only stashes staged and tracked files by default.

Use `git stash -u` to also stash untracked files.
Use `git stash -a` to also stash ignored files.

| Command | Description |
| ------- | ----------- |
| `git stash pop`| Reapply saved stash (can use stash@{id} for specific stashes and delete the stash|
| `git stash apply`| Reapply saved stash and keep it stashed|
| `git stash list`| List all saved stashes|
| `git stash show` `-p`| List changes between current and stash with `-p` for full diff|

More information can be found [here](https://www.atlassian.com/git/tutorials/saving-changes/git-stash)
