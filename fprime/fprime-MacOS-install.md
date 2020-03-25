# F ' Install for MacOS

This guide aims to enable users to install F ' directly on their Mac without the use of VirtualBox

## Before getting started

In order to install the system dependencies needed to run F ', we will be making use of a brilliant tool called Homebrew. To install Homebrew, open up terminal and follow [these steps](https://docs.laurentlao.com/#/mac/setting-mac-terminal?id=installing-brew).


Next we need to install [Git](https://docs.laurentlao.com/#/mac/setting-mac-terminal?id=installing-git).

## Installing system dependencies

### Cloning the repo

* `git clone https://github.com/nasa/fprime`

The path to your copy of the repo will be refered to, in this guide, as /your/path/to/fprime. 

By default, the file should be copied under /Users/yourcurrentuser/fprime. For the sake of simplicity, it is possible to copy the pathname of your file by right clicking on your file and holding the option key to reveal the “Copy (item name) as Pathname” option, and paste it as needed.


### Installing Python 3 and pip

* `brew install python3`
*`brew upgrade python3`
* Verify Python 3 installation `python3 -V`
*`python3 -m pip install pip --upgrade`
*`python3 -m pip install pipenv`
* Verify pip installation `pipenv`


### Installing CMake

* `brew install cmake`

### Creating and Activating a Virtual Environment
* `python3 -m venv ./fprime-venv`
* To activate the virtual environment, execute  `. ./fprime-venv/bin/activate` Your terminal should now show `(fprime-venv)`

### Installing F ' Python Packages

**Reminder:** `/your/path/to/fprime` refers to the path of your clone of the fprime repo, replace it with your actual pathname

* `cd /your/path/to/fprime`
* `pip install ./Fw/Python`
* `pip install ./Gds`

### Checking Your F ' Installation

* `cd Ref`
* `fprime-util generate`
* `fprime-util build --jobs 32`
* `fprime-util install --jobs 32`
* Return to the parent folder of the Fprime repo using `cd` and run `fprime-gds -g html -d /your/path/to/fprime/Ref`

**Note:** Make sure to add `/Ref/` after your pathname.
