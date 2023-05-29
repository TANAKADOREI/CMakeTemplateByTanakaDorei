# CMakeTemplateByTanakaDorei

This is a project that I made because I felt uncomfortable using cmake myself. Our goal is to easily build a development environment with a single file.

# Setup

## Step1. Run `CMakeTemplateByTanakaDorei.cmake`

Run `cmake -P CMakeTemplateByTanakaDorei.cmake` command!

## Step2. Generated Base File Description

`CMakeConstants.cmake` : A file in which constant data is stored.

`CMakeDependencies.cmake` : This is the file that sets the dependencies. Just use the `add_dependencies` command and your own project name.

`CMakeGlobalOptions.cmake` : This is the global setting of `CMakeTemplateByTanakaDorei.cmake`. These are variables that are affected when the `CMakeTemplateByTanakaDorei.cmake` file runs, so please use them carefully.

`CMakeLists.txt` : This is the root `CMakeLists.txt` file. please don't edit

`CMakePresets.cmake` : This file is executed before the `project()` command in the root `CMakeLists.txt`. For example, setting the toolchain path. Script for cases where `CMakePresets.json` cannot be used or for special cases

`CMakeProjects.cmake` : project registration

`CMakePresets.json` : We do not create and manage `CMakePresets.json` file, but we recommend that you create and use it yourself.

------

When sharing a project using the template, you must add files that may contain personal information to `.gitignore`.

## Setup3. Special directory path and name

`*/cmk` : Among the variables of `CMakeLists.txt` in your project, the name of a variable containing `CMAKESCRIPTS` or `CT_PROJECT_BUILD_SCRIPTS` is searched in the directory of `<root>/CMakeGlobals/src/` first, and if not found, `<your project path>/cmk/` Here is the flow you are looking for. Therefore, you should write a relative path assuming that the path of the script is always prefixed with `*/cmk/`.

`*/src` : The directory referenced by the `CT_PROJECT_CODEFILES` variable in the project `CMakeLists.txt`. When writing the source code path in `CT_PROJECT_CODEFILES`, you can write it thinking that `<your project path>/src/` is attached in front of the path.

`<your project path>/res` : No processing. To separate from the source code, such as copying the `res` directory from the project `CMakeLists.txt`

`<root>/CMakeGlobals/inj` : `CMakeTemplateByTanakaDorei.cmake` is ready and includes the scripts in that directory. (include())

## Step3. finally

All cmakescript files are commented out. Hope this helps. Since I'm not good at English, everyone uses a translator, so it may be an awkward English sentence.
