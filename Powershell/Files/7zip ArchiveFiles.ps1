# Archive files With Passwd

cls

$Zip7 = ".\7zip\7za.exe";
$zipSfx="7zCon.sfx"
$filePwd = "123456"

$BasePath = "d:\.Work\Release\";

$OutPath = "$BasePath\Zipped";
if((Test-Path $OutPath) -eq $false){New-Item -ItemType directory -Path $OutPath;}

$IncomePath = "$BasePath\Income\";
$OutcomePath = "$BasePath\Outcome\";

$ArchivePath = "$BasePath\Archive\";
$BackupPath = "$BasePath\Backup\";


Write-Host "=====================Archive Start!"
Write-Host $(Get-Date)
Write-Host "=====================Archive Start!"




# архивируем Income и Outcome
&"$Zip7" a -t7z "$OutPath\Income-files.exe" $IncomePath "-sfx$zipSfx" "-p$filePwd"
&"$Zip7" a -t7z "$OutPath\Outcome-files.exe" $OutcomePath "-sfx$zipSfx" "-p$filePwd"

Write-Host "=====Income+Outcome Packed!"

# архивируем Backup
&"$Zip7" a -t7z "$OutPath\Backup-files.exe" $BackupPath "-sfx$zipSfx" "-p$filePwd"
Write-Host "=====Backup Packed!"

# архивируем Archive
&"$Zip7" a -t7z "$OutPath\Archive-files.exe" $ArchivePath "-sfx$zipSfx" "-p$filePwd"
Write-Host "=====Archive Packed!"

Write-Host "=====================Archive Done!"
Write-Host $(Get-Date)
Write-Host "=====================Archive Done!"


