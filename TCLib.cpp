#include "TCLib.h"
#include "TankControllerLib.h"

void tc_setup() { TankControllerLib::instance()->setup(); }
void tc_loop() { TankControllerLib::instance()->loop(); }
int tc_foo() { return TankControllerLib::instance()->foo(); }
