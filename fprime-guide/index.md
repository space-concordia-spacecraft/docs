# Fprime Guide

_Note: This guide is a conglomerate of different guides provided in the [Fprime](https://github.com/nasa/fprime) repo. At the bottom of this page, there is a list of resources the user might find useful when working with Fprime._

The following guide will cover the installation, deployment and capabalities of Fprime. Fprime is a component-driven framework tailored to small-scale spaceflight systems such as CubeSats. This framework was created by NASA and allows for rapid development and deployment of spaceflight and other embedded software applications.

## Quick Installation Guide

_Note: If you wish to see a more in depth guide [click here](/fprime-guide/fprime-setup-linux)_

In order for this quick guide to work you must have a Linux or Max OS X operating system (or Windows Subsystem for Linux on Windows), [CMake](https://cmake.org/download/) available on the system path, Bash or Bash compatible shell, CLand or GCC compiler and [Python 3](https://www.python.org/downloads/) with PIP. It is also recommended for users to install Fprime python dependencies. The following commands are the most basics steps to setting up and running an example application on Fprime.

**Clone and Install**
```
git clone https://github.com/nasa/fprime.git
cd fprime
pip install Fw/Python Gds/
```
**Build the Ref Application**
```
cd Ref
fprime-util generate
fprime-util install
```
**Run the Ref Application**
```
./bin/*/Ref
...
CTRL-C
```

## Resources

- [PowerPoint About Fprime Framework](https://github.com/nasa/fprime/blob/master/docs/Architecture/FPrimeSoftwareArchitecture.pdf)
- [Original User's Guide](https://github.com/nasa/fprime/blob/master/docs/UsersGuide/FprimeUserGuide.pdf)