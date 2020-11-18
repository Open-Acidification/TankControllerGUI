CC = g++ -std=c++17 -O3 
DEFINES = -D__AVR__ -D__AVR_ATmega2560__ -DARDUINO_ARCH_AVR -DARDUINO_AVR_MEGA2560
HOME = /Users/jfoster
ARDUINO = $(HOME)/code/Arduino/arduino_ci/cpp/arduino
LIBRARIES = $(HOME)/Documents/Arduino/libraries
TC_PATH = $(LIBRARIES)/TankControllerLib/src
PY_PATH = $(shell cd extern/pybind11; python3 -m pybind11 --includes)
SUFFIX = $(shell python3-config --extension-suffix)

all : tcLibPy # tc-gui

tcLibPy : tcLibCPP
	echo "\n=====Compiling Python Extension"
	$(CC) -shared -fPIC 							\
	example.cpp -o example$(SUFFIX) 	\
	-Wl,-undefined,dynamic_lookup 		\
	$(PY_PATH)

tc-gui : libtc  
	echo "\n=====Compiling tc-gui demo!"
	$(CC) -o tc-gui \
	-I$(TC_PATH)		\
	-I$(ARDUINO) 		\
	-L. -ltc				\
	main.cpp

libtc : tcLibCPP
	echo "\n=====Compiling TC wrapper shared library"
	$(CC) -dynamiclib		\
	-o libtc.dylib			\
	-I$(TC_PATH) 				\
	-I$(ARDUINO) 				\
	*.o TCLib.cpp

tcLibCPP : arduino
	echo "\n=====Compiling TankControllerLib"
	$(CC) -c 													\
	$(DEFINES) 												\
	-I$(TC_PATH) 											\
	-I$(ARDUINO) 											\
	-I$(LIBRARIES)/LiquidCrystal/src	\
	$(TC_PATH)/*.cpp 									\
	$(TC_PATH)/Devices/*.cpp 					\
	$(TC_PATH)/UIState/*.cpp

arduino :
	echo "\n=====Compiling Arduino CI mocks"
	$(CC) -c 					\
	$(DEFINES) 				\
	-I$(ARDUINO) 			\
	$(ARDUINO)/*.cpp 

clean :
	rm *.o 2> /dev/null || true
