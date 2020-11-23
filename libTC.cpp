// https://pybind11.readthedocs.io/en/latest/basics.html
#include "Arduino.h"
#include "Devices/LiquidCrystal_TC.h"
#include "Devices/Serial_TC.h"
#include "TankControllerLib.h"
#include "extern/pybind11/include/pybind11/pybind11.h"
#include <string>
#include <vector>

namespace py = pybind11;
char lcdLine[20];

void setup() { TankControllerLib::instance()->setup(); }
void loop() { TankControllerLib::instance()->loop(); }
const char *version() { return TankControllerLib::instance()->version(); }
const char *lcd(int index) {
  std::vector<string> lines = LiquidCrystal_TC::instance()->getLines();
  string line = lines.at(index);
  int size = line.size();
  for (int i = 0; i < size; ++i) {
    if (line.at(i) < 32) {
      line.at(i) = '?';
    }
  }
  strncpy(lcdLine, line.c_str(), size);
  return lcdLine;
}

PYBIND11_MODULE(libTC, m) {
  m.doc() = "pybind11 example plugin"; // optional module docstring

  m.def("setup", &setup, "TankController setup");
  m.def("lcd", &lcd, "TankController LiquidCryrstal");
  m.def("loop", &loop, "TankController loop");
  m.def("version", &version, "TankController version");
}
