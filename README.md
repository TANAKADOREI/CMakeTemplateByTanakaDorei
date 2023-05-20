# CMakeTemplateByTanakaDorei

Comments are written in the file, so please follow the setup process below and go to the file for detailed explanation and check the comments.

# Setup

## Step1. Run `CMakeTemplateByTanakaDorei.cmake`

Specify a working directory, place the `CMakeTemplateByTanakaDorei.cmake` script in that location, and execute the `cmake -P CMakeTemplateByTanakaDorei.cmake` command.

## Step2. Generated Base File Description

`CMakeENVSettings.cmake` is a file related to the environment to run cmake on.

`CMakeLists.txt` is the root cmake file.

`CMakeProjects.cmake` is the project registry. Please note that only the project name written here can exist, and when the project name is removed, the related directory is also removed.

`CMakeRoot.cmake` is a file where constant data is stored and also includes global variables. Detailed global settings can be found here

`CMakeRootListsExecutor.cmake` is a delegate to run cmake if you are not using an IDE.

## Step3. Simple usage

Register the project in `CMakeProjects.cmake` and configure Cmake.

Project directories prefixed with `CTP_` are created, and an error is generated.
The reason is that the data of `CMakeLists.txt` in the project directory was not completely written, so the problem occurred, so you don't have to worry. go ahead and fill out
