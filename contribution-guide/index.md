# How to contribute

The following guide will teach the user how to contribute to the documentation for the SC-ODIN project.

## Set up

_Note: The following steps require that the user know how to use Git. In order to familiarize yourself with the Git tool check this [Git Guide](/git-guide/basic-guide)._

In order to work on the project, the user must first clone the repo.

`git clone https://github.com/sc-odin/docs.git`

Install Node.js (easiest way is through the [package](https://nodejs.org/en/)), then install docsify

`npm install -g docsify`

## Contributing

Before contributing, make sure that you are familiar with using Markdown. You can check our [Markdown TLDR](/contribution-guide/markdown-tldr) if you want to have a quick look at how to use this tool.

Additionally, make sure you are familiar with the [project structure](/contribution-guide/project-structure). In the guide, you will find in depth steps on how to contribute to the documentation while keeping the structure of the project. By following a given structure, the maintenance and upgrades of this website can be done with ease.

If you want to include UML diagrams into your modifications, it is also recommended you check our [Plant UML Guide](/contribution-guide/plant-uml)

In order to contribute, make sure your master is up to date

```bash
git checkout master
git pull origin master
```

Create your own branch that will contain your modifications. For `<nameOfBranch>`, you might want to name it `issueNumberYouWantToFix-context` i.e. `47-fix-git-formatting`.

```bash
git checkout -b <nameOfBranch>
```

In order to preview the changes made to the site, the user must run:

```bash
docsify serve <project>
```

Once the changes have been made, push them to your branch. Check our [Git Guide](/git-guide/good-practices) on good practices to ensure that your commit message follows the standard.

```bash
git add <files modified>
git commit -m "[#issueNumber] Verb + context"
git push -u origin <nameOfBranch>
```

Make a [pull request](https://github.com/spaceconcordia/sc-odin-docs/pulls) and assign a collaborator.