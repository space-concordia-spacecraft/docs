# Project Structure

In order to allow the code of the documentation to be easy to manage and upgrade, we are following a certain structure. The documentation is separated into different major subjects, such as 'Fprime Guides' and 'Git Guides'. These major subjects are then separated into different discussion points. For example, under the 'Fprime Guides', you can find how to setup Fprime on Linux, different commands, etc.

For example, all fprime related guides are stored within a folder called `fprime-guide`. In this folder, you can find different topics such as, how to setup fprime on linux, a list of commands, etc. Make sure to keep your topics short and sweet, allowing the reader to not feel overwhelmed but also allowing developers to maneuver through the documents with more ease.

## Creating a subject

If you wish to create a subject, simply create a folder with a name that accurately describes whatever it is that you want to talk about. For example, all of the fprime guides are contained within the `fprime-guide` folder. 

Once the folder has been created, make sure you split the different discussions and topics you want to visit into different files. Once again, this allows the reader to not get overwhelmed with information and gives developers the ability to modify the files with more ease. For example, the setup for fprime on Linux, Windows and Mac are separated into three different files, each containing a different OS.

## Linking it to the rest of the project

Once you have added your modifications, if you want to link a file, modify the `_sidebar.md` file while following this structure.

```
**Subject**
	- [discussion](/subject/discussion)
```

For example:

```
- **Fprime Guides**
	- [Introduction](/fprime-guide/index)
	- [Linux Setup](/fprime-guide/setup-linux)
	- [Mac Setup](/fprime-guide/setup-mac)
	- [Windows Setup](/fprime-guide/setup-windows)
	- [Architecture](/fprime-guide/architecture)
	- ['fprime-util' Commands](/fprime-guide/commands.md)
	- [Build Examples](/fprime-guide/build-example)
```