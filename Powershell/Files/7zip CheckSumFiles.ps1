# CheckSum files


function Hash-Object([switch]$inputObject,$io) {
	BEGIN {
		if ($inputObject) {$io | &($MyInvocation.InvocationName) $args; break;}
		$args = @($io) + $args
		Write-host "Begin $args"
		}
	PROCESS {
		$Algorithm = $args[0]
		if($_.PsIsContainer -eq $false){
			$fs = new-object System.IO.FileStream $_.FullName, "Open";
			$algo = [type]"System.Security.Cryptography.$Algorithm";
			$crypto = $algo::Create();
			$hash = [BitConverter]::ToString($crypto.ComputeHash($fs)).Replace("-", "");
			$fs.Close();
		}
		else
		{
			$hash="IsDirectory";
		}
		$_.FullName + " : " + $hash
	}
	END {}
}

cls

$hashAlgo = "sha1"

$BasePath = "d:\.Work\Release\";
$BackupPath = "$BasePath\Backup\";

$IncomePath = "$BasePath\Income\";
$OutcomePath = "$BasePath\Outcome\";
$ArchivePath = "$BasePath\Archive\";

$Income_Back = "$BackupPath\Income\";
$Outcome_Back = "$BackupPath\Outcome\";


Write-Host "=====================Checksum Start!"
Write-Host $(Get-Date)
Write-Host "=====================Checksum Start!"


# Составляем список всех файлов

Get-ChildItem $IncomePath -Recurse	|%{$_.FullName}| Out-File "IncomePath.Files.txt"
Get-ChildItem $OutcomePath -Recurse	|%{$_.FullName}| Out-File "OutcomePath.Files.txt"

Get-ChildItem $ArchivePath -Recurse	|%{$_.FullName}| Out-File "ArchivePath.Files.txt"

Get-ChildItem $Income_Back -Recurse	|%{$_.FullName}| Out-File "Income_Back.Files.txt"
Get-ChildItem $Outcome_Back -Recurse|%{$_.FullName}| Out-File "Outcome_Back.Files.txt"
Write-Host "=====File List Done!"

#Снимаем Контрольную сумму

Get-ChildItem $IncomePath -Recurse	|Hash-Object $hashAlgo | Out-File "IncomePath.Files.Sha1.txt"
Get-ChildItem $OutcomePath -Recurse |Hash-Object $hashAlgo | Out-File "OutcomePath.Files.Sha1.txt"

Get-ChildItem $ArchivePath -Recurse	|Hash-Object $hashAlgo | Out-File "ArchivePath.Files.Sha1.txt"

Get-ChildItem $Income_Back	-Recurse|Hash-Object $hashAlgo | Out-File "Income_Back.Files.Sha1.txt"
Get-ChildItem $Outcome_Back -Recurse|Hash-Object $hashAlgo | Out-File "Outcome_Back.Files.Sha1.txt"

Write-Host "=====Hashes Done!"

Write-Host "=====================Checksum Done!"
Write-Host $(Get-Date)
Write-Host "=====================Checksum Done!"

