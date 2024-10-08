#timestamp, attribute, icacls backupper - 7o2024 1:30 MANUAL : admin's powershell -ExecutionPolicy Bypass -File "C:\Dev_Tests\time_attrib_icacls_backupper\VTAIB-er_1_54.ps1" -File "C:\Dev_Tests\time_attrib_icacls_backupper\VTAIB-er_1_54.ps1" -noexit
$vtaib_version = '1.54'
$gitHubBytesPerFileLimit = 100000000
Read-Host ('VULGERSTAL TAiCACLS '+$vtaib_version+' : ICACLS RESTORATION REQUIRES ADMIN - RERUN IF NEED FUNCTIONALITY FULLY AVAILABLE AND OPERATIONAL')
Start-Transcript ((Join-Path $PSScriptRoot ('vtaib_'+$vtaib_version+'_session_'))+(Get-Date -Format "yyyyMMdd_HHmmss") + ".vlog")
$Target_default = 'C:\Dev_Unity_Projects\game_press'
$Target = Read-Host "Set Target, or LEAVE EMPTY and PRESS ENTER for $Target_default"
if($Target -eq '') { $Target = $Target_default }
cd $Target
$BackupTimeAndAttributes = Join-Path $PSScriptRoot 'vtab.vtab'
$BackupSecurity = Join-Path $PSScriptRoot 'vicb.vicb'
$tempFile = Join-Path $PSScriptRoot 'vt2b.vt2b'
$git_default = 'C:\Users\vulge\AppData\Local\GitHubDesktop\app-3.4.6\resources\app\git\cmd\git.exe'
$git = Read-Host "Set GIT EXE, or LEAVE EMPTY and PRESS ENTER for $git_default"
if($git -eq '') { $git = $git_default }
$git_branch_default = 'vtaib'
$git_branch = Read-Host "Set GIT BRANCH, or LEAVE EMPTY and PRESS ENTER for $git_branch_default"
if($git_branch -eq '') { $git_branch = $git_branch_default }
$userRequest = Read-Host "BACKUP - 0, RESTORE - 1"
if($userRequest -eq '0')
{	
	Write-Host("STARTED. NOW STARTED TO GET META : " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$test = Get-Item $Target -force | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes
	($test) | ForEach { $_.FullName = (Get-Item $_.FullName -force| Resolve-Path -Relative) }
	$test2 = Get-ChildItem $Target -recurse -Force | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes
	($test2) | ForEach { $_.FullName = (Get-Item $_.FullName -force| Resolve-Path -Relative) }
	Write-Host("Remembered META, NOW SAVING.." + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$test | Export-Csv $BackupTimeAndAttributes -NoType
	$test2 | Export-Csv $BackupTimeAndAttributes -NoType -Append
	Write-Host("Saved META. Now renaming according to naming convention " + (get-date -format yyyyMMdd_HHmmss))  -ForegroundColor Green	
	$BackupTimeAndAttributes_renamed = join-path ([system.io.fileinfo]$BackupTimeAndAttributes).DirectoryName ([system.io.fileinfo]$BackupTimeAndAttributes).BaseName
	$timeNow = (get-date -format yyyyMMdd_HHmmss)
	$BackupTimeAndAttributes_renamed = -join($BackupTimeAndAttributes_renamed,"_")
	$BackupTimeAndAttributes_renamed = -join($BackupTimeAndAttributes_renamed,$timeNow,'_v',$vtaib_version,'_',[System.IO.Path]::GetExtension($BackupTimeAndAttributes));
	Rename-Item -Path $BackupTimeAndAttributes -NewName ([System.IO.Path]::GetFileNameWithoutExtension($BackupTimeAndAttributes) + "_" + $timeNow +'_v'+ $vtaib_version + '_' +([System.IO.Path]::GetExtension($BackupTimeAndAttributes)))		
	Write-Host("Renamed META according to naming convention. NOW GETTING SECURITY.. " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	icacls (Get-Item $Target -Force -Filter $ContentToPick) /save $BackupSecurity /t /c
	Write-Host("Saved SECURITY. Now renaming according to naming convention " + (get-date -format yyyyMMdd_HHmmss))  -ForegroundColor Green
	$BackupSecurity_renamed = join-path ([system.io.fileinfo]$BackupSecurity).DirectoryName ([system.io.fileinfo]$BackupSecurity).BaseName
	$timeNow = (get-date -format yyyyMMdd_HHmmss)
	$BackupSecurity_renamed = -join($BackupSecurity_renamed,"_")
	$BackupSecurity_renamed = -join($BackupSecurity_renamed,$timeNow,'_v',$vtaib_version,'_',[System.IO.Path]::GetExtension($BackupSecurity));
	Rename-Item -Path $BackupSecurity -NewName ([System.IO.Path]::GetFileNameWithoutExtension($BackupSecurity) + "_" + $timeNow +'_v'+ $vtaib_version + '_' +([System.IO.Path]::GetExtension($BackupSecurity)))
	Write-Host("Renamed SECURITY according to naming convention. Now getting root, and if present, 100+ file and their roots META.. " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$100mbs =      Get-ChildItem $Target -Recurse | Where-Object Length -gt $gitHubBytesPerFileLimit | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes
	$100mbsRoots = Get-ChildItem $Target -Recurse | Where-Object Length -gt $gitHubBytesPerFileLimit | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes
	($100mbs)      | ForEach { $_.FullName = (Get-Item             $_.FullName          -force| Resolve-Path -Relative) }
	($100mbsRoots) | ForEach { $_.FullName = (Get-Item (Split-Path $_.FullName -parent) -force| Resolve-Path -Relative) }
	$emptyDirs =      Get-ChildItem -Path $target -Recurse -Directory| Where-Object -FilterScript {($_.GetFiles().Count -eq 0) -and ($_.GetDirectories().Count -eq 0) } | Select-Object -Property FullName, CreationTime, LastWriteTime, LastAccessTime, Attributes
	($emptyDirs)      | ForEach { $_.FullName = (Get-Item             $_.FullName          -force| Resolve-Path -Relative) }
	Write-Host("Remembered root,100+mb(s)+root(s)'* and empty folder(s)'* META, since backupper temporarily alters that to help You if You've 100+mb file or empty folder which isnt allowed in github free / git generally (*-if following exist) " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("STARTED TO SAVE that in " + $tempFile + " " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$test  | Export-Csv $tempFile -NoType
	$100mbsRoots  | Export-Csv $tempFile -NoType -Append
	$100mbs  | Export-Csv $tempFile -NoType -Append
	$emptyDirs  | Export-Csv $tempFile -NoType -Append
	Write-Host("Saved root,100+mb(s)+root(s)' and empty directories META, to restore them after backupper alters them temporarily soon. Saved in " +$PSScriptRoot+ " on " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("Now getting ready to pack 100+mbs if such present" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$100mbs  = Get-ChildItem $Target -Recurse | Where-Object Length -gt $gitHubBytesPerFileLimit
	Write-Host("packing if such present.. (if no blue messagee above then not present, or too quick) " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	($100mbs) | ForEach-Object -Process { Compress-Archive -Force -DestinationPath ((Join-Path $_.Directory $_.Name)+'v100+m.zip') $_.FullName }
	($100mbs) | Where-Object { $_.FullName -notlike "*v100+m.zip" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host("Packed 100mb(s) alongside their original(s) - and deleted unpacked original(s) - to pass GitHub's 100MB per file-upload limit on FREE plan" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	($emptyDirs) | ForEach-Object -Process { New-Item -Path $_.FullName -Name .gitkeepVUL -ItemType "file" }
	Write-Host("Created temporary file inside each EMPTY folder so GIT would accept them" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Copy-Item $BackupTimeAndAttributes_renamed -Destination $Target
	Copy-Item $BackupSecurity_renamed -Destination $Target
	Write-Host("Copied backup to root from working dir" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("Checking whether there are any 100_mb files after packing.." + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$pass = '1'
	$100mbs = Get-ChildItem $Target -Recurse | Where-Object Length -gt $gitHubBytesPerFileLimit
	($100mbs) | ForEach-Object -Process { $pass = '0' }
	if($pass -eq '1')
	{
		Write-Host("READY TO PUSH, since no >100 mb file found and all Your files will be accepted by GitHub on FREE plan") -ForegroundColor Green*
		& $git checkout $git_branch
		& $git add .
		& $git commit -a -m ("committed from VTAIB v." + $vtaib_version + " on " + (get-date -format yyyyMMdd_HHmmss))
		& $git push --force	
	}
	else
	{
		Write-Host("REVERTiNG TO PREBACKUP STATE (reason : 100+mb(s) found (GitHub's FREE plan doesnt allow that!) : >> " + $100mbs + " : " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Red
	}	
	($emptyDirs)   | ForEach-Object -Process { Remove-Item (Join-Path $_.FullName ".gitkeepVUL") }
	Get-ChildItem $Target | Where-Object { $_.FullName -like "*.v*b" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host("Removing temp file from each previously empty folder. META of these empty folders to be restored soon. (Reminder: those empty files were needed so GIT would accept EMPTY folder)" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("REVERTiNG TO PREBACKUP STATE " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Get-ChildItem $Target -Recurse | Where-Object { $_.FullName -like "*v100+m.zip" } | ForEach-Object -Process { Expand-Archive $_.FullName -DestinationPath $_.Directory }
	Get-ChildItem $Target -Recurse | Where-Object { $_.FullName -like "*v100+m.zip" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host("Unpacked 100mbs and removed packed" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("ENSURE TARGET'S UNLOCKED. CHECK FROM PARENT. IF LOCKED - TIMESTAMP(S) OR/AND ATTRIBUTE(S) WON'T BE SET") -ForegroundColor Red
	Read-Host("!!!")
	foreach($line in (Import-Csv $tempFile))
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
					if((Test-Path $LINE.fullname ) -eq $true)
					{		
						Set-ItemProperty $LINE.fullname -Name CreationTime -Value $LINE.CreationTime -Force
						Set-ItemProperty $LINE.fullname -Name LastWriteTime -Value $LINE.LastWriteTime -Force
						Set-ItemProperty $LINE.fullname -Name LastAccessTime -Value $LINE.LastAccessTime -Force
						$a = Get-Item $LINE.fullname -force
						$a.attributes = $LINE.Attributes
					}
				}	
			}
		}
	}
	Remove-Item $BackupTimeAndAttributes_renamed
	Remove-Item $BackupSecurity_renamed
	Remove-Item $tempFile
	Write-Host("PRE-BACKUP STATE REVERTED (IF You didnt touch affected data in process)" + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host('DONE ...Blue Color for You to remember when You see it next, that everything ended succesfully...'  + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green -BackgroundColor White
}
if($userRequest -eq '1')
{	
	$git_user_default = 'vulgerstal1'
	$git_user = Read-Host "Set GIT USER !It's You! , or LEAVE EMPTY and PRESS ENTER for $git_user_default"
	if($git_user -eq '') { $git_user = $git_user_default }
	$git_repo_owner_default = 'vulgerstal1'
	$git_repo_owner = Read-Host "Set GIT REPO OWNER, or LEAVE EMPTY and PRESS ENTER for $git_repo_owner_default"
	if($git_repo_owner -eq '') { $git_repo_owner = $git_repo_owner_default }
	$git_repo_default = 'game_press'
	$git_repo = Read-Host "Set GIT REPO, or LEAVE EMPTY and PRESS ENTER for $git_repo_default"
	if($git_repo -eq '') { $git_repo = $git_repo_default }
	Write-Host('CLONING STARTED ' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	& $git clone -b $git_branch --single-branch ('https://'+$git_user+'@github.com/'+$git_repo_owner+'/'+$git_repo+'.git') .
	Get-ChildItem $Target -Recurse | Where-Object { $_.FullName -like "*.gitkeepVUL" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host('Removed temporary file in each previously empty folder. Reminder : such file was needed so git would accept empty folder. META of such folders to be restored soon' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Get-ChildItem $Target -Recurse | Where-Object { $_.FullName -like "*v100+m.zip" } | ForEach-Object -Process { Expand-Archive $_.FullName -DestinationPath $_.Directory }
	Get-ChildItem $Target -Recurse | Where-Object { $_.FullName -like "*v100+m.zip" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host('UNPACKED 100+MB(S) AND REMOVED PACK(S)' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	$AutoSearch_VTAB = Get-ChildItem $Target -Filter *.vtab
	$AutoSearch_VICB = Get-ChildItem $Target -Filter *.vicb
	Copy-Item $AutoSearch_VTAB -Destination $PSScriptRoot
	Copy-Item $AutoSearch_VICB -Destination $PSScriptRoot
	$AutoSearch_VTAB = Join-Path $PSScriptRoot $AutoSearch_VTAB.name
	$AutoSearch_VICB = Join-Path $PSScriptRoot $AutoSearch_VICB.name
	Get-ChildItem $Target | Where-Object { $_.FullName -like "*.v*b" } | ForEach-Object -Process { Remove-Item $_.FullName }
	Write-Host('MOVED BACKUP TO WORKING DIRECTORY TO NOT AFFECT PROJECT ECOSYSTEM IN THE END OF RESTORATION ' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	Write-Host("ENSURE TARGET'S UNLOCKED. CHECK FROM PARENT. IF LOCKED - TIMESTAMP(S) OR/AND ATTRIBUTE(S) WON'T BE SET") -ForegroundColor Red
	Read-Host("!!!")
	Write-Host('STARTED SETTING TIMES AND ATTRIBUTES.. ' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
	if($AutoSearch_VTAB -and (Test-Path $AutoSearch_VTAB) -and $AutoSearch_VICB -and (Test-Path $AutoSearch_VICB))
	{	
		foreach($line in (Import-Csv $AutoSearch_VTAB))
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
						if((Test-Path $LINE.fullname ) -eq $true)
						{
							Set-ItemProperty $LINE.fullname -Name CreationTime -Value $LINE.CreationTime -Force
							Set-ItemProperty $LINE.fullname -Name LastWriteTime -Value $LINE.LastWriteTime -Force
							Set-ItemProperty $LINE.fullname -Name LastAccessTime -Value $LINE.LastAccessTime -Force
							$a = Get-Item $LINE.fullname -force
							$a.attributes = $LINE.Attributes
						}
					}	
				}
			}
		}
		Write-Host("STARTED RESTORING SECURITY.. " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green
		icacls (Split-Path -parent $Target) /restore $AutoSearch_VICB /t /c	/q
		Write-Host("SECURITY RESTORED " + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green		
		Remove-Item $AutoSearch_VTAB
		Remove-Item $AutoSearch_VICB
		Write-Host('REMOVED BACKUP COMPLETELY (CLEANED AFTER WORK) ' + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Green	
		Write-Host('DONE ...Blue Color for You to remember when You see it next, that everything ended succesfully...'  + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Blue -BackgroundColor White
	}
	else
	{
		Write-Host("BACKUP FOUND TO BE EITHER ABSENT OR NOT FULL. EXITING.." + (get-date -format yyyyMMdd_HHmmss)) -ForegroundColor Red	
	}
}
Write-Host 'THANKS FOR USING MY FIRST POWERSHELL AND SECOND GITHUB PROJECT. THE INTENTION IS TO RESTORE FILE ECOSYSTEM AFTER GIT CLONE DESYNC MESS youtube.com/vulgerstal'