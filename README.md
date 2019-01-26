# Ez Publish REST Bundle testing

*(BETA only tested with EZ Platform 1.7 and Kernel 6.7)*

This packages is for simplifying functional tests when contributing on *eZ Publish
 Kernel - REST Bundle*.
 
This will basically
1) Create a build of eZ Platform by the version specified in `bin/setup.sh`
2) Start the docker containers for testing
3) Run the functional tests with your current work on ezpublish-kernel

This is achieved by checking out ez platform and (sym-)linking your ezpublish-kernel working directory into `/build/ezsystems/ezplatform/vender/ezsystems/ezpublish-kernel`.

## How to setup

1) Checkout ezpublish-kernel and create a new branch to start working on a FIX, TASK, FEATURE.
2) Clone this repository into your working directory. `git clone https://github.com/RozbehSharahi/ezpublish-kernel-rest-functional-tests`
3) Edit `EZ_PLATFORM_VERSION` variable in `ezpublish-kernel-rest-functional-tests/bin/setup.sh` to an eZ Platform version that will require your branch or needs to be compatible.
4) Run `sh ezpublish-kernel-rest-functional-tests/bin/setup.sh` to build docker images.

## Running tests

When setup is done you can run the functional tests by:

`sh ezpublish-kernel-rest-functional-tests/bin/test.sh`

## Important notice

*The shell scripts in this repository works with relative paths to the `bin` directory. It does not matter how you name your directory in which this repository will be placed. Nevertheless it is important that the directory is directly placed inside of you ezpublish-kernel working directory !* 