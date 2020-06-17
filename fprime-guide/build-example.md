## Building for Linux

Verify that you are in the `(fprime-venv)`

There is two ways you can build for your linux system

### Using F' Utility

#### Generate the Ref application

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>/Ref`
* `fprime-util generate` (it will fail if you've executed before in [Checking your F' Installation](https://github.com/laurentlaurent/Setting-Up-FPrime#checking-your-f-installation))

#### Generate the F' Framework

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>` (no Ref)
* `fprime-util generate`

#### Build Ref deployment

F' doc says that you almost always wants to run the install command on deployments. See the [install command section](https://github.com/laurentlaurent/Setting-Up-FPrime#install-command-f-utility).

* You should do [install](https://github.com/laurentlaurent/Setting-Up-FPrime#install-command-f-utility) instead, but the steps are outlined here for completeness
  * _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
  * `cd <path/to/fprime/checkout>/Ref`
  * `fprime-util build`

#### Generating Components and Deployments

Using the F' Utility tools, you can build a component or deployment using `cd fprime/<deployment>/<component>` and then `fprime-util build`.

Example of Build SignalGen Component

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>/Ref/SignalGen`
* `fprime-util build`

If you want to build a deployment, then use `cd <path/to/fprime/checkout>/deployment` then `fprime-util build` (just like in [Build Ref deployment](https://github.com/laurentlaurent/Setting-Up-FPrime#build-ref-deployment)).

### Using CMake

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>` (no Ref)
* `mkdir build-linux`
* `cd build-linux`
* `cmake ../Ref`
* `make`

## Building for BBB

Since we want to be able use the cross compile toolchain for the BBB/Arm, we need to generate its cmake

Read the following [README](https://github.com/nasa/fprime/tree/master/cmake) to understand what's going on in the following steps:

### Create 2 files

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* Navigate to `<path/to/fprime/checkout>/cmake/platform` and execute `touch bbb.cmake`
* Copy the `bbb.cmake` [file](https://github.com/laurentlaurent/Setting-Up-FPrime/blob/master/bbb.cmake) from this repo into the directory `<path/to/fprime/checkout>/cmake/toolchain`

Now, you can either choose to build with the F' Utility or CMake

### Using F' Utility for BBB

#### Generate a BBB Cross-Compile of the Ref Application

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>/Ref`
* `fprime-util generate bbb`

#### Example of Build SignalGen Component and Ref deployment

F' doc says that you almost always wants to run the install command on deployments. See the install command section.

* Example of building component
  * _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
  * `cd <path/to/fprime/checkout>/Ref/SignalGen`
  * `fprime-util build bbb`
* Example of building a deployment.
  * You might want to do [install](https://github.com/laurentlaurent/Setting-Up-FPrime#install-command-f-utility) instead, but the steps are outlined here for completeness
  * `cd <path/to/fprime/checkout>/Ref`
  * `fprime-util build bbb`

### Using CMake (INCOMPLETE)

* _Note:_ `<path/to/fprime/checkout>` is the path to your clone of the fprime repo
* `cd <path/to/fprime/checkout>` (no Ref)
* `mkdir build-cross`
* `cd build-cross`
* `cmake -DCMAKE_TOOLCHAIN_FILE=cmake/toolchain/bbb.cmake .` (The trailing period is important. It tells cmake to deploy the built binaries in the current directory)
* `make`

### Transfer to BBB (INCOMPLETE)

Use `ssh` or the integrated IDE (Cloud9) to transfer the binary created to the BBB. See here for how to do that

### Run on target

Using a terminal running on the BBB run the binary using `./<NAME_OF_BINARY>`

### Known issues

You may get a segmentation fault when running the binary on the BBB if this happens firstly make sure you have all the dependencies installed listed above and make sure there are no typos in the cmake files, recompile and try again.

### Next Steps

Need to setup communication between the BBB and our host computer so that we can run the ground station and send commands to the BBB through UART or something similar.

## Install Command (F' utility)

*(The rest is copy pasted from the F' [tutorial](https://github.com/nasa/fprime/blob/master/docs/Tutorials/GettingStarted/Tutorial.md#installing-the-f-executable-and-dictionaries), it is here for completeness.)*

<!-- Start of copy/paste from F' Tutorial -->
<!-- markdownlint-disable MD036 -->
Once the deployment is built, it would nice to be able to install the binary and dictionaries. This will enable the users to quickly find and run the deployment. This installation can be run using the following command. Everything will be installed to the directory defining the deployment. i.e. fprime/Ref/bin. Install will also invoke "build" so users should use this in-place of build for deployments.

**Installing the Ref Deployment and Running the Binary Assuming Linux**

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref
fprime-util install
./bin/Linux/Ref # Run the deployment
CTRL-C # Exit the application
```

Running the application as part of the development ground data system is shown below.

The user can also install a cross-compile.

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref
fprime-util install raspberrypi
```

## Creating Implementation Stubs

Once the build system is up and running, developers will desire to generate the stubbed implementations of the Component's C++
files. This can be done using the "impl" command of the F´ utility. These commands assume a default build has been generated.
They can be run passing in a toolchain, but this is typically not done because they are toolchain independent.

**Generating Implementation Stubs of SignalGen**

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref/SignalGen
fprime-util impl
```

This creates two files for the component. These are `<Component>Impl.cpp-template` and `<Component>Impl.hpp-template`.
The user can then rename these files to remove `-template`. The file is then ready for C++ development. By generating `-template` files, we won't accidentally overwrite any existing implementation.

## Creating Unit Test Implementations

Once the build system is up and running, developers will desire to generate the stubbed implementations and other files
needed for building UTs for a Component's C++. This can be done using the "impl" command of the F´ utility. These commands
assume a default build has been generated. They can be run passing in a toolchain, but this is typically not done because
they are toolchain independent.

**Generating Unit Test Stubs of SignalGen**

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref/SignalGen
fprime-util impl-ut
```

This creates the following files, that are typically moved to a sub folder called `test/ut`.  The files created are placed in the current directory and named:

```bash
Tester.cpp
Tester.hpp
GTestBase.cpp
GTestBase.hpp
TesterBase.cpp
TesterBase.hpp
TestMain.cpp
```

## Building and Running Unit Tests

Unit tests can be build using the the `build-ut` command of the `fprime-util`. This will allow us to build the unit tests
in preparation to run them.  The user can also just run "check" to build and run the unit tests.

**Building Unit Test of SignalGen**

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref/SignalGen
fprime-util build-ut
```

Once built, the unit test can be run using the following command.

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref/SignalGen
fprime-util check
```

The output of the unit test should be displayed in the console.

The user can also build the unit test, but must copy it to the hardware and run it here. This can be done with a cross-
compile by running the following commands.

**Cross-Compile Unit Test of SignalGen**

```bash
# Note: <path/to/fprime/checkout> is the path to your clone of the fprime repo
cd <path/to/fprime/checkout>/Ref/SignalGen
fprime-util build-ut raspberrypi
```

## Conclusion

The user should now be familiar with F´ terminology and with the `fprime-util` tool used to build and develop F´
applications. The next step is to follow the full `MathComponent` tutorial to create new *Ports*, *Components*, and *Topologies*. This will walk the user through the entire development process, using the tool commands we learned here.

**Next:** [Math Component Tutorial](https://github.com/nasa/fprime/blob/master/docs/Tutorials/MathComponent/Tutorial.md)
**Also See:** [GPS Component Tutorial](https://github.com/nasa/fprime/blob/master/docs/Tutorials/GpsTutorial/Tutorial.md) for a cross-compiling tutorial.

<!-- End of Copy/Paste from F' tutorial -->