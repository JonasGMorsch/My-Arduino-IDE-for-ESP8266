if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator) -eq $false) 
{
    Start-Process powershell.exe -WindowStyle Maximized -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))    
    exit
}

# Run this as Administrator or a user with write permissions to the GitHubDesktop AppData folder

New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -PropertyType DWord -Value 1 -Force

# Get current user
$User = [Environment]::UserName
$LocalApp = [Environment]::GetFolderPath("LocalApplicationData")

# Pattern to find GitHubDesktop versions
$GHDesktopPath = Join-Path $LocalApp "GitHubDesktop"

if (!(Test-Path $GHDesktopPath)) 
{
    Write-Error "GitHubDesktop folder not found in $LocalApp"
    exit 1
}

# Find all versioned "app-*" folders
$appDirs = Get-ChildItem -Path $GHDesktopPath -Directory | Where-Object { $_.Name -like "app-*" }

if ($appDirs.Count -eq 0) 
{
    Write-Error "No 'app-<version>' folders found under $GHDesktopPath"
    exit 1
}

# For each app version, modify the etc\gitconfig file
foreach ($app in $appDirs) 
{
    $gitEtcPath = Join-Path $app.FullName "resources\app\git\etc\gitconfig"
    if (!(Test-Path $gitEtcPath)) 
    {
        Write-Warning "gitconfig not found at $gitEtcPath, skipping version $($app.Name)"
        continue
    }

    Write-Output "Processing gitconfig at: $gitEtcPath"

    # Read all lines
    $content = Get-Content -Raw -Path $gitEtcPath

    # Check if [core] section exists
    if ($content -match '^\s*\[core\]\s*') 
    {
        # core section exists: see if longpaths already set
        if ($content -match '(?ms)^\s*\[core\].*?longpaths\s*=') 
        {
            Write-Output " ‣ core.longpaths already set. Checking value..."

            # If already set but false or some other thing, change to true
            $newContent = $content -replace '(?ms)(^\s*\[core\].*?longpaths\s*=\s*)(false|no|\S+)', '${1}true'
            if ($newContent -ne $content) 
            {
                $newContent | Set-Content -Path $gitEtcPath -Encoding UTF8
                Write-Output " ‣ core.longpaths changed to true"
            } 
            else 
            {
                Write-Output " ‣ Already true; no change needed"
            }
        } 
        else 
        {
            # core exists but no longpaths setting; add it
            # Insert after [core] line
            $lines = Get-Content -Path $gitEtcPath
            for ($i=0; $i -lt $lines.Count; $i++) 
            {
                if ($lines[$i] -match '^\s*\[core\]\s*$') 
                {
                    # Insert next line
                    $inserted = $false
                    $before = $lines[0..$i]
                    $after = $lines[($i+1)..($lines.Count - 1)]
                    $newLines = $before + "    longpaths = true" + $after
                    $newLines | Set-Content -Path $gitEtcPath -Encoding UTF8
                    Write-Output " ‣ Added ‘longpaths = true’ under core section"
                    $inserted = $true
                    break
                }
            }
            if (-not $inserted) 
            {
                Write-Warning " ‣ Couldn't insert longpaths; core section found but pattern mismatch"
            }
        }
    } 
    else 
    {
        # No core section: append core section at end
        $append = @()
        $append += ""
        $append += "[core]"
        $append += "    longpaths = true"
        Add-Content -Path $gitEtcPath -Value $append -Encoding UTF8
        Write-Output " ‣ Added core section with longpaths = true at end of file"
    }
}

Write-Output "Done."
pause