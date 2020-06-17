# Git Basics

The following guide will go over the bas

## Git GUI Client

While it might be uncomfortable at first, it is recommended to use the Terminal when working with Git in order to get familiar with the commands, workflow and capabilities that the tool has to offer. If you wish to use a Git GUI client, consider the following options:

* [Fork](https://git-fork.com)

* [GitHub Desktop](https://desktop.github.com)

* [GitKraken](https://www.gitkraken.com)

* [SourceTree](https://www.sourcetreeapp.com)

## Accessing a repo

Two ways of accessing a repo, one by cloning, and the other one by `git init`.

### Cloning

While your terminal is at the folder where you want to clone the repo, execute `git clone <repolink.git>`. When you `cd` into the repo folder, your git should now be at `master`

### Existing Folder

If you have an existing folder where you want to place the files of the repo, you should use the `git init` workflow instead.

Navigate to your folder using the terminal. Execute `git init`. This will create the `.git` files that Git needs to function. Your terminal might now indicate that you are in a Git folder.

Then, enter `git remote add origin <repolink.git>`. This tells Git that the remote repo (aka upstream) is at `<repolink.git>`.

Now, pull the remote files using `git pull`. Your folder should now fill with the repo files and you are ready to work on `master`.

## Branches

### Update your branch cache

When there are new branches created, Git does not automatically update your cache. Use the command `git fetch -a` to receive a list of all the branches available at the remote. Then use `git branch -a` to see a list of all the branches (including those at the remote).

### Creating a new branch

While you don't always need to, you should do `git pull` and `git fetch -a` to ensure that you have the latest version locally. This is especially true for if you're trying to create a branch off `master`.

First `git checkout <branch>` you want to start your new branch from.

Then, execute `git checkout -b <nameOfnewBranch>` to create a branch.

Alternatively, you can just do `git checkout -b <nameOfnewBranch> origin/<branch>`.

## Typical workflow

While you are contributing to a repo, there is a typical workflow you will be doing all the time.

### Staging, Commiting, Pushing

After you've done some modifications, you use `git add <fileName>` to stage them (add them to your commit). Alternatively, you can use `git add .` or `git add *` to stage all modified files.

Then you commit the changes by giving them a [Good commit message](#writing-good-git-commit-messages) using `git commit -m "[#issueNumber] PresentTenseVerb + detail"`. Alternatively, you could do the `add` and `commit` in one step using `git commit -am "<commit message>"`. Note that this `-am` command only stages and commit files already tracked by Git (if you created any new files, they will be ignored, so you'll have to use `git add <file>`.

Before you push the commit, ensure that your branch has been updated with any new commits from the remote by executing `git pull`.

Finally, push the commit with `git push`.

### Reverting some changes

If you've tried something, it's not working and you would like to go back to a previous edition of the file you have modified, you can use `git checkout <nameOfFile>`. There is also `git reset` that will reset all changes to the nearest commit and `git revert` that can revert the changes of files you have committed. Check the commands help page for more usage information. This is why _frequent commits_ and _frequent pushes_ are important, as you risk losing all your work if you do not do it often enough.
