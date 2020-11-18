#include "TCLib.h"
#include "TankControllerLib.h"

void tc_setup() { TankControllerLib::instance()->setup(); }
void tc_loop() { TankControllerLib::instance()->loop(); }
const char* tc_version() { return TankControllerLib::instance()->version(); }
