# Fprime Guide

The following guide will cover the installation, deployment and capabalities

## TLDR

```bash
# Clone the Repo
git clone <repolink.git>

# Get Status (whether files were modified or remote was updated)
git status
# Pull changes to local
git pull # alternatively: git pull origin <branchName> (no '-u')
# Stage your changes
git add <filename> # alternatively: git add . to add all files
# Commit your changes
git commit -m "[#XX] Add Git guide's TLDR"
# Push your changes
git push # alternatively: git push -u origin <branchName> (note the '-u')

# Create a branch and switch to it
git checkout -b <branchName> # alternatively: just create the branch with git branch <branchName>
# Update the list of branches from the remote
git fetch -a
# Update your branch with the changes from master
git merge master
# Change branch
git checkout <branchName>
# Go back to master
git checkout master

# See the list of commits
git log
```
