CC = g++ -std=c++17 -O3 
DEFINES = -D__AVR__ -D__AVR_ATmega2560__ -DARDUINO_ARCH_AVR -DARDUINO_AVR_MEGA2560
HOME = /Users/jfoster
ifndef ARDUINO_CI
	ARDUINO_CI = $(HOME)/code/Arduino/arduino_ci/cpp/arduino
endif
ifndef LIBRARIES
	LIBRARIES = $(HOME)/Documents/Arduino/libraries
endif
TC_PATH = $(LIBRARIES)/TankControllerLib/src
PY_PATH = $(shell cd extern/pybind11; python3 -m pybind11 --includes)
SUFFIX = $(shell python3-config --extension-suffix)
PY_LIB = libTC$(SUFFIX)

.PHONY: all
all : $(PY_LIB)

$(PY_LIB) : TankControllerLib.o extern/pybind11/setup.py libTC.cpp
	echo "===== Compiling $(PY_LIB) =====" > /dev/null
	$(CC) -shared -fPIC 						\
	-Wl,-undefined,dynamic_lookup 	\
	$(PY_PATH)											\
	-I$(TC_PATH) 										\
	-I$(ARDUINO_CI) 								\
	libTC.cpp *.o -o $(PY_LIB)
	echo

TankControllerLib.o : Godmode.o
	echo "===== Compiling TankControllerLib =====" > /dev/null
	$(CC) -c 													\
	$(DEFINES) 												\
	-I$(TC_PATH) 											\
	-I$(ARDUINO_CI) 									\
	-I$(LIBRARIES)/LiquidCrystal/src	\
	$(TC_PATH)/*.cpp 									\
	$(TC_PATH)/Devices/*.cpp 					\
	$(TC_PATH)/UIState/*.cpp
	echo

Godmode.o :
	echo "===== Compiling Arduino CI mocks =====" > /dev/null
	$(CC) -c 					\
	$(DEFINES) 				\
	-I$(ARDUINO_CI) 	\
	$(ARDUINO_CI)/*.cpp 
	echo

extern/pybind11/setup.py : 
	echo "===== Install pybind11 =====" > /dev/null
	mkdir extern
	git submodule add ../../pybind/pybind11 extern/pybind11 -b stable
	git submodule update --init
	# install pytest
	python -m pip install pytest
	# install wx
	python -m pip install -U wxPython
	# build pybind11
	cd extern/pybind11
	mkdir build
	cd build
	cmake ..
	# compile and run tests
	make check -j 4
	echo

.PHONY: clean
clean :
	rm *.o *.so *.dylib $(PY_LIB) 2> /dev/null || echo
