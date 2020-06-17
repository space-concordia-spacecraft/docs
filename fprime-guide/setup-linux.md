# Setting Up Fprime

_Note: If you are a [Windows](/fprime-guide/fprime-setup-windows) user, or a [Mac OS](/fprime-guide/fprime-setup-mac) user, you should click on the respective operating system and follow that guide instead._

The following guide explains how to set up Fprime for a linux operating system. It will cover how to install the system dependencies and how to check the installation.

## Installing System Dependencies

### Cloning the repo

* `apt update` (it should ask you for your sudo password. If it doesn't, append `sudo` at the start of the command to resolve the permission errors. (e.g. `sudo apt update`))
* `apt install git`
* `git clone https://github.com/sc-odin/fprime.git` (that's our fork of the fprime)
  * for NASA's : `git clone https://github.com/nasa/fprime`
* The path of your copy of your repo will henceforth be referred to as `<path/to/fprime/checkout>`

### Installing PIP for Python 3

* `sudo apt install python3-pip`

### Create a Virtual environment

* `sudo apt install python3-venv`
* Then run `python3 -m venv ./fprime-venv` (preferably in the same parent folder that contains the F' repo)
* You can now execute `. ./fprime-venv/bin/activate` to go into the virtual environment
  * You might want to copy the `venv.sh` [file](https://github.com/laurentlaurent/Setting-Up-FPrime/blob/master/venv.sh) available in this repo in the same folder as your `fprime-venv` to make it easier to launch the virtual environment
  * If you do so, make sure to `chmod +x venv.sh`
  * Then you'll be able to switch to the fprime-venv using `. ./venv.sh`
* When you're switched, your terminal should show `(fprime-venv)`

_Note: Any time the user wishes to use Fprime, this virtual environment should be activated. This should be done in each new shell the user uses._

### Installing other dependencies

From here on out, you should be on the fprime-venv unless otherwise specified.

FPrime has a script that will install other ubuntu packages for you

* `sudo ./fprime/mk/os-pkg/ubuntu-packages.sh`

Now see if you have the rest of the dependencies

* `which gcc`
  * if that command displays something like `/usr/bin/gcc`, then (optional) do `apt upgrade gcc`
    * else do `apt install gcc`
* `which g++`
  * if that command displays something like `/usr/bin/g++`, then (optional) do `apt upgrade g++`
    * else do `apt install g++`
* `which cmake`
  * if that command displays something like `usr/bin/cmake`, then (optional) do `apt upgrade cmake`
    * else do `apt install cmake`
* Also install:
  * `pip3 install numpy`
  * `pip3 install pytest`
  * `pip3 install wheel`
  * `pip3 install -r fprime/mk/python/pip_required_build3.py` (run this on the parent folder of the fprime repo)

### Installing the Arm toolchain compilers

* `apt install gcc-arm-linux-gnueabihf`
* `apt install g++-arm-linux-gnueabihf`

### Install Fprime Python Requirements

_Note: `<path/to/fprime/checkout>` is the path to your clone of the fprime repo._

* Go to the fprime repo folder: `cd <path/to/fprime/checkout>`
* `pip3 install ./Fw/Python`
* `pip3 install ./Gds`

## Checking your Fprime Installation

_Note: `<path/to/fprime/checkout>` is the path to your clone of the fprime repo._

Now you should be done with installing dependencies. Check your installation with these commands.

* `cd Ref` (you should be in `./fprime/Ref` after)
* `fprime-util generate` should return no error
* `fprime-util build --jobs 32` should return no error (it looks really cool)
* `fprime-util install --jobs 32` should return no error (it looks really cool)
* Go back to the parent folder of the `fprime repo`
* Run `fprime-gds -g html -d <path/to/fprime/checkout>/Ref` (this won't work if you have not done all 3 of the generate, build and install before)