// https://pybind11.readthedocs.io/en/latest/basics.html
#include "Arduino.h"
#include "Devices/LiquidCrystal_TC.h"
#include "Devices/Serial_TC.h"
#include "TankControllerLib.h"
#include "extern/pybind11/include/pybind11/pybind11.h"

namespace py = pybind11;

void setup() { TankControllerLib::instance()->setup(); }
void loop() { TankControllerLib::instance()->loop(); }
const char *version() { return TankControllerLib::instance()->version(); }

PYBIND11_MODULE(libTC, m) {
  m.doc() = "pybind11 example plugin"; // optional module docstring

  m.def("setup", &setup, "TankController setup");
  m.def("loop", &loop, "TankController loop");
  m.def("version", &version, "TankController version");
}
