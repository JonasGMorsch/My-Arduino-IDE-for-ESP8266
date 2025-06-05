/* Automatically generated file; DO NOT EDIT */
/* Espressif IoT Development Framework Linker Script */
/* Generated from: /home/runner/work/esp32-arduino-lib-builder/esp32-arduino-lib-builder/build/esp-idf/esp_system/ld/sections.ld.in */

/*
 * SPDX-FileCopyrightText: 2021 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/*
 * SPDX-FileCopyrightText: 2021-2024 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */
/*
 * Automatically generated file. DO NOT EDIT.
 * Espressif IoT Development Framework (ESP-IDF) 5.4.1 Configuration Header
 */
       
/* List of deprecated options */
/* CPU instruction prefetch padding size for flash mmap scenario */
/*
 * PMP region granularity size
 * Software may determine the PMP granularity by writing zero to pmp0cfg, then writing all ones
 * to pmpaddr0, then reading back pmpaddr0. If G is the index of the least-significant bit set,
 * the PMP granularity is 2^G+2 bytes.
 */
/* CPU instruction prefetch padding size for memory protection scenario */
/* Memory alignment size for PMS */
    /* rtc timer data (s_rtc_timer_retain_mem, see esp_clk.c files). For rtc_timer_data_in_rtc_mem section. */
/* Default entry point */
ENTRY(call_start_cpu0);
SECTIONS
{
  /**
   * RTC fast memory holds RTC wake stub code,
   * including from any source file named rtc_wake_stub*.c
   */
  .rtc.text :
  {
    
 . = ALIGN(4); 
 _rtc_text_start = ABSOLUTE(.);
    *(.rtc.literal .rtc.text .rtc.text.*)
    *rtc_wake_stub*.*(.literal .text .literal.* .text.*)
    _rtc_text_end = ABSOLUTE(.);
  } > rtc_iram_seg
  /**
   * This section is required to skip rtc.text area because rtc_iram_seg and
   * rtc_data_seg are reflect the same address space on different buses.
   */
  .rtc.dummy :
  {
    _rtc_dummy_start = ABSOLUTE(.);
    _rtc_fast_start = ABSOLUTE(.);
    . = SIZEOF(.rtc.text);
    _rtc_dummy_end = ABSOLUTE(.);
  } > rtc_data_seg
  /**
   * This section located in RTC FAST Memory area.
   * It holds data marked with RTC_FAST_ATTR attribute.
   * See the file "esp_attr.h" for more information.
   */
  .rtc.force_fast :
  {
    
 . = ALIGN(4); 
 _rtc_force_fast_start = ABSOLUTE(.);
    _coredump_rtc_fast_start = ABSOLUTE(.);
    *(.rtc.fast.coredump .rtc.fast.coredump.*)
    _coredump_rtc_fast_end = ABSOLUTE(.);
    *(.rtc.force_fast .rtc.force_fast.*)
    
 . = ALIGN(4); 
 _rtc_force_fast_end = ABSOLUTE(.);
  } > rtc_data_seg
  /**
   * RTC data section holds RTC wake stub
   * data/rodata, including from any source file
   * named rtc_wake_stub*.c and the data marked with
   * RTC_DATA_ATTR, RTC_RODATA_ATTR attributes.
   * The memory location of the data is dependent on
   * CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
   */
  .rtc.data :
  {
    _rtc_data_start = ABSOLUTE(.);
    _coredump_rtc_start = ABSOLUTE(.);
    *(.rtc.coredump .rtc.coredump.*)
    _coredump_rtc_end = ABSOLUTE(.);
    *(.rtc.data .rtc.data.*)
    *(.rtc.rodata .rtc.rodata.*)
    *rtc_wake_stub*.*(.data .rodata .data.* .rodata.*)
    _rtc_data_end = ABSOLUTE(.);
  } > rtc_data_location
  /* RTC bss, from any source file named rtc_wake_stub*.c */
  .rtc.bss (NOLOAD) :
  {
    _rtc_bss_start = ABSOLUTE(.);
    *rtc_wake_stub*.*(.bss .bss.*)
    *rtc_wake_stub*.*(COMMON)
    *(.rtc.bss)
    _rtc_bss_end = ABSOLUTE(.);
  } > rtc_data_location
  /**
   * This section holds data that should not be initialized at power up
   * and will be retained during deep sleep.
   * User data marked with RTC_NOINIT_ATTR will be placed
   * into this section. See the file "esp_attr.h" for more information.
   * The memory location of the data is dependent on
   * CONFIG_ESP32_RTCDATA_IN_FAST_MEM option.
   */
  .rtc_noinit (NOLOAD):
  {
    
 . = ALIGN(4); 
 _rtc_noinit_start = ABSOLUTE(.);
    *(.rtc_noinit .rtc_noinit.*)
    
 . = ALIGN(4); 
 _rtc_noinit_end = ABSOLUTE(.);
  } > rtc_data_location
  /**
   * This section located in RTC SLOW Memory area.
   * It holds data marked with RTC_SLOW_ATTR attribute.
   * See the file "esp_attr.h" for more information.
   */
  .rtc.force_slow :
  {
    
 . = ALIGN(4); 
 _rtc_force_slow_start = ABSOLUTE(.);
    *(.rtc.force_slow .rtc.force_slow.*)
    
 . = ALIGN(4); 
 _rtc_force_slow_end = ABSOLUTE(.);
  } > rtc_slow_seg
  /**
   * This section holds RTC FAST data that should have fixed addresses.
   * The data are not initialized at power-up and are retained during deep
   * sleep.
   */
  .rtc_fast_reserved (NOLOAD):
  {
    
 . = ALIGN(4); 
 _rtc_fast_reserved_start = ABSOLUTE(.);
    /**
     * New data can only be added here to ensure existing data are not moved.
     * Because data have adhered to the end of the segment and code is relied
     * on it.
     * >> put new data here <<
     */
    KEEP(*(.bootloader_data_rtc_mem .bootloader_data_rtc_mem.*))
    _rtc_fast_reserved_end = ABSOLUTE(.);
  } > rtc_fast_reserved_seg
  _rtc_fast_reserved_length = _rtc_fast_reserved_end - _rtc_fast_reserved_start;
  ASSERT((_rtc_fast_reserved_length <= LENGTH(rtc_fast_reserved_seg)),
          "RTC FAST reserved segment data does not fit.")
  /**
   * This section holds RTC SLOW data that should have fixed addresses.
   * The data are not initialized at power-up and are retained during deep
   * sleep.
   */
  .rtc_slow_reserved (NOLOAD):
  {
    
 . = ALIGN(4); 
 _rtc_slow_reserved_start = ABSOLUTE(.);
    /**
     * New data can only be added here to ensure existing data are not moved.
     * Because data have adhered to the end of the segment and code is relied
     * on it.
     * >> put new data here <<
     */
    *(.rtc_timer_data_in_rtc_mem .rtc_timer_data_in_rtc_mem.*)
    _rtc_slow_reserved_end = ABSOLUTE(.);
  } > rtc_slow_reserved_seg
  _rtc_slow_reserved_length = _rtc_slow_reserved_end - _rtc_slow_reserved_start;
  _rtc_reserved_length = _rtc_slow_reserved_length;
  ASSERT((_rtc_slow_reserved_length <= LENGTH(rtc_slow_reserved_seg)),
          "RTC SLOW reserved segment data does not fit.")
  /* Get size of rtc slow data based on rtc_data_location alias */
  _rtc_slow_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_slow_end - _rtc_data_start)
                        : (_rtc_force_slow_end - _rtc_force_slow_start);
  _rtc_fast_length = (ORIGIN(rtc_slow_seg) == ORIGIN(rtc_data_location))
                        ? (_rtc_force_fast_end - _rtc_fast_start)
                        : (_rtc_noinit_end - _rtc_fast_start);
  ASSERT((_rtc_slow_length <= LENGTH(rtc_slow_seg)),
          "RTC_SLOW segment data does not fit.")
  ASSERT((_rtc_fast_length <= LENGTH(rtc_data_seg)),
          "RTC_FAST segment data does not fit.")
  /* Send .iram0 code to iram */
  .iram0.vectors :
  {
    _iram_start = ABSOLUTE(.);
    /* Vectors go to IRAM */
    _vector_table = ABSOLUTE(.);
    . = 0x0;
    KEEP(*(.WindowVectors.text));
    . = 0x180;
    KEEP(*(.Level2InterruptVector.text));
    . = 0x1c0;
    KEEP(*(.Level3InterruptVector.text));
    . = 0x200;
    KEEP(*(.Level4InterruptVector.text));
    . = 0x240;
    KEEP(*(.Level5InterruptVector.text));
    . = 0x280;
    KEEP(*(.DebugExceptionVector.text));
    . = 0x2c0;
    KEEP(*(.NMIExceptionVector.text));
    . = 0x300;
    KEEP(*(.KernelExceptionVector.text));
    . = 0x340;
    KEEP(*(.UserExceptionVector.text));
    . = 0x3C0;
    KEEP(*(.DoubleExceptionVector.text));
    . = 0x400;
    _invalid_pc_placeholder = ABSOLUTE(.);
    *(.*Vector.literal)
    *(.UserEnter.literal);
    *(.UserEnter.text);
    . = ALIGN (16);
    *(.entry.literal)
    *(.entry.text)
    *(.init.literal)
    *(.init)
    _init_end = ABSOLUTE(.);
  } > iram0_0_seg
  .iram0.text :
  {
    /* Code marked as running out of IRAM */
    _iram_text_start = ABSOLUTE(.);
    *(.iram1 .iram1.*)
    *libapp_trace.a:app_trace.*(.literal .literal.* .text .text.*)
    *libapp_trace.a:app_trace_util.*(.literal .literal.* .text .text.*)
    *libapp_trace.a:port_uart.*(.literal .literal.* .text .text.*)
    *libc.a:creat.*(.literal .literal.* .text .text.*)
    *libc.a:isatty.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-abs.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-asctime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-asctime_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-atoi.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-atol.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-bzero.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-close.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-creat.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ctime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ctime_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ctype_.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-div.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-environ.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-envlock.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-fclose.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-fflush.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-findfp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-fputwc.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-fvwrite.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-fwalk.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-getenv_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-gettzinfo.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-gmtime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-gmtime_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-impure.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isalnum.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isalpha.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isascii.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isblank.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-iscntrl.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isdigit.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isgraph.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-islower.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isprint.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ispunct.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isspace.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-isupper.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-itoa.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-labs.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-lcltime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-lcltime_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ldiv.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-longjmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-makebuf.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memccpy.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memchr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memcmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memcpy.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memmove.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memrchr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-memset.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-mktime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-month_lengths.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-open.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-quorem.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-raise.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-rand.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-rand_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-read.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-refill.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-rshift.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-s_fpclassify.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sbrk.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sccl.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-setjmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sf_nan.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-srand.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-stdio.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcasecmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcasestr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcat.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strchr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcoll.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcpy.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strcspn.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strdup.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strdup_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strftime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strlcat.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strlcpy.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strlen.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strlwr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strncasecmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strncat.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strncmp.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strncpy.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strndup.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strndup_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strnlen.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strptime.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strrchr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strsep.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strspn.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strstr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strtok_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strtol.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strtoul.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-strupr.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sysclose.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sysopen.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-sysread.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-syssbrk.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-system.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-systimes.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-syswrite.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-time.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-timelocal.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-toascii.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tolower.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-toupper.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tzcalc_limits.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tzlock.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tzset.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tzset_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-tzvars.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-ungetc.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-utoa.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-wbuf.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-wcrtomb.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-wctomb_r.*(.literal .literal.* .text .text.*)
    *libc.a:libc_a-wsetup.*(.literal .literal.* .text .text.*)
    *libc.a:lock.*(.literal .literal.* .text .text.*)
    *libesp_driver_gptimer.a:gptimer.*(.literal.gptimer_default_isr .text.gptimer_default_isr)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_isr_post .text.esp_event_isr_post)
    *libesp_event.a:esp_event.*(.literal.esp_event_isr_post_to .text.esp_event_isr_post_to)
    *libesp_hw_support.a:clk_utils.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:cpu.*(.literal.esp_cpu_compare_and_set .text.esp_cpu_compare_and_set)
    *libesp_hw_support.a:cpu.*(.literal.esp_cpu_reset .text.esp_cpu_reset)
    *libesp_hw_support.a:cpu.*(.literal.esp_cpu_stall .text.esp_cpu_stall)
    *libesp_hw_support.a:cpu.*(.literal.esp_cpu_unstall .text.esp_cpu_unstall)
    *libesp_hw_support.a:cpu.*(.literal.esp_cpu_wait_for_intr .text.esp_cpu_wait_for_intr)
    *libesp_hw_support.a:esp_memory_utils.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:mspi_timing_tuning.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:rtc_clk.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:rtc_init.*(.literal.rtc_vddsdio_get_config .text.rtc_vddsdio_get_config)
    *libesp_hw_support.a:rtc_init.*(.literal.rtc_vddsdio_set_config .text.rtc_vddsdio_set_config)
    *libesp_hw_support.a:rtc_sleep.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:rtc_time.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:rtc_wdt.*(.literal .literal.* .text .text.*)
    *libesp_hw_support.a:sar_periph_ctrl.*(.literal.sar_periph_ctrl_power_enable .text.sar_periph_ctrl_power_enable)
    *libesp_mm.a:cache_esp32.*(.literal .literal.* .text .text.*)
    *libesp_mm.a:esp_cache.*(.literal .literal.* .text .text.*)
    *libesp_ringbuf.a:(.literal .literal.* .text .text.*)
    *libesp_rom.a:esp_rom_print.*(.literal .literal.* .text .text.*)
    *libesp_rom.a:esp_rom_spiflash.*(.literal .literal.* .text .text.*)
    *libesp_rom.a:esp_rom_sys.*(.literal .literal.* .text .text.*)
    *libesp_system.a:esp_err.*(.literal .literal.* .text .text.*)
    *libesp_system.a:esp_system_chip.*(.literal.esp_system_abort .text.esp_system_abort)
    *libesp_system.a:image_process.*(.literal .literal.* .text .text.*)
    *libesp_system.a:ubsan.*(.literal .literal.* .text .text.*)
    *libfreertos.a:(EXCLUDE_FILE(*libfreertos.a:app_startup.* *libfreertos.a:freertos_compatibility.* *libfreertos.a:idf_additions.* *libfreertos.a:tasks.*) .literal EXCLUDE_FILE(*libfreertos.a:app_startup.* *libfreertos.a:freertos_compatibility.* *libfreertos.a:idf_additions.* *libfreertos.a:tasks.*) .literal.* EXCLUDE_FILE(*libfreertos.a:app_startup.* *libfreertos.a:freertos_compatibility.* *libfreertos.a:idf_additions.* *libfreertos.a:tasks.*) .text EXCLUDE_FILE(*libfreertos.a:app_startup.* *libfreertos.a:freertos_compatibility.* *libfreertos.a:idf_additions.* *libfreertos.a:tasks.*) .text.*)
    *libfreertos.a:tasks.*(.literal.__getreent .literal.eTaskGetState .literal.pcTaskGetName .literal.prvAddCurrentTaskToDelayedList .literal.prvAddNewTaskToReadyList .literal.prvCheckTaskCanBeScheduledSMP .literal.prvDeleteTCB .literal.prvIdleTask .literal.prvInitialiseNewTask$constprop$0 .literal.prvIsYieldRequiredSMP .literal.prvListTasksWithinSingleList .literal.prvReleaseKernelLock .literal.prvResetNextTaskUnblockTime .literal.prvSearchForNameWithinSingleList .literal.prvTakeKernelLock .literal.prvTaskCreateDynamicPinnedToCoreWithCaps .literal.prvTaskPriorityRaise .literal.prvTaskPriorityRestore .literal.prvWriteNameToBuffer .literal.pvTaskGetCurrentTCBForCore .literal.pvTaskGetThreadLocalStoragePointer .literal.pvTaskIncrementMutexHeldCount .literal.pxTaskGetStackStart .literal.ulTaskGenericNotifyTake .literal.ulTaskGenericNotifyValueClear .literal.ulTaskGetIdleRunTimeCounter .literal.ulTaskGetIdleRunTimeCounterForCore .literal.ulTaskGetIdleRunTimePercent .literal.ulTaskGetIdleRunTimePercentForCore .literal.uxTaskGetNumberOfTasks .literal.uxTaskGetStackHighWaterMark .literal.uxTaskGetStackHighWaterMark2 .literal.uxTaskGetSystemState .literal.uxTaskPriorityGet .literal.uxTaskPriorityGetFromISR .literal.uxTaskResetEventItemValue .literal.vTaskDelay .literal.vTaskDelete .literal.vTaskEndScheduler .literal.vTaskGenericNotifyGiveFromISR .literal.vTaskGetInfo .literal.vTaskGetRunTimeStats .literal.vTaskGetSnapshot .literal.vTaskInternalSetTimeOutState .literal.vTaskList .literal.vTaskMissedYield .literal.vTaskPlaceOnEventList .literal.vTaskPlaceOnEventListRestricted .literal.vTaskPlaceOnUnorderedEventList .literal.vTaskPriorityDisinheritAfterTimeout .literal.vTaskPrioritySet .literal.vTaskRemoveFromUnorderedEventList .literal.vTaskResume .literal.vTaskSetThreadLocalStoragePointer .literal.vTaskSetThreadLocalStoragePointerAndDelCallback .literal.vTaskSetTimeOutState .literal.vTaskStartScheduler .literal.vTaskSuspend .literal.vTaskSuspendAll .literal.vTaskSwitchContext .literal.xTaskAbortDelay .literal.xTaskCatchUpTicks .literal.xTaskCheckForTimeOut .literal.xTaskCreatePinnedToCore .literal.xTaskCreateStaticPinnedToCore .literal.xTaskDelayUntil .literal.xTaskGenericNotify .literal.xTaskGenericNotifyFromISR .literal.xTaskGenericNotifyStateClear .literal.xTaskGenericNotifyWait .literal.xTaskGetCoreID .literal.xTaskGetCurrentTaskHandle .literal.xTaskGetCurrentTaskHandleForCore .literal.xTaskGetHandle .literal.xTaskGetIdleTaskHandle .literal.xTaskGetIdleTaskHandleForCore .literal.xTaskGetSchedulerState .literal.xTaskGetStaticBuffers .literal.xTaskGetTickCount .literal.xTaskGetTickCountFromISR .literal.xTaskIncrementTick .literal.xTaskIncrementTickOtherCores .literal.xTaskPriorityDisinherit .literal.xTaskPriorityInherit .literal.xTaskRemoveFromEventList .literal.xTaskResumeAll .literal.xTaskResumeFromISR .text .text.__getreent .text.eTaskGetState .text.pcTaskGetName .text.prvAddCurrentTaskToDelayedList .text.prvAddNewTaskToReadyList .text.prvCheckTaskCanBeScheduledSMP .text.prvDeleteTCB .text.prvIdleTask .text.prvInitialiseNewTask$constprop$0 .text.prvIsYieldRequiredSMP .text.prvListTasksWithinSingleList .text.prvReleaseKernelLock .text.prvResetNextTaskUnblockTime .text.prvSearchForNameWithinSingleList .text.prvTakeKernelLock .text.prvTaskCreateDynamicPinnedToCoreWithCaps .text.prvTaskPriorityRaise .text.prvTaskPriorityRestore .text.prvWriteNameToBuffer .text.pvTaskGetCurrentTCBForCore .text.pvTaskGetThreadLocalStoragePointer .text.pvTaskIncrementMutexHeldCount .text.pxTaskGetStackStart .text.ulTaskGenericNotifyTake .text.ulTaskGenericNotifyValueClear .text.ulTaskGetIdleRunTimeCounter .text.ulTaskGetIdleRunTimeCounterForCore .text.ulTaskGetIdleRunTimePercent .text.ulTaskGetIdleRunTimePercentForCore .text.uxTaskGetNumberOfTasks .text.uxTaskGetStackHighWaterMark .text.uxTaskGetStackHighWaterMark2 .text.uxTaskGetSystemState .text.uxTaskGetTaskNumber .text.uxTaskPriorityGet .text.uxTaskPriorityGetFromISR .text.uxTaskResetEventItemValue .text.vTaskDelay .text.vTaskDelete .text.vTaskEndScheduler .text.vTaskGenericNotifyGiveFromISR .text.vTaskGetInfo .text.vTaskGetRunTimeStats .text.vTaskGetSnapshot .text.vTaskInternalSetTimeOutState .text.vTaskList .text.vTaskMissedYield .text.vTaskPlaceOnEventList .text.vTaskPlaceOnEventListRestricted .text.vTaskPlaceOnUnorderedEventList .text.vTaskPriorityDisinheritAfterTimeout .text.vTaskPrioritySet .text.vTaskRemoveFromUnorderedEventList .text.vTaskResume .text.vTaskSetTaskNumber .text.vTaskSetThreadLocalStoragePointer .text.vTaskSetThreadLocalStoragePointerAndDelCallback .text.vTaskSetTimeOutState .text.vTaskStartScheduler .text.vTaskSuspend .text.vTaskSuspendAll .text.vTaskSwitchContext .text.xTaskAbortDelay .text.xTaskCatchUpTicks .text.xTaskCheckForTimeOut .text.xTaskCreatePinnedToCore .text.xTaskCreateStaticPinnedToCore .text.xTaskDelayUntil .text.xTaskGenericNotify .text.xTaskGenericNotifyFromISR .text.xTaskGenericNotifyStateClear .text.xTaskGenericNotifyWait .text.xTaskGetCoreID .text.xTaskGetCurrentTaskHandle .text.xTaskGetCurrentTaskHandleForCore .text.xTaskGetHandle .text.xTaskGetIdleTaskHandle .text.xTaskGetIdleTaskHandleForCore .text.xTaskGetSchedulerState .text.xTaskGetStaticBuffers .text.xTaskGetTickCount .text.xTaskGetTickCountFromISR .text.xTaskIncrementTick .text.xTaskIncrementTickOtherCores .text.xTaskPriorityDisinherit .text.xTaskPriorityInherit .text.xTaskRemoveFromEventList .text.xTaskResumeAll .text.xTaskResumeFromISR .text.xTimerCreateTimerTask)
    *libgcc.a:lib2funcs.*(.literal .literal.* .text .text.*)
    *libgcov.a:(.literal .literal.* .text .text.*)
    *libhal.a:cache_hal_esp32.*(.literal .literal.* .text .text.*)
    *libhal.a:gpio_hal.*(.literal.gpio_hal_isolate_in_sleep .text.gpio_hal_isolate_in_sleep)
    *libhal.a:i2c_hal_iram.*(.literal .literal.* .text .text.*)
    *libhal.a:ledc_hal_iram.*(.literal .literal.* .text .text.*)
    *libhal.a:mmu_hal.*(.literal .literal.* .text .text.*)
    *libhal.a:spi_flash_encrypt_hal_iram.*(.literal .literal.* .text .text.*)
    *libhal.a:spi_flash_hal_iram.*(.literal .literal.* .text .text.*)
    *libhal.a:timer_hal.*(.literal.timer_hal_capture_and_get_counter_value .text.timer_hal_capture_and_get_counter_value)
    *libhal.a:wdt_hal_iram.*(.literal .literal.* .text .text.*)
    *libheap.a:multi_heap.*(.literal.assert_valid_block .text.assert_valid_block)
    *libheap.a:multi_heap.*(.literal.multi_heap_aligned_alloc_impl .text.multi_heap_aligned_alloc_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_aligned_alloc_impl_offs .text.multi_heap_aligned_alloc_impl_offs)
    *libheap.a:multi_heap.*(.literal.multi_heap_free_impl .text.multi_heap_free_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_get_allocated_size_impl .text.multi_heap_get_allocated_size_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_get_block_address_impl .text.multi_heap_get_block_address_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_get_first_block .text.multi_heap_get_first_block)
    *libheap.a:multi_heap.*(.literal.multi_heap_get_next_block .text.multi_heap_get_next_block)
    *libheap.a:multi_heap.*(.literal.multi_heap_internal_lock .text.multi_heap_internal_lock)
    *libheap.a:multi_heap.*(.literal.multi_heap_internal_unlock .text.multi_heap_internal_unlock)
    *libheap.a:multi_heap.*(.literal.multi_heap_is_free .text.multi_heap_is_free)
    *libheap.a:multi_heap.*(.literal.multi_heap_malloc_impl .text.multi_heap_malloc_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_realloc_impl .text.multi_heap_realloc_impl)
    *libheap.a:multi_heap.*(.literal.multi_heap_set_lock .text.multi_heap_set_lock)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_aligned_alloc .text.multi_heap_aligned_alloc)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_aligned_alloc_offs .text.multi_heap_aligned_alloc_offs)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_aligned_free .text.multi_heap_aligned_free)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_free .text.multi_heap_free)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_get_allocated_size .text.multi_heap_get_allocated_size)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_get_block_address .text.multi_heap_get_block_address)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_internal_check_block_poisoning .text.multi_heap_internal_check_block_poisoning)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_internal_poison_fill_region .text.multi_heap_internal_poison_fill_region)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_malloc .text.multi_heap_malloc)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_realloc .text.multi_heap_realloc)
    *libheap.a:multi_heap_poisoning.*(.literal.poison_allocated_region .text.poison_allocated_region)
    *libheap.a:multi_heap_poisoning.*(.literal.verify_allocated_region .text.verify_allocated_region)
    *libheap.a:tlsf.*(.literal.tlsf_alloc_overhead .text.tlsf_alloc_overhead)
    *libheap.a:tlsf.*(.literal.tlsf_block_size .text.tlsf_block_size)
    *libheap.a:tlsf.*(.literal.tlsf_free .text.tlsf_free)
    *libheap.a:tlsf.*(.literal.tlsf_get_pool .text.tlsf_get_pool)
    *libheap.a:tlsf.*(.literal.tlsf_malloc .text.tlsf_malloc)
    *libheap.a:tlsf.*(.literal.tlsf_memalign .text.tlsf_memalign)
    *libheap.a:tlsf.*(.literal.tlsf_memalign_offs .text.tlsf_memalign_offs)
    *libheap.a:tlsf.*(.literal.tlsf_realloc .text.tlsf_realloc)
    *libheap.a:tlsf.*(.literal.tlsf_size .text.tlsf_size)
    *liblog.a:log_lock.*(.literal .literal.* .text .text.*)
    *liblog.a:log_timestamp.*(.literal.esp_log_early_timestamp .text.esp_log_early_timestamp)
    *liblog.a:log_timestamp.*(.literal.esp_log_timestamp .text.esp_log_timestamp)
    *liblog.a:log_write.*(.literal.esp_log_write .text.esp_log_write)
    *liblog.a:log_write.*(.literal.esp_log_writev .text.esp_log_writev)
    *liblog.a:tag_log_level.*(.literal.esp_log_level_get_timeout .text.esp_log_level_get_timeout)
    *libnewlib.a:abort.*(.literal .literal.* .text .text.*)
    *libnewlib.a:assert.*(.literal .literal.* .text .text.*)
    *libnewlib.a:heap.*(.literal .literal.* .text .text.*)
    *libnewlib.a:stdatomic.*(.literal .literal.* .text .text.*)
    *libnewlib.a:stdatomic_s32c1i.*(.literal .literal.* .text .text.*)
    *librtc.a:(.literal .literal.* .text .text.*)
    *libsoc.a:lldesc.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:flash_brownout_hook.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:memspi_host_driver.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_boya.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_gd.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_generic.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_issi.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_mxic.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_th.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_chip_winbond.*(.literal .literal.* .text .text.*)
    *libspi_flash.a:spi_flash_wrap.*(.literal .literal.* .text .text.*)
    *libxt_hal.a:(.literal .literal.* .text .text.*)
    *libxtensa.a:(EXCLUDE_FILE(*libxtensa.a:xt_trax.* *libxtensa.a:xtensa_intr.*) .literal EXCLUDE_FILE(*libxtensa.a:xt_trax.* *libxtensa.a:xtensa_intr.*) .literal.* EXCLUDE_FILE(*libxtensa.a:xt_trax.* *libxtensa.a:xtensa_intr.*) .text EXCLUDE_FILE(*libxtensa.a:xt_trax.* *libxtensa.a:xtensa_intr.*) .text.*)
  } > iram0_0_seg
  .dram0.data :
  {
    _data_start = ABSOLUTE(.);
    *(.gnu.linkonce.d.*)
    *(.data1)
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
    *(.gnu.linkonce.s2.*)
    *(.jcr)
    *(EXCLUDE_FILE(*libbt.a *libbtdm_app.a) .data EXCLUDE_FILE(*libbt.a *libbtdm_app.a) .data.*)
    *(.dram1 .dram1.*)
    _coredump_dram_start = ABSOLUTE(.);
    *(.dram2.coredump .dram2.coredump.*)
    _coredump_dram_end = ABSOLUTE(.);
    *libapp_trace.a:app_trace.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libapp_trace.a:app_trace_util.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libapp_trace.a:port_uart.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    . = ALIGN(4);
    _bt_data_start = ABSOLUTE(.);
    *libbt.a:(.data .data.*)
    . = ALIGN(4);
    _bt_data_end = ABSOLUTE(.);
    . = ALIGN(4);
    _bt_controller_data_start = ABSOLUTE(.);
    *libbtdm_app.a:(.data .data.*)
    . = ALIGN(4);
    _bt_controller_data_end = ABSOLUTE(.);
    *libc.a:creat.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:isatty.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-abs.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-asctime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-asctime_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-atoi.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-atol.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-bzero.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-close.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-creat.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ctime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ctime_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ctype_.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-div.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-environ.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-envlock.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-fclose.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-fflush.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-findfp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-fputwc.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-fvwrite.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-fwalk.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-getenv_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-gettzinfo.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-gmtime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-gmtime_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-impure.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isalnum.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isalpha.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isascii.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isblank.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-iscntrl.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isdigit.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isgraph.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-islower.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isprint.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ispunct.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isspace.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-isupper.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-itoa.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-labs.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-lcltime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-lcltime_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ldiv.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-longjmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-makebuf.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memccpy.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memchr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memcmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memcpy.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memmove.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memrchr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-memset.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-mktime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-month_lengths.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-open.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-quorem.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-raise.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-rand.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-rand_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-read.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-refill.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-rshift.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-s_fpclassify.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sbrk.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sccl.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-setjmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sf_nan.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-srand.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-stdio.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcasecmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcasestr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcat.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strchr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcoll.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcpy.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strcspn.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strdup.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strdup_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strftime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strlcat.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strlcpy.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strlen.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strlwr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strncasecmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strncat.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strncmp.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strncpy.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strndup.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strndup_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strnlen.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strptime.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strrchr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strsep.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strspn.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strstr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strtok_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strtol.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strtoul.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-strupr.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sysclose.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sysopen.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-sysread.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-syssbrk.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-system.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-systimes.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-syswrite.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-time.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-timelocal.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-toascii.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tolower.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-toupper.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tzcalc_limits.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tzlock.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tzset.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tzset_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-tzvars.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-ungetc.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-utoa.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-wbuf.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-wcrtomb.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-wctomb_r.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:libc_a-wsetup.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libc.a:lock.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_hw_support.a:clk_utils.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_hw_support.a:esp_memory_utils.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_hw_support.a:mspi_timing_tuning.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_hw_support.a:rtc_clk.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_mm.a:cache_esp32.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_mm.a:esp_cache.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_rom.a:esp_rom_print.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_rom.a:esp_rom_spiflash.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_rom.a:esp_rom_sys.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_system.a:esp_err.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_system.a:image_process.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libesp_system.a:ubsan.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libgcov.a:(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:cache_hal_esp32.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:i2c_hal_iram.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:ledc_hal_iram.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:mmu_hal.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:spi_flash_encrypt_hal_iram.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:spi_flash_hal_iram.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libhal.a:wdt_hal_iram.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *liblog.a:log_lock.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libnewlib.a:abort.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libnewlib.a:assert.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libnewlib.a:heap.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libnewlib.a:stdatomic.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libnewlib.a:stdatomic_s32c1i.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libphy.a:(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libsoc.a:lldesc.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:flash_brownout_hook.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:memspi_host_driver.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_boya.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_gd.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_generic.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_issi.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_mxic.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_th.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_chip_winbond.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    *libspi_flash.a:spi_flash_wrap.*(.rodata .rodata.* .sdata2 .sdata2.* .srodata .srodata.*)
    _data_end = ABSOLUTE(.);
  } > dram0_0_seg
  /**
   * This section holds data that won't be initialised when startup.
   * This section locates in External RAM region.
   */
  .ext_ram_noinit (NOLOAD) :
  {
    _ext_ram_noinit_start = ABSOLUTE(.);
    *(.ext_ram_noinit*)
    
 . = ALIGN(4); 
 _ext_ram_noinit_end = ABSOLUTE(.);
  } > extern_ram_seg
  /**
   * This section holds data that should not be initialized at power up.
   * The section located in Internal SRAM memory region. The macro _NOINIT
   * can be used as attribute to place data into this section.
   * See the "esp_attr.h" file for more information.
   */
  .noinit (NOLOAD):
  {
    
 . = ALIGN(4); 
 _noinit_start = ABSOLUTE(.);
    *(.noinit .noinit.*)
    
 . = ALIGN(4); 
 _noinit_end = ABSOLUTE(.);
  } > dram0_0_seg
  /* External Memory BSS. (Variables with EXT_RAM_BSS_ATTR attribute). */
  .ext_ram.bss (NOLOAD) :
  {
    
 . = ALIGN(4); 
 _ext_ram_bss_start = ABSOLUTE(.);
    
 . = ALIGN(4); 
 _ext_ram_bss_end = ABSOLUTE(.);
  } > extern_ram_seg
  /* Shared RAM */
  .dram0.bss (NOLOAD) :
  {
    
 . = ALIGN(8); 
 _bss_start = ABSOLUTE(.);
    /**
     * ldgen places all bss-related data to mapping[dram0_bss]
     * (See components/esp_system/app.lf).
     */
    *(EXCLUDE_FILE(*libbt.a *libbtdm_app.a) .bss EXCLUDE_FILE(*libbt.a *libbtdm_app.a) .bss.*)
    *(.dynbss .dynsbss .gnu.linkonce.b .gnu.linkonce.b.* .gnu.linkonce.sb .gnu.linkonce.sb.* .gnu.linkonce.sb2 .gnu.linkonce.sb2.* .sbss .sbss.* .sbss2 .sbss2.* .scommon .share.mem)
    *(.ext_ram.bss .ext_ram.bss.*)
    *(EXCLUDE_FILE(*libbt.a *libbtdm_app.a) COMMON)
    . = ALIGN(4);
    _bt_bss_start = ABSOLUTE(.);
    *libbt.a:(.bss .bss.*)
    . = ALIGN(4);
    _bt_bss_end = ABSOLUTE(.);
    . = ALIGN(4);
    _bt_common_start = ABSOLUTE(.);
    *libbt.a:(COMMON)
    . = ALIGN(4);
    _bt_common_end = ABSOLUTE(.);
    . = ALIGN(4);
    _bt_controller_bss_start = ABSOLUTE(.);
    *libbtdm_app.a:(.bss .bss.*)
    . = ALIGN(4);
    _bt_controller_bss_end = ABSOLUTE(.);
    . = ALIGN(4);
    _bt_controller_common_start = ABSOLUTE(.);
    *libbtdm_app.a:(COMMON)
    . = ALIGN(4);
    _bt_controller_common_end = ABSOLUTE(.);
    
 . = ALIGN(8); 
 _bss_end = ABSOLUTE(.);
  } > dram0_0_seg
  ASSERT(((_bss_end - ORIGIN(dram0_0_seg)) <= LENGTH(dram0_0_seg)),
          "DRAM segment data does not fit.")
  .flash.appdesc : ALIGN(0x10)
  {
    /**
     * Mark flash.rodata start.
     * This can be used for mmu driver to maintain virtual address
     */
    _rodata_reserved_start = ABSOLUTE(.);
    _rodata_start = ABSOLUTE(.);
    /* !DO NOT PUT ANYTHING BEFORE THIS! */
    /* Should be the first.  App version info. */
    *(.rodata_desc .rodata_desc.*)
    /* Should be the second. Custom app version info. */
    *(.rodata_custom_desc .rodata_custom_desc.*)
    /**
     * Create an empty gap within this section. Thanks to this, the end of this
     * section will match .flah.rodata's begin address. Thus, both sections
     * will be merged when creating the final bin image.
     */
    . = ALIGN(ALIGNOF(.flash.rodata));
  } > default_rodata_seg
  ASSERT((ADDR(.flash.rodata) == ADDR(.flash.appdesc) + SIZEOF(.flash.appdesc)), "The gap between .flash.appdesc and .flash.rodata must not exist to produce the final bin image.")
  .flash.rodata : ALIGN(0x10)
  {
    _flash_rodata_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .rodata EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .rodata.* EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .sdata2 EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .sdata2.* EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .srodata EXCLUDE_FILE(*libgcov.a *libphy.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libhal.a:cache_hal_esp32.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:wdt_hal_iram.* *liblog.a:log_lock.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .srodata.*)
    *(.rodata_wlog_error .rodata_wlog_error.*)
    *(.irom1.text) /* catch stray ICACHE_RODATA_ATTR */
    *(.gnu.linkonce.r.*)
    *(.rodata1)
    /* C++ exception handlers table.  */
    
 . = ALIGN(4); 
 __XT_EXCEPTION_TABLE_ = ABSOLUTE(.);
    *(.xt_except_table)
    *(.gcc_except_table .gcc_except_table.*)
    *(.gnu.linkonce.e.*)
    
 . = ALIGN(4); 
 __XT_EXCEPTION_DESCS_ = ABSOLUTE(.);
    *(.xt_except_desc)
    *(.gnu.linkonce.h.*)
    __XT_EXCEPTION_DESCS_END__ = ABSOLUTE(.);
    *(.xt_except_desc_end)
    
 . = ALIGN(4); 
 __eh_frame = ABSOLUTE(.);
    KEEP(*(.eh_frame))
    /**
     * As we are not linking with crtend.o, which includes the CIE terminator
     * (see __FRAME_END__ in libgcc sources), it is manually provided here.
     */
    LONG(0);
    /**
     * C++ constructor tables.
     *
     * Excluding crtbegin.o/crtend.o since IDF doesn't use the toolchain crt.
     */
    
 . = ALIGN(4); 
 __init_array_start = ABSOLUTE(.);
    KEEP (*(EXCLUDE_FILE (*crtend.* *crtbegin.*) .ctors SORT(.ctors.*)))
    __init_array_end = ABSOLUTE(.);
    /* Addresses of memory regions reserved via SOC_RESERVE_MEMORY_REGION() */
    
 . = ALIGN(4); 
 soc_reserved_memory_region_start = ABSOLUTE(.);
    KEEP (*(.reserved_memory_address))
    soc_reserved_memory_region_end = ABSOLUTE(.);
    /* System init functions registered via ESP_SYSTEM_INIT_FN */
    
 . = ALIGN(4); 
 _esp_system_init_fn_array_start = ABSOLUTE(.);
    KEEP (*(SORT_BY_INIT_PRIORITY(.esp_system_init_fn.*)))
    _esp_system_init_fn_array_end = ABSOLUTE(.);
    _rodata_end = ABSOLUTE(.);
    /* Literals are also RO data. */
    _lit4_start = ABSOLUTE(.);
    *(*.lit4)
    *(.lit4.*)
    *(.gnu.linkonce.lit4.*)
    _lit4_end = ABSOLUTE(.);
    /* TLS data. */
    
 . = ALIGN(4); 
 _thread_local_start = ABSOLUTE(.);
    *(.tdata)
    *(.tdata.*)
    *(.tbss)
    *(.tbss.*)
    _thread_local_end = ABSOLUTE(.);
  } > default_rodata_seg
  _flash_rodata_align = ALIGNOF(.flash.rodata);
  /**
   * This section contains all the rodata that is not used
   * at runtime, helping to avoid an increase in binary size.
   */
  .flash.rodata_noload (NOLOAD) :
  {
    /**
     * This symbol marks the end of flash.rodata. It can be utilized by the MMU
     * driver to maintain the virtual address.
     * NOLOAD rodata may not be included in this section.
     */
    _rodata_reserved_end = ABSOLUTE(.);
    *(.rodata_wlog_debug .rodata_wlog_debug.*)
    *(.rodata_wlog_info .rodata_wlog_info.*)
    *(.rodata_wlog_verbose .rodata_wlog_verbose.*)
    *(.rodata_wlog_warning .rodata_wlog_warning.*)
  } > default_rodata_seg
  .flash.text :
  {
    _stext = .;
    /**
     * Mark the start of flash.text.
     * This can be used by the MMU driver to maintain the virtual address.
     */
    _instruction_reserved_start = ABSOLUTE(.);
    _text_start = ABSOLUTE(.);
    *(EXCLUDE_FILE(*libesp_ringbuf.a *libfreertos.a *libgcov.a *librtc.a *libxt_hal.a *libxtensa.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_driver_gptimer.a:gptimer.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:cpu.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_hw_support.a:rtc_init.* *libesp_hw_support.a:rtc_sleep.* *libesp_hw_support.a:rtc_time.* *libesp_hw_support.a:rtc_wdt.* *libesp_hw_support.a:sar_periph_ctrl.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:esp_system_chip.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libgcc.a:lib2funcs.* *libhal.a:cache_hal_esp32.* *libhal.a:gpio_hal.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:timer_hal.* *libhal.a:wdt_hal_iram.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libheap.a:tlsf.* *liblog.a:log_lock.* *liblog.a:log_timestamp.* *liblog.a:log_write.* *liblog.a:tag_log_level.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .literal EXCLUDE_FILE(*libesp_ringbuf.a *libfreertos.a *libgcov.a *librtc.a *libxt_hal.a *libxtensa.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_driver_gptimer.a:gptimer.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:cpu.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_hw_support.a:rtc_init.* *libesp_hw_support.a:rtc_sleep.* *libesp_hw_support.a:rtc_time.* *libesp_hw_support.a:rtc_wdt.* *libesp_hw_support.a:sar_periph_ctrl.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:esp_system_chip.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libgcc.a:lib2funcs.* *libhal.a:cache_hal_esp32.* *libhal.a:gpio_hal.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:timer_hal.* *libhal.a:wdt_hal_iram.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libheap.a:tlsf.* *liblog.a:log_lock.* *liblog.a:log_timestamp.* *liblog.a:log_write.* *liblog.a:tag_log_level.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .literal.* EXCLUDE_FILE(*libesp_ringbuf.a *libfreertos.a *libgcov.a *librtc.a *libxt_hal.a *libxtensa.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_driver_gptimer.a:gptimer.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:cpu.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_hw_support.a:rtc_init.* *libesp_hw_support.a:rtc_sleep.* *libesp_hw_support.a:rtc_time.* *libesp_hw_support.a:rtc_wdt.* *libesp_hw_support.a:sar_periph_ctrl.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:esp_system_chip.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libgcc.a:lib2funcs.* *libhal.a:cache_hal_esp32.* *libhal.a:gpio_hal.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:timer_hal.* *libhal.a:wdt_hal_iram.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libheap.a:tlsf.* *liblog.a:log_lock.* *liblog.a:log_timestamp.* *liblog.a:log_write.* *liblog.a:tag_log_level.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .text EXCLUDE_FILE(*libesp_ringbuf.a *libfreertos.a *libgcov.a *librtc.a *libxt_hal.a *libxtensa.a *libapp_trace.a:app_trace.* *libapp_trace.a:app_trace_util.* *libapp_trace.a:port_uart.* *libc.a:creat.* *libc.a:isatty.* *libc.a:libc_a-abs.* *libc.a:libc_a-asctime.* *libc.a:libc_a-asctime_r.* *libc.a:libc_a-atoi.* *libc.a:libc_a-atol.* *libc.a:libc_a-bzero.* *libc.a:libc_a-close.* *libc.a:libc_a-creat.* *libc.a:libc_a-ctime.* *libc.a:libc_a-ctime_r.* *libc.a:libc_a-ctype_.* *libc.a:libc_a-div.* *libc.a:libc_a-environ.* *libc.a:libc_a-envlock.* *libc.a:libc_a-fclose.* *libc.a:libc_a-fflush.* *libc.a:libc_a-findfp.* *libc.a:libc_a-fputwc.* *libc.a:libc_a-fvwrite.* *libc.a:libc_a-fwalk.* *libc.a:libc_a-getenv_r.* *libc.a:libc_a-gettzinfo.* *libc.a:libc_a-gmtime.* *libc.a:libc_a-gmtime_r.* *libc.a:libc_a-impure.* *libc.a:libc_a-isalnum.* *libc.a:libc_a-isalpha.* *libc.a:libc_a-isascii.* *libc.a:libc_a-isblank.* *libc.a:libc_a-iscntrl.* *libc.a:libc_a-isdigit.* *libc.a:libc_a-isgraph.* *libc.a:libc_a-islower.* *libc.a:libc_a-isprint.* *libc.a:libc_a-ispunct.* *libc.a:libc_a-isspace.* *libc.a:libc_a-isupper.* *libc.a:libc_a-itoa.* *libc.a:libc_a-labs.* *libc.a:libc_a-lcltime.* *libc.a:libc_a-lcltime_r.* *libc.a:libc_a-ldiv.* *libc.a:libc_a-longjmp.* *libc.a:libc_a-makebuf.* *libc.a:libc_a-memccpy.* *libc.a:libc_a-memchr.* *libc.a:libc_a-memcmp.* *libc.a:libc_a-memcpy.* *libc.a:libc_a-memmove.* *libc.a:libc_a-memrchr.* *libc.a:libc_a-memset.* *libc.a:libc_a-mktime.* *libc.a:libc_a-month_lengths.* *libc.a:libc_a-open.* *libc.a:libc_a-quorem.* *libc.a:libc_a-raise.* *libc.a:libc_a-rand.* *libc.a:libc_a-rand_r.* *libc.a:libc_a-read.* *libc.a:libc_a-refill.* *libc.a:libc_a-rshift.* *libc.a:libc_a-s_fpclassify.* *libc.a:libc_a-sbrk.* *libc.a:libc_a-sccl.* *libc.a:libc_a-setjmp.* *libc.a:libc_a-sf_nan.* *libc.a:libc_a-srand.* *libc.a:libc_a-stdio.* *libc.a:libc_a-strcasecmp.* *libc.a:libc_a-strcasestr.* *libc.a:libc_a-strcat.* *libc.a:libc_a-strchr.* *libc.a:libc_a-strcmp.* *libc.a:libc_a-strcoll.* *libc.a:libc_a-strcpy.* *libc.a:libc_a-strcspn.* *libc.a:libc_a-strdup.* *libc.a:libc_a-strdup_r.* *libc.a:libc_a-strftime.* *libc.a:libc_a-strlcat.* *libc.a:libc_a-strlcpy.* *libc.a:libc_a-strlen.* *libc.a:libc_a-strlwr.* *libc.a:libc_a-strncasecmp.* *libc.a:libc_a-strncat.* *libc.a:libc_a-strncmp.* *libc.a:libc_a-strncpy.* *libc.a:libc_a-strndup.* *libc.a:libc_a-strndup_r.* *libc.a:libc_a-strnlen.* *libc.a:libc_a-strptime.* *libc.a:libc_a-strrchr.* *libc.a:libc_a-strsep.* *libc.a:libc_a-strspn.* *libc.a:libc_a-strstr.* *libc.a:libc_a-strtok_r.* *libc.a:libc_a-strtol.* *libc.a:libc_a-strtoul.* *libc.a:libc_a-strupr.* *libc.a:libc_a-sysclose.* *libc.a:libc_a-sysopen.* *libc.a:libc_a-sysread.* *libc.a:libc_a-syssbrk.* *libc.a:libc_a-system.* *libc.a:libc_a-systimes.* *libc.a:libc_a-syswrite.* *libc.a:libc_a-time.* *libc.a:libc_a-timelocal.* *libc.a:libc_a-toascii.* *libc.a:libc_a-tolower.* *libc.a:libc_a-toupper.* *libc.a:libc_a-tzcalc_limits.* *libc.a:libc_a-tzlock.* *libc.a:libc_a-tzset.* *libc.a:libc_a-tzset_r.* *libc.a:libc_a-tzvars.* *libc.a:libc_a-ungetc.* *libc.a:libc_a-utoa.* *libc.a:libc_a-wbuf.* *libc.a:libc_a-wcrtomb.* *libc.a:libc_a-wctomb_r.* *libc.a:libc_a-wsetup.* *libc.a:lock.* *libesp_driver_gptimer.a:gptimer.* *libesp_event.a:default_event_loop.* *libesp_event.a:esp_event.* *libesp_hw_support.a:clk_utils.* *libesp_hw_support.a:cpu.* *libesp_hw_support.a:esp_memory_utils.* *libesp_hw_support.a:mspi_timing_tuning.* *libesp_hw_support.a:rtc_clk.* *libesp_hw_support.a:rtc_init.* *libesp_hw_support.a:rtc_sleep.* *libesp_hw_support.a:rtc_time.* *libesp_hw_support.a:rtc_wdt.* *libesp_hw_support.a:sar_periph_ctrl.* *libesp_mm.a:cache_esp32.* *libesp_mm.a:esp_cache.* *libesp_rom.a:esp_rom_print.* *libesp_rom.a:esp_rom_spiflash.* *libesp_rom.a:esp_rom_sys.* *libesp_system.a:esp_err.* *libesp_system.a:esp_system_chip.* *libesp_system.a:image_process.* *libesp_system.a:ubsan.* *libgcc.a:lib2funcs.* *libhal.a:cache_hal_esp32.* *libhal.a:gpio_hal.* *libhal.a:i2c_hal_iram.* *libhal.a:ledc_hal_iram.* *libhal.a:mmu_hal.* *libhal.a:spi_flash_encrypt_hal_iram.* *libhal.a:spi_flash_hal_iram.* *libhal.a:timer_hal.* *libhal.a:wdt_hal_iram.* *libheap.a:multi_heap.* *libheap.a:multi_heap_poisoning.* *libheap.a:tlsf.* *liblog.a:log_lock.* *liblog.a:log_timestamp.* *liblog.a:log_write.* *liblog.a:tag_log_level.* *libnewlib.a:abort.* *libnewlib.a:assert.* *libnewlib.a:heap.* *libnewlib.a:stdatomic.* *libnewlib.a:stdatomic_s32c1i.* *libsoc.a:lldesc.* *libspi_flash.a:flash_brownout_hook.* *libspi_flash.a:memspi_host_driver.* *libspi_flash.a:spi_flash_chip_boya.* *libspi_flash.a:spi_flash_chip_gd.* *libspi_flash.a:spi_flash_chip_generic.* *libspi_flash.a:spi_flash_chip_issi.* *libspi_flash.a:spi_flash_chip_mxic.* *libspi_flash.a:spi_flash_chip_th.* *libspi_flash.a:spi_flash_chip_winbond.* *libspi_flash.a:spi_flash_wrap.*) .text.*)
    *(.wifi0iram .wifi0iram.*)
    *(.wifiextrairam .wifiextrairam.*)
    *(.wifiorslpiram .wifiorslpiram.*)
    *(.wifirxiram .wifirxiram.*)
    *(.wifislpiram .wifislpiram.*)
    *(.wifislprxiram .wifislprxiram.*)
    *libcoexist.a:(.coexiram .coexiram.*)
    *libcoexist.a:(.coexsleepiram .coexsleepiram.*)
    *libesp_driver_gptimer.a:gptimer.*(.literal.gptimer_del_timer .literal.gptimer_destroy .literal.gptimer_disable .literal.gptimer_enable .literal.gptimer_get_captured_count .literal.gptimer_get_raw_count .literal.gptimer_get_resolution .literal.gptimer_new_timer .literal.gptimer_register_event_callbacks .literal.gptimer_set_alarm_action .literal.gptimer_set_raw_count .literal.gptimer_start .literal.gptimer_stop .text .text.gptimer_del_timer .text.gptimer_destroy .text.gptimer_disable .text.gptimer_enable .text.gptimer_get_captured_count .text.gptimer_get_raw_count .text.gptimer_get_resolution .text.gptimer_new_timer .text.gptimer_register_event_callbacks .text.gptimer_set_alarm_action .text.gptimer_set_raw_count .text.gptimer_start .text.gptimer_stop)
    *libesp_event.a:default_event_loop.*(.literal.esp_event_handler_instance_register .literal.esp_event_handler_instance_unregister .literal.esp_event_handler_register .literal.esp_event_handler_unregister .literal.esp_event_loop_create_default .literal.esp_event_loop_delete_default .literal.esp_event_post .text .text.esp_event_handler_instance_register .text.esp_event_handler_instance_unregister .text.esp_event_handler_register .text.esp_event_handler_unregister .text.esp_event_loop_create_default .text.esp_event_loop_delete_default .text.esp_event_post)
    *libesp_event.a:esp_event.*(.literal.base_node_add_handler .literal.esp_event_handler_instance_register_with .literal.esp_event_handler_instance_unregister_with .literal.esp_event_handler_register_with .literal.esp_event_handler_register_with_internal .literal.esp_event_handler_unregister_with .literal.esp_event_handler_unregister_with_internal .literal.esp_event_loop_create .literal.esp_event_loop_delete .literal.esp_event_loop_run .literal.esp_event_loop_run_task .literal.esp_event_post_to .literal.handler_instances_add .literal.handler_instances_remove .literal.handler_instances_remove_all .literal.loop_node_add_handler .literal.loop_remove_handler .text .text.base_node_add_handler .text.esp_event_dump .text.esp_event_handler_instance_register_with .text.esp_event_handler_instance_unregister_with .text.esp_event_handler_register_with .text.esp_event_handler_register_with_internal .text.esp_event_handler_unregister_with .text.esp_event_handler_unregister_with_internal .text.esp_event_loop_create .text.esp_event_loop_delete .text.esp_event_loop_run .text.esp_event_loop_run_task .text.esp_event_post_to .text.handler_instances_add .text.handler_instances_remove .text.handler_instances_remove_all .text.loop_node_add_handler .text.loop_remove_handler)
    *libesp_hw_support.a:cpu.*(.text .text.esp_cpu_clear_breakpoint .text.esp_cpu_clear_watchpoint .text.esp_cpu_set_breakpoint .text.esp_cpu_set_watchpoint)
    *libesp_hw_support.a:rtc_init.*(.literal.rtc_init .text .text.rtc_init)
    *libesp_hw_support.a:sar_periph_ctrl.*(.literal.s_sar_power_acquire .literal.s_sar_power_release .literal.sar_periph_ctrl_adc_continuous_power_acquire .literal.sar_periph_ctrl_adc_continuous_power_release .literal.sar_periph_ctrl_adc_oneshot_power_acquire .literal.sar_periph_ctrl_adc_oneshot_power_release .literal.sar_periph_ctrl_init .literal.sar_periph_ctrl_power_disable .literal.sar_periph_ctrl_pwdet_power_acquire .literal.sar_periph_ctrl_pwdet_power_release .text .text.s_sar_power_acquire .text.s_sar_power_release .text.sar_periph_ctrl_adc_continuous_power_acquire .text.sar_periph_ctrl_adc_continuous_power_release .text.sar_periph_ctrl_adc_oneshot_power_acquire .text.sar_periph_ctrl_adc_oneshot_power_release .text.sar_periph_ctrl_init .text.sar_periph_ctrl_power_disable .text.sar_periph_ctrl_pwdet_power_acquire .text.sar_periph_ctrl_pwdet_power_release)
    *libesp_system.a:esp_system_chip.*(.literal.esp_get_free_heap_size .literal.esp_get_free_internal_heap_size .literal.esp_get_idf_version .literal.esp_get_minimum_free_heap_size .text .text.esp_get_free_heap_size .text.esp_get_free_internal_heap_size .text.esp_get_idf_version .text.esp_get_minimum_free_heap_size)
    *libfreertos.a:app_startup.*(.literal .literal.* .text .text.*)
    *libfreertos.a:freertos_compatibility.*(.literal .literal.* .text .text.*)
    *libfreertos.a:idf_additions.*(.literal .literal.* .text .text.*)
    *libfreertos.a:tasks.*(.literal.uxTaskGetSnapshotAll .text.uxTaskGetSnapshotAll)
    *libfreertos.a:tasks.*(.literal.xTaskGetNext .text.xTaskGetNext)
    *libhal.a:gpio_hal.*(.literal.gpio_hal_intr_disable .literal.gpio_hal_intr_enable_on_core .text .text.gpio_hal_intr_disable .text.gpio_hal_intr_enable_on_core)
    *libhal.a:timer_hal.*(.literal.timer_hal_deinit .literal.timer_hal_init .text .text.timer_hal_deinit .text.timer_hal_init .text.timer_hal_set_counter_value)
    *libheap.a:multi_heap.*(.literal.multi_heap_check .literal.multi_heap_dump .literal.multi_heap_dump_tlsf .literal.multi_heap_get_info_impl .literal.multi_heap_register_impl .literal.multi_heap_reset_minimum_free_bytes .literal.multi_heap_restore_minimum_free_bytes .literal.multi_heap_walk .literal.tlsf_check_hook .text .text.multi_heap_check .text.multi_heap_dump .text.multi_heap_dump_tlsf .text.multi_heap_free_size_impl .text.multi_heap_get_info_impl .text.multi_heap_get_info_tlsf .text.multi_heap_minimum_free_size_impl .text.multi_heap_register_impl .text.multi_heap_reset_minimum_free_bytes .text.multi_heap_restore_minimum_free_bytes .text.multi_heap_walk .text.tlsf_check_hook)
    *libheap.a:multi_heap_poisoning.*(.literal.multi_heap_free_size .literal.multi_heap_get_info .literal.multi_heap_minimum_free_size .literal.multi_heap_register .text .text.multi_heap_free_size .text.multi_heap_get_info .text.multi_heap_minimum_free_size .text.multi_heap_register)
    *libheap.a:tlsf.*(.literal.default_walker .literal.integrity_walker .literal.tlsf_add_pool .literal.tlsf_check .literal.tlsf_check_pool .literal.tlsf_create .literal.tlsf_create_with_pool .literal.tlsf_malloc_addr .literal.tlsf_remove_pool .literal.tlsf_walk_pool .text .text.default_walker .text.integrity_walker .text.tlsf_add_pool .text.tlsf_check .text.tlsf_check_pool .text.tlsf_create .text.tlsf_create_with_pool .text.tlsf_destroy .text.tlsf_find_containing_block .text.tlsf_fit_size .text.tlsf_malloc_addr .text.tlsf_pool_overhead .text.tlsf_remove_pool .text.tlsf_walk_pool)
    *liblog.a:log_timestamp.*(.text)
    *liblog.a:log_write.*(.literal.esp_log_set_vprintf .text .text.esp_log_set_vprintf)
    *liblog.a:tag_log_level.*(.literal.esp_log_level_get .literal.esp_log_level_set .literal.log_level_get .text .text.esp_log_level_get .text.esp_log_level_set .text.log_level_get)
    *libphy.a:(.phyiram .phyiram.*)
    *libxtensa.a:xt_trax.*(.literal .literal.* .text .text.*)
    *libxtensa.a:xtensa_intr.*(.literal .literal.* .text .text.*)
    *(.stub)
    *(.gnu.warning)
    *(.gnu.linkonce.literal.* .gnu.linkonce.t.*.literal .gnu.linkonce.t.*)
    *(.irom0.text) /* catch stray ICACHE_RODATA_ATTR */
    /**
     * CPU will try to prefetch up to 16 bytes of of instructions.
     * This means that any configuration (e.g. MMU, PMS) must allow
     * safe access to up to 16 bytes after the last real instruction,
     * add dummy bytes to ensure this.
     */
    . += 16;
    _text_end = ABSOLUTE(.);
    /**
     * Mark the flash.text end.
     * This can be used for MMU driver to maintain virtual address.
     */
    _instruction_reserved_end = ABSOLUTE(.);
    _etext = .;
    /**
     * Similar to _iram_start, this symbol goes here so it is
     * resolved by addr2line in preference to the first symbol in
     * the flash.text segment.
     */
    _flash_cache_start = ABSOLUTE(0);
  } > default_code_seg
  /* Marks the end of IRAM code segment */
  .iram0.text_end (NOLOAD) :
  {
    
 . = ALIGN(4); 
 _iram_text_end = ABSOLUTE(.);
  } > iram0_0_seg
  .iram0.data :
  {
    
 . = ALIGN(4); 
 _iram_data_start = ABSOLUTE(.);
    *(.iram.data .iram.data.*)
    _coredump_iram_start = ABSOLUTE(.);
    *(.iram2.coredump .iram2.coredump.*)
    _coredump_iram_end = ABSOLUTE(.);
    _iram_data_end = ABSOLUTE(.);
  } > iram0_0_seg
  .iram0.bss (NOLOAD) :
  {
    
 . = ALIGN(4); 
 _iram_bss_start = ABSOLUTE(.);
    *(.iram.bss .iram.bss.*)
    _iram_bss_end = ABSOLUTE(.);
    
 . = ALIGN(4); 
 _iram_end = ABSOLUTE(.);
  } > iram0_0_seg
  /* Marks the end of data, bss and possibly rodata  */
  .dram0.heap_start (NOLOAD) :
  {
    /* Lowest possible start address for the heap */
    
 . = ALIGN(8); 
 _heap_low_start = ABSOLUTE(.);
  } > dram0_0_seg
  /* DWARF 1 */
  .debug 0 : { *(.debug) }
  .line 0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo 0 : { *(.debug_srcinfo) }
  .debug_sfnames 0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges 0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info 0 : { *(.debug_info .gnu.linkonce.wi.*) }
  .debug_abbrev 0 : { *(.debug_abbrev) }
  .debug_line 0 : { *(.debug_line) }
  .debug_frame 0 : { *(.debug_frame) }
  .debug_str 0 : { *(.debug_str) }
  .debug_loc 0 : { *(.debug_loc) }
  .debug_macinfo 0 : { *(.debug_macinfo) }
  .debug_pubtypes 0 : { *(.debug_pubtypes) }
  /* DWARF 3 */
  .debug_ranges 0 : { *(.debug_ranges) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames 0 : { *(.debug_varnames) }
  /* GNU DWARF 2 extensions */
  .debug_gnu_pubnames 0 : { *(.debug_gnu_pubnames) }
  .debug_gnu_pubtypes 0 : { *(.debug_gnu_pubtypes) }
  /* DWARF 4 */
  .debug_types 0 : { *(.debug_types) }
  /* DWARF 5 */
  .debug_addr 0 : { *(.debug_addr) }
  .debug_line_str 0 : { *(.debug_line_str) }
  .debug_loclists 0 : { *(.debug_loclists) }
  .debug_macro 0 : { *(.debug_macro) }
  .debug_names 0 : { *(.debug_names) }
  .debug_rnglists 0 : { *(.debug_rnglists) }
  .debug_str_offsets 0 : { *(.debug_str_offsets) }
  .comment 0 : { *(.comment) }
  .note.GNU-stack 0: { *(.note.GNU-stack) }
/**
 * .xt.prop and .xt.lit sections will be used by the debugger and disassembler
 * to get more information about raw data present in the code.
 * Indeed, it may be required to add some padding at some points in the code
 * in order to align a branch/jump destination on a particular bound.
 * Padding these instructions will generate null bytes that shall be
 * interpreted as data, and not code by the debugger or disassembler.
 * This section will only be present in the ELF file, not in the final binary
 * For more details, check GCC-212
 */
  .xtensa.info 0: { *(.xtensa.info) }
  .xt.prop 0 : { *(.xt.prop .xt.prop.* .gnu.linkonce.prop.*) }
  .xt.lit 0 : { *(.xt.lit .xt.lit.* .gnu.linkonce.p.*) }
  /DISCARD/ :
  {
   *(.fini)
   *(.eh_frame_hdr)
  }
}
ASSERT(((_iram_end - ORIGIN(iram0_0_seg)) <= LENGTH(iram0_0_seg)),
          "IRAM0 segment data does not fit.")
ASSERT(((_heap_low_start - ORIGIN(dram0_0_seg)) <= LENGTH(dram0_0_seg)),
          "DRAM segment data does not fit.")
