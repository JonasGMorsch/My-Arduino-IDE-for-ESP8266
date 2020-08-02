$arduinoBetaPath = "C:\Development\My-Arduino-IDE-for-ESP8266-ALPHA"
$espBetaPath = "$arduinoBetaPath\hardware\espressif"
$boardBetaPath ="$espGitPath\esp8266\boards.txt"

$arduinoGitPath = "C:\Portable_Programs\My-Arduino-IDE-for-ESP8266"
$espGitPath = "$arduinoGitPath\hardware\espressif"
$boardGitPath ="$espGitPath\esp8266\boards.txt"

$arduinoMyConfigPath = "C:\Development\My-Arduino-IDE-CONFIGS"

$habitatcontrolboard ='
habitatcontrol.name= Habitat Control V1
habitatcontrol.build.board=ESP8266_aquacontrol
habitatcontrol.build.variant=aquacontrol
habitatcontrol.upload.tool=esptool
habitatcontrol.upload.maximum_data_size=81920
habitatcontrol.upload.wait_for_upload_port=false
habitatcontrol.upload.erase_cmd=
habitatcontrol.serial.disableDTR=true
habitatcontrol.serial.disableRTS=true
habitatcontrol.build.mcu=esp8266
habitatcontrol.build.core=esp8266
habitatcontrol.build.spiffs_pagesize=256
habitatcontrol.build.debug_port=
habitatcontrol.build.debug_level=
habitatcontrol.menu.xtal.80=80 MHz
habitatcontrol.menu.xtal.80.build.f_cpu=80000000L
habitatcontrol.menu.vt.iram=IRAM
habitatcontrol.menu.vt.iram.build.vtable_flags=-DVTABLES_IN_IRAM
habitatcontrol.menu.exception.legacy=Legacy (new can return nullptr)
habitatcontrol.menu.exception.legacy.build.exception_flags=-fno-exceptions
habitatcontrol.menu.exception.legacy.build.stdcpp_lib=-lstdc++
habitatcontrol.menu.exception.disabled=Disabled (new can abort)
habitatcontrol.menu.exception.disabled.build.exception_flags=-fno-exceptions -DNEW_OOM_ABORT
habitatcontrol.menu.exception.disabled.build.stdcpp_lib=-lstdc++
habitatcontrol.menu.exception.enabled=Enabled
habitatcontrol.menu.exception.enabled.build.exception_flags=-fexceptions
habitatcontrol.menu.exception.enabled.build.stdcpp_lib=-lstdc++-exc
habitatcontrol.menu.stacksmash.disabled=Disabled
habitatcontrol.menu.stacksmash.disabled.build.stacksmash_flags=
habitatcontrol.menu.stacksmash.enabled=Enabled
habitatcontrol.menu.stacksmash.enabled.build.stacksmash_flags=-fstack-protector
habitatcontrol.menu.ssl.all=All SSL ciphers (most compatible)
habitatcontrol.menu.ssl.all.build.sslflags=
habitatcontrol.menu.ssl.basic=Basic SSL ciphers (lower ROM use)
habitatcontrol.menu.ssl.basic.build.sslflags=-DBEARSSL_SSL_BASIC
habitatcontrol.upload.resetmethod=--before default_reset --after hard_reset
habitatcontrol.build.flash_mode=dio
habitatcontrol.build.flash_flags=-DFLASHMODE_DIO
habitatcontrol.build.flash_freq=40
habitatcontrol.menu.eesz.4M2M=4MB (FS:2MB OTA:~1019KB)
habitatcontrol.menu.eesz.4M2M.build.flash_size=4M
habitatcontrol.menu.eesz.4M2M.build.flash_size_bytes=0x400000
habitatcontrol.menu.eesz.4M2M.build.flash_ld=eagle.flash.4m2m.ld
habitatcontrol.menu.eesz.4M2M.build.spiffs_pagesize=256
habitatcontrol.menu.eesz.4M2M.upload.maximum_size=1044464
habitatcontrol.menu.eesz.4M2M.build.rfcal_addr=0x3FC000
habitatcontrol.menu.eesz.4M2M.build.spiffs_start=0x200000
habitatcontrol.menu.eesz.4M2M.build.spiffs_end=0x3FA000
habitatcontrol.menu.eesz.4M2M.build.spiffs_blocksize=8192
habitatcontrol.menu.eesz.4M3M=4MB (FS:3MB OTA:~512KB)
habitatcontrol.menu.eesz.4M3M.build.flash_size=4M
habitatcontrol.menu.eesz.4M3M.build.flash_size_bytes=0x400000
habitatcontrol.menu.eesz.4M3M.build.flash_ld=eagle.flash.4m3m.ld
habitatcontrol.menu.eesz.4M3M.build.spiffs_pagesize=256
habitatcontrol.menu.eesz.4M3M.upload.maximum_size=1044464
habitatcontrol.menu.eesz.4M3M.build.rfcal_addr=0x3FC000
habitatcontrol.menu.eesz.4M3M.build.spiffs_start=0x100000
habitatcontrol.menu.eesz.4M3M.build.spiffs_end=0x3FA000
habitatcontrol.menu.eesz.4M3M.build.spiffs_blocksize=8192
habitatcontrol.menu.eesz.4M1M=4MB (FS:1MB OTA:~1019KB)
habitatcontrol.menu.eesz.4M1M.build.flash_size=4M
habitatcontrol.menu.eesz.4M1M.build.flash_size_bytes=0x400000
habitatcontrol.menu.eesz.4M1M.build.flash_ld=eagle.flash.4m1m.ld
habitatcontrol.menu.eesz.4M1M.build.spiffs_pagesize=256
habitatcontrol.menu.eesz.4M1M.upload.maximum_size=1044464
habitatcontrol.menu.eesz.4M1M.build.rfcal_addr=0x3FC000
habitatcontrol.menu.eesz.4M1M.build.spiffs_start=0x300000
habitatcontrol.menu.eesz.4M1M.build.spiffs_end=0x3FA000
habitatcontrol.menu.eesz.4M1M.build.spiffs_blocksize=8192
habitatcontrol.menu.eesz.4M=4MB (FS:none OTA:~1019KB)
habitatcontrol.menu.eesz.4M.build.flash_size=4M
habitatcontrol.menu.eesz.4M.build.flash_size_bytes=0x400000
habitatcontrol.menu.eesz.4M.build.flash_ld=eagle.flash.4m.ld
habitatcontrol.menu.eesz.4M.build.spiffs_pagesize=256
habitatcontrol.menu.eesz.4M.upload.maximum_size=1044464
habitatcontrol.menu.eesz.4M.build.rfcal_addr=0x3FC000
habitatcontrol.menu.led.2=2
habitatcontrol.menu.led.2.build.led=-DLED_BUILTIN=2
habitatcontrol.menu.ip.lm2f=v2 Lower Memory
habitatcontrol.menu.ip.lm2f.build.lwip_include=lwip2/include
habitatcontrol.menu.ip.lm2f.build.lwip_lib=-llwip2-536-feat
habitatcontrol.menu.ip.lm2f.build.lwip_flags=-DLWIP_OPEN_SRC -DTCP_MSS=536 -DLWIP_FEATURES=1 -DLWIP_IPV6=0
habitatcontrol.menu.ip.hb2f=v2 Higher Bandwidth
habitatcontrol.menu.ip.hb2f.build.lwip_include=lwip2/include
habitatcontrol.menu.ip.hb2f.build.lwip_lib=-llwip2-1460-feat
habitatcontrol.menu.ip.hb2f.build.lwip_flags=-DLWIP_OPEN_SRC -DTCP_MSS=1460 -DLWIP_FEATURES=1 -DLWIP_IPV6=0
habitatcontrol.menu.ip.lm2n=v2 Lower Memory (no features)
habitatcontrol.menu.ip.lm2n.build.lwip_include=lwip2/include
habitatcontrol.menu.ip.lm2n.build.lwip_lib=-llwip2-536
habitatcontrol.menu.ip.lm2n.build.lwip_flags=-DLWIP_OPEN_SRC -DTCP_MSS=536 -DLWIP_FEATURES=0 -DLWIP_IPV6=0
habitatcontrol.menu.ip.hb2n=v2 Higher Bandwidth (no features)
habitatcontrol.menu.ip.hb2n.build.lwip_include=lwip2/include
habitatcontrol.menu.ip.hb2n.build.lwip_lib=-llwip2-1460
habitatcontrol.menu.ip.hb2n.build.lwip_flags=-DLWIP_OPEN_SRC -DTCP_MSS=1460 -DLWIP_FEATURES=0 -DLWIP_IPV6=0
habitatcontrol.menu.dbg.Disabled=Disabled
habitatcontrol.menu.dbg.Disabled.build.debug_port=
habitatcontrol.menu.lvl.None____=None
habitatcontrol.menu.wipe.none=Only Sketch
habitatcontrol.menu.wipe.none.upload.erase_cmd=
habitatcontrol.menu.wipe.sdk=Sketch + WiFi Settings
habitatcontrol.menu.wipe.sdk.upload.erase_cmd=erase_region "{build.rfcal_addr}" 0x4000
habitatcontrol.menu.wipe.all=All Flash Contents
habitatcontrol.menu.wipe.all.upload.erase_cmd=erase_flash
habitatcontrol.menu.baud.3000000=3000000
habitatcontrol.menu.baud.3000000.upload.speed=3000000
habitatcontrol.menu.baud.921600=921600
habitatcontrol.menu.baud.921600.upload.speed=921600

##############################################################'

################################### Update Compiler ###################################
Remove-Item -Recurse -Force -Path $espBetaPath\*\tools\dist # if dist alrealy exists the .py script breaks
Set-Location $espBetaPath\esp8266\tools\
Start-Process -FilePath python -Wait get.py
Set-Location $espBetaPath\esp32\tools\
Start-Process -FilePath get.exe -Wait 
Remove-Item -Recurse -Force -Path $espBetaPath\*\tools\dist # delete after use
#######################################################################################

Copy-Item -Recurse -Force -Path $arduinoBetaPath\* -Destination $arduinoGitPath -Exclude ".gitignore",".gitmodules" # move new files to repo
Copy-Item -Recurse -Force -Path $arduinoMyConfigPath\* -Destination $arduinoGitPath 

# Delete all files that cause git sync problems
Remove-Item -Recurse -Force -Path $espGitPath\*\.git
Remove-Item -Recurse -Force -Path $espGitPath\*\.github
Remove-Item -Recurse -Force -Path $espGitPath\*\tools\dist # just to be sure no dist has come through


$fileContent = Get-Content $boardBetaPath
$fileContent[((Get-Content $boardGitPath | Select-String -SimpleMatch -Pattern "##############################################################").LineNumber | select-object -First 1)-1] += $habitatcontrolboard
$fileContent | Set-Content $boardGitPath

Write-Host "Ready to commit!"
Pause
Exit