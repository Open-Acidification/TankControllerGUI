CC = g++ -std=c++17
DEFINES = -D__AVR__ -D__AVR_ATmega2560__ -DARDUINO_ARCH_AVR -DARDUINO_AVR_MEGA2560
HOME = /Users/jfoster
AR_PATH = $(HOME)/code/Arduino/arduino_ci/cpp/arduino
LIBRARIES = $(HOME)/Documents/Arduino/libraries
TC_PATH = ../libraries/TankControllerLib/src

tc-gui : libtc  
	echo "\n=====Compiling tc-gui demo!"
	$(CC) -o tc-gui \
	-I$(TC_PATH)		\
	-I$(AR_PATH) 		\
	-L. -ltc				\
	main.cpp

libtc : tcLibCPP
	echo "\n=====Compiling TC wrapper shared library"
	$(CC) -dynamiclib		\
	-o libtc.dylib			\
	-I$(TC_PATH) 				\
	-I$(AR_PATH) 				\
	*.o TCLib.cpp

tcLibCPP : arduino
	echo "\n=====Compiling TankControllerLib"
	$(CC) -c 													\
	$(DEFINES) 												\
	-I$(TC_PATH) 											\
	-I$(AR_PATH) 											\
	-I$(LIBRARIES)/LiquidCrystal/src	\
	$(TC_PATH)/*.cpp 									\
	$(TC_PATH)/Devices/*.cpp 					\
	$(TC_PATH)/UIState/*.cpp

arduino :
	echo "\n=====Compiling Arduino CI mocks"
	$(CC) -c 					\
	$(DEFINES) 				\
	-I$(AR_PATH) 			\
	$(AR_PATH)/*.cpp 

clean :
	rm *.o 2> /dev/null || true
