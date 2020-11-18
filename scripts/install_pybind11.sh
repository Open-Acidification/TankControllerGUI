#! bash
# run from TankControllerGUI using ./scripts/install_pybind11.sh
mkdir extern
git submodule add ../../pybind/pybind11 extern/pybind11 -b stable
git submodule update --init
# install pytest
python -m pip install pytest
# build pybind11
cd extern/pybind11
mkdir build
cd build
cmake ..
# compile and run tests
make check -j 4
