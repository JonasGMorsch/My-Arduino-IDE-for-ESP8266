#pragma once

#include <sdkconfig.h>

#if defined(CONFIG_ENABLE_ESP_INSIGHTS_TRACE) && !defined(CONFIG_IDF_TARGET_ESP32H2)
#define MATTER_TRACING_ENABLED 1
#else
#define MATTER_TRACING_ENABLED 0
#endif
