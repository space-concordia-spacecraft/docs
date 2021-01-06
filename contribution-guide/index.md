# How to Contribute

The following guide will teach the user how to contribute to the documentation project for the SC-ODIN.

## Set up

_Note: The following steps require that the user know how to use Git. In order to familiarize yourself with the Git tool check this [Git Guide](/git-guide/basic-guide)._

In order to work on the project, the user must first clone the repo.

`git clone https://github.com/sc-odin/docs.git`

Install Node.js (easiest way is through the [package](https://nodejs.org/en/)), then install docsify

`npm install -g docsify`

## Contributing

Before contributing, make sure that you are familiar with using Markdown. You can check our [Markdown TLDR](/contribution-guide/markdown-tldr) if you want to have a quick look at how to use this language.

Additionally, make sure you are familiar with the [project structure](/contribution-guide/project-structure).

If you want to include UML diagrams into your modifications, it is also recommended you check our [Plant UML Guide](/contribution-guide/plant-uml)

In order to contribute, make sure your project is up to date

```bash
git pull
```

Create your own branch that will contain your modifications. For `<nameOfBranch>`, you might want to name it `fix/issue-you-want-to-fix` i.e. `fix/missing-links` or `feature/new-feature` i.e. `feature/new-resources`.

```bash
git checkout -b <nameOfBranch>
git push --set-upstream origin <nameOfBranch>
```

We strongly suggest that while you are making modifications, you have the project running so that you can see the results as you go

```bash
docsify serve ./docs
```

Once the changes have been made, push them to your branch. Check our [Git Guide](/git-guide/good-practices) on good practices to ensure that your commit message follows the standard

```bash
git add -A
git commit -m "Commit Name"
git push
```

Finally, once you have completed the feature or fix, it is time to merge back to dev and get rid of the current branch

```bash
git checkout dev
git merge --no-ff <nameOfBranch>
git branch -d <nameOfBranch>
```

If you wish to know more about proper branch management, we strongly recommend you take a look at this [guide](https://nvie.com/posts/a-successful-git-branching-model/).