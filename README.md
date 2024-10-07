GIT TIME STAMP ( CREATION , MODIFICATION, ACCESS ) , ATTRIBUTES , SECURITY , EMPTY FOLDER - BACKUP AND RESTORATION + GITHUB 100 MB PER FILE UPLOAD ( ON FREE PLAN ) WORKAROUND. VERSION 1.54. FOR NOW IT IS LATEST.
I CREATED THIS SCRIPT FOR MYSELF SINCE AS OF 7 OCTOBER 2024 I NEVER FOUND ANYTHING THAT WOULD LET ME ( WINDOWS 10 ) RESTORE FILE/FOLDER INFO AFTER CLONING + I WANTED TO UPLOAD 100+ MB FILES ON GITHUB FREE PLAN ( UNITY 3D PROJECT INCLUDING LIBRARY , ETC ).

THIS IS HOW IT WORKS:

1. The Script creates the Detailed Log nearby the Script (itself) ------------- where it documents all the major activity (except myriads of successful operations, to not to overload the log) ------------- The Script moves backup files back and forth for case of unfinished operation (Power outage, etc).
2. You Set the Target (Directory which state You want to Backup/Restore) ------------- [I wrote this script for Unity Project, so I limited it to folder later on. Although in the beginning it had option to choose between modes : Everything, Folder Excluding Content, Content (but decided to focus on General Use Case).
3. You Set GIT.EXE and REPO BRANCH ------------- assuming that Your project is already has .git structure inside (hooked to Git remote repository to which You will backup up or from which You will restore to Your local copy).
4. You Select Action [ BACKUP* or RESTORE** ] - 0 for BACKUP*, 1 for RESTORE** ------------- Backup* with files/folders info, compressed 100+mb files, empty folders (with temp file inside) ; ------------- Restoration** by Cloning and setting backed up data back.

        IMPORTANT NOTES:
  A. I use it on my Windows 10 Machine, this script was made specifically to NOT REQUIRE ANY ADDITIONAL PLUGINS, DOWNLOADS, ETC. So You can just let* it run on Your machine without installing anything. I back up my Unity project with it all the time  ------------- IF YOU WILL FOLLOW ALL THE INSTRUCTIONS ON THE SCREEN - You will not have any problem.
  B. To let* it run on Your machine - You can use CMD.EXE where You enter the line which is shown in the VERY beginning of the script (commented with # symbol). Just replace the location of the script with Your own to let CMD run it for You.
  C. To unlock temporarily locked files/folder that must be unlocked for the Script to SET data - I use UNLOCKER APP. But when You stop using folders/files that You want to backup/restore - You won't have any issues, once again, a note. Anyway, if You're not sure - unlock folder from its parent if sush is available, no unlock the whole folder tree.

  7o2024 3:25p Obolon
