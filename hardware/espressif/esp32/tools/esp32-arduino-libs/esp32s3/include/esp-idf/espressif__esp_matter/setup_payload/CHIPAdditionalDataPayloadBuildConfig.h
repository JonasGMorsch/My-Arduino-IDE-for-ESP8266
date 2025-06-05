#pragma once

#include <sdkconfig.h>

#ifdef CONFIG_ENABLE_ROTATING_DEVICE_ID
#define CHIP_ENABLE_ROTATING_DEVICE_ID 1
#else
#define CHIP_ENABLE_ROTATING_DEVICE_ID 0
#endif
