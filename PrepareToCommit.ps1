$arduinoBetaPath = "C:\Development\My-Arduino-IDE-for-ESP8266-ALPHA"
$espBetaPath = "$arduinoBetaPath\hardware\espressif"

$arduinoGitPath = "C:\Portable_Programs\My-Arduino-IDE-for-ESP8266"
$espGitPath = "$arduinoGitPath\hardware\espressif"

$arduinoMyConfigPath = "C:\Development\My-Arduino-IDE-CONFIGS"
 
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

Write-Host "Ready to commit!"
Pause
Exit