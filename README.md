# TankControllerGUI
A Python GUI for TankController running on the mocks provided by `Arduino CI`

## Build Process
The `Makefile` provides for making the following:
* `libtc.dylib` (on macOS) containing the following:
  * `Arduino CI` mocks (essentially the Arduino OS)
  * `TankControllerLib` (our library that can be called from a trivial sketch)
  * `TCLib.cpp` is a wrapper for the above files with standard `C` entry points (see `TCLib.h`) so it can be called from other applications (including Python)
* `testFoo` is built from `testFoo.cpp` to demonstrate using a shared library
* `example.*` is a start on a Python extension
  * `pybind11` is used to build the Python extension
