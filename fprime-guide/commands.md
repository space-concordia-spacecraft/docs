# 'fprime-util' Command

The fprime-util is a program designed to help developers run the standard development process by automating many of the standard functions built into the build system. It is intended to remove some of the inefficiencies using CMake while keeping the advantages of that build system.

```bash
usage: fprime-util [-h]
                   {generate,purge,build,impl,impl-ut,build-ut,check,check-leak,check-all,check-leak-all,install,build-all,hash-to-file}
                   ...

F prime helper application.

optional arguments:
  -h, --help            show this help message and exit

subcommands:
  F prime utility command line. Please run one of the commands. For help,
  run a command with the --help flag.

  {generate,purge,build,impl,impl-ut,build-ut,check,check-leak,check-all,check-leak-all,install,build-all,hash-to-file}
```

| Command | Description |
| ------- | ----------- |
| `fprime-util generate` | Generate an F prime build directory in the current directory. Must only be used once per project. |
| `fprime-util purge` | Purges nearest F prime build directory after confirmation. |
| `fprime-util build` | Builds the current directory. |
| `fprime-util build-ut` | Builds the unit tests. |
| `fprime-util impl` | Generates stubs (implementation templates) that the developer can fill in. |
| `fprime-util impl-ut` | Generates a set of template files for testing. |
| `fprime-util check` | Runs the unit tests. |
| `fprime-util check-leak` | Runs unit tests with memcheck for single component/deployment. |
| `fprime-util check-all` | Runs all unit tests for deployment. |
| `fprime-util check-leak-all` | Runs all unit tests with memcheck for component/deployment. |
| `fprime-util install` | Install to the configured directory for a deployment. |
| `fprime-util build-all` | Build the all target. |
| `fprime-util hash-to-file` | Converts F prime build hash to filename. |