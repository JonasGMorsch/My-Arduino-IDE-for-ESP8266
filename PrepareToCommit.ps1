$arduinoBetaPath = "C:\Development\My-Arduino-IDE-for-ESP8266-ALPHA"
$espBetaPath = "$arduinoBetaPath\hardware\espressif"
$boardBetaPath ="$espBetaPath\esp8266\boards.txt"

$arduinoGitPath = "C:\Portable_Programs\My-Arduino-IDE-for-ESP8266"
$espGitPath = "$arduinoGitPath\hardware\espressif"
$boardGitPath ="$espGitPath\esp8266\boards.txt"

$arduinoMyConfigPath = "C:\Development\My-Arduino-IDE-CONFIGS"


$habitatcontrolboard ='
##############################################################
habitatcontrol.name= Habitat Control V2.1
habitatcontrol.upload.tool=esptool
habitatcontrol.upload.maximum_data_size=81920
habitatcontrol.upload.maximum_size=1044464
habitatcontrol.upload.wait_for_upload_port=false
habitatcontrol.upload.resetmethod=--before default_reset --after hard_reset
habitatcontrol.upload.erase_cmd=
habitatcontrol.serial.disableDTR=true
habitatcontrol.serial.disableRTS=true
habitatcontrol.build.debug_port= 
habitatcontrol.build.debug_level= 
habitatcontrol.build.board=ESP8266_habitatcontrol
habitatcontrol.build.variant=habitatcontrol
habitatcontrol.build.mcu=esp8266
habitatcontrol.build.core=esp8266
habitatcontrol.build.spiffs_pagesize=256
habitatcontrol.build.vtable_flags=-DVTABLES_IN_FLASH
habitatcontrol.build.stacksmash_flags=-fstack-protector
habitatcontrol.build.sslflags=-DBEARSSL_SSL_BASIC
habitatcontrol.build.flash_mode=dio
habitatcontrol.build.flash_flags=-DFLASHMODE_DIO
habitatcontrol.build.flash_freq=40
habitatcontrol.build.f_cpu=80000000L
habitatcontrol.build.lwip_include=lwip2/include
habitatcontrol.build.lwip_lib=-llwip2-1460-feat
habitatcontrol.build.lwip_flags=-DLWIP_OPEN_SRC -DTCP_MSS=1460 -DLWIP_FEATURES=1 -DLWIP_IPV6=0
habitatcontrol.build.flash_size=4M
habitatcontrol.build.flash_size_bytes=0x400000
habitatcontrol.build.flash_ld=eagle.flash.4m2m.ld
habitatcontrol.build.rfcal_addr=0x3FC000
habitatcontrol.build.spiffs_start=0x200000
habitatcontrol.build.spiffs_end=0x3FA000
habitatcontrol.build.spiffs_blocksize=8192
habitatcontrol.build.exception_flags=-fno-exceptions
habitatcontrol.build.stdcpp_lib=-lstdc++
habitatcontrol.build.mmuflags=-DMMU_IRAM_SIZE=0x8000 -DMMU_ICACHE_SIZE=0x8000
habitatcontrol.build.non32xferflags=
habitatcontrol.menu.wipe.none=Sketch
habitatcontrol.menu.wipe.none.upload.erase_cmd=
habitatcontrol.menu.wipe.sdk=Sketch + WiFi Settings
habitatcontrol.menu.wipe.sdk.upload.erase_cmd=erase_region "{build.rfcal_addr}" 0x4000
habitatcontrol.menu.wipe.all=Entire Flash 
habitatcontrol.menu.wipe.all.upload.erase_cmd=erase_flash
habitatcontrol.menu.baud.2000000=2000000
habitatcontrol.menu.baud.2000000.upload.speed=2000000
habitatcontrol.menu.baud.1000000=1000000
habitatcontrol.menu.baud.1000000.upload.speed=1000000
##############################################################'

Write-Host "Stoping Arduino Processes"
Stop-Process -Name mdns-discovery -ErrorAction SilentlyContinue
Stop-Process -Name arduino-builder -ErrorAction SilentlyContinue


Write-Host "Erasing Espressif path"
Remove-Item -Recurse -Force -Path $espGitPath

################################### Update Compiler ###################################
Write-Host "Updating GCC++ xtensa-lx106"
Remove-Item -Recurse -Force -Path $espBetaPath\*\tools\dist # if dist alrealy exists the .py script breaks
Set-Location $espBetaPath\esp8266\tools\
Start-Process -FilePath python -Wait get.py
Write-Host "Updating GCC++ xtensa-esp32"
Set-Location $espBetaPath\esp32\tools\
Start-Process -FilePath get.exe -Wait 
Remove-Item -Recurse -Force -Path $espBetaPath\*\tools\dist # delete after use
#######################################################################################

Write-Host "Copying Beta to Git Version"
Copy-Item -Recurse -Force -Path $arduinoBetaPath\* -Destination $arduinoGitPath -Exclude ".gitignore",".gitmodules" # move new files to repo

Write-Host "Removing Git Current Theme"
Remove-Item -Recurse -Force -Path $arduinoGitPath\lib\theme

Write-Host "Applying My Config Fixes"
Copy-Item -Recurse -Force -Path $arduinoMyConfigPath\* -Destination $arduinoGitPath 

# Delete all files that cause git sync problems
Write-Host "Removing .git .github and dist Folders"
Remove-Item -Recurse -Force -Path $espGitPath\*\.git
Remove-Item -Recurse -Force -Path $espGitPath\*\.github
Remove-Item -Recurse -Force -Path $espGitPath\*\tools\dist # just to be sure no dist has come through

Write-Host "Removing old FS uploader"
Remove-Item -Recurse -Force -Path $arduinoGitPath\tools\WiFi101
Remove-Item -Recurse -Force -Path $arduinoGitPath\tools\ESP8266FS

Write-Host "Editing boards.txt"
$fileContent = Get-Content $boardBetaPath
$fileContent[((Get-Content $boardGitPath | Select-String -SimpleMatch -Pattern "##############################################################").LineNumber | select-object -First 1)-1] += $habitatcontrolboard
$fileContent | Set-Content $boardGitPath

Write-Host "Ready to commit!"
Pause
Exit

