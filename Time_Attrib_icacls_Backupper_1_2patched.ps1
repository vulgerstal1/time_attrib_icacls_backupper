#vulgerstal's taicacls_b (timestamp, attribute, icacls backupper) 15g24 7:25p
Read-Host 'ONE PIECE OF THIS SCRIPT (ICACLS RESTORATION) REQUIRES YOU TO BE ADMINISTRATOR - RERUN AS ADMINSTATOR, IF YOU NEED THAT FUNCTIONALITY FULLY AVAILABLE AND OPERATIONAL'
#================================================================== SETTINGS ===================================================================================================================
$Log_default = 'C:\Dev_Tests\time_attrib_icacls_backups\taicacls_lastSession.vlog'
$SingleFile_bool = $false
$Target_default = 'C:\Dev_Unity_Projects'
$ContentToPick_default = '*.*'
$BackupTimeAndAttributes_default = 'C:\Dev_Tests\time_attrib_icacls_backups\BackupTIMESTAMPandATTRIBUTE.vtab'
$BackupSecurity_default = 'C:\Dev_Tests\time_attrib_icacls_backups\BackupICACLS.vicb'
$Log = Read-Host "Set Log, or LEAVE EMPTY and PRESS ENTER for $Log_default"
if($Log -eq '') { $Log = $Log_default }
Start-Transcript $Log
$SingleFile = Read-Host "If its going to be SINGLE file - ENTER ANYTHING and PRESS ENTER - then set FULL PATH AS TARGET, default mask"
if($SingleFile -ne '') { $SingleFile_bool = $true }
$Target = Read-Host "Set Target, or LEAVE EMPTY and PRESS ENTER for $Target_default"
if($Target -eq '') { $Target = $Target_default }
$ContentToPick = Read-Host "Set ContentToPick, or LEAVE EMPTY and PRESS ENTER for $ContentToPick_default . (WARNING! Set-Location WON'T FIND FOLDERS THAT START WITH ."
if($ContentToPick -eq '') { $ContentToPick = $ContentToPick_default}
$BackupTimeAndAttributes = Read-Host "Set BackupTimeAndAttributes, or PRESS ENTER for $BackupTimeAndAttributes_default"
if($BackupTimeAndAttributes -eq '') { $BackupTimeAndAttributes = $BackupTimeAndAttributes_default }
$BackupSecurity = Read-Host "Set BackupSecurity, or LEAVE EMPTY and PRESS ENTER for $BackupSecurity_default"
if($BackupSecurity -eq '') { $BackupSecurity = $BackupSecurity_default }
if($SingleFile_bool -eq $false) { Set-Location $Target } else { Set-Location (Split-Path $Target -Parent) }
$userRequest = Read-Host "PRESS ENTER ANYTHING and PRESS ENTER to BACKUP"
if($userRequest -ne '')
{	
	$userRequest = ''	
	Get-Item $Target -force -Filter $ContentToPick | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes | Export-Csv -NoTypeInformation $BackupTimeAndAttributes
	if($SingleFile_bool -eq $false) { Get-ChildItem $Target -recurse -Force -Filter $ContentToPick | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes | Export-Csv -NoTypeInformation -append $BackupTimeAndAttributes }
	$csv = Import-Csv -path $BackupTimeAndAttributes
	($csv) | ForEach { $_.FullName = (Get-Item $_.FullName -force| Resolve-Path -Relative) }
	$csv | Export-Csv $BackupTimeAndAttributes -NoType
	$BackupTimeAndAttributes_renamed = join-path ([system.io.fileinfo]$BackupTimeAndAttributes).DirectoryName ([system.io.fileinfo]$BackupTimeAndAttributes).BaseName
	$timeNow = (get-date -format yyyyMMdd_HHmmss)
	$BackupTimeAndAttributes_renamed = -join($BackupTimeAndAttributes_renamed,"_")
	$BackupTimeAndAttributes_renamed = -join($BackupTimeAndAttributes_renamed,$timeNow,[System.IO.Path]::GetExtension($BackupTimeAndAttributes));
	Rename-Item -Path $BackupTimeAndAttributes -NewName ([System.IO.Path]::GetFileNameWithoutExtension($BackupTimeAndAttributes) + "_" + $timeNow + ([System.IO.Path]::GetExtension($BackupTimeAndAttributes)))
	icacls $Target /save $BackupSecurity /t /c
	$BackupSecurity_renamed = join-path ([system.io.fileinfo]$BackupSecurity).DirectoryName ([system.io.fileinfo]$BackupSecurity).BaseName
	$timeNow = (get-date -format yyyyMMdd_HHmmss)
	$BackupSecurity_renamed = -join($BackupSecurity_renamed,"_")
	$BackupSecurity_renamed = -join($BackupSecurity_renamed,$timeNow,[System.IO.Path]::GetExtension($BackupSecurity));
	Rename-Item -Path $BackupSecurity -NewName ([System.IO.Path]::GetFileNameWithoutExtension($BackupSecurity) + "_" + $timeNow + ([System.IO.Path]::GetExtension($BackupSecurity)))
}
$userRequest = Read-Host "ENTER ANYTHING and PRESS ENTER to RESTORE"
if($userRequest -ne '')
{	
	$userRequest = ''
	if($BackupTimeAndAttributes_renamed -ne '')
	{
		$BackupTimeAndAttributes = Read-Host "Set $BackupTimeAndAttributes, or LEAVE EMPTY and PRESS ENTER for $BackupTimeAndAttributes_renamed or PRESS SPACE and ENTER for $BackupTimeAndAttributes_default"
		if($BackupTimeAndAttributes -eq '') { $BackupTimeAndAttributes = $BackupTimeAndAttributes_renamed }
		if($BackupTimeAndAttributes -eq ' ') { $BackupTimeAndAttributes = $BackupTimeAndAttributes_default }
	}
	else
	{
		$BackupTimeAndAttributes = Read-Host "Set $BackupTimeAndAttributes, or LEAVE EMPTY and PRESS ENTER for $BackupTimeAndAttributes_default"
		if($BackupTimeAndAttributes -eq '') { $BackupTimeAndAttributes = $BackupTimeAndAttributes_default }
	}
	if($BackupSecurity_renamed -ne '')
	{
		$BackupSecurity = Read-Host "Set $BackupSecurity, or LEAVE EMPTY and PRESS ENTER for $BackupSecurity_renamed or PRESS SPACE and ENTER for $BackupSecurity_default"
		if($BackupSecurity -eq '') { $BackupSecurity = $BackupSecurity_renamed }
		if($BackupSecurity -eq ' ') { $BackupSecurity = $BackupSecurity_default }
	}
	else
	{
		$BackupSecurity = Read-Host "Set $BackupSecurity, or LEAVE EMPTY and PRESS ENTER for $BackupSecurity_default"
		if($BackupSecurity -eq '') { $BackupSecurity = $BackupSecurity_default }
	}	
	$csv = Import-Csv $BackupTimeAndAttributes
	foreach($line in $csv)
	{ 
		$properties = $line | Get-Member -MemberType Properties
		for($i=0; $i -lt $properties.Count;$i++)
		{
			$column = $properties[$i]
			$columnvalue = $line | Select -ExpandProperty $column.Name	
			if($column.Name -eq "FullName")
			{		
				if($columnvalue)
				{							
					if((Test-Path $LINE.fullname -PathType Leaf) -eq $true) { Set-ItemProperty -Path $LINE.fullname -name IsReadOnly -value $false }
					Set-ItemProperty $LINE.fullname -Name CreationTime -Value $LINE.CreationTime -Force
					Set-ItemProperty $LINE.fullname -Name LastWriteTime -Value $LINE.LastWriteTime -Force
					Set-ItemProperty $LINE.fullname -Name LastAccessTime -Value $LINE.LastAccessTime -Force
					$a = Get-Item $LINE.fullname -force
					$a.attributes = $LINE.Attributes	
				}	
			}
		}
	}
	$Target_now = $Target
	$Target = Read-Host "Set Target, or LEAVE EMPTY and PRESS ENTER for $Target_default or PRESS SPACE and ENTER for $Target"
	if($Target -eq '') { $Target = $Target_default }
	if($Target -eq ' ') { $Target = $Target_now }		
	icacls (Split-Path -parent $Target) /restore $BackupSecurity /t /c
}
Read-Host 'THANKS FOR USING MY FIRST POWERSHELL AND SECOND GITHUB PROJECT. THE INTENTION IS TO RESTORE FILE ECOSYSTEM AFTER GIT CLONE DESYNC MESS'