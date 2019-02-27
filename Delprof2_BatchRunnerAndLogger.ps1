<#
.SYNOPSIS
  Name: Delprof2_BatchRunnerAndLogger.ps1
  The purpose of this script is to run Delprof2 towards multiple computers with with various given parameters and log the results.
.DESCRIPTION
  This script will run the application Delprof2  towards multiple computers with with various given parameters and log the results.
  This can be usefull for machines that get filled up with userprofiles.

  Tip: Run as a scheduled task each night towards shared computers.

.NOTES
    Original release Date: 27.02.2019
  Author: Flemming Sørvollen Skaret (https://github.com/flemmingss/)
.LINK
  https://github.com/flemmingss/
.EXAMPLE
  In $computers_txt format like this:
  A;B;C;D
  newline = new computer

  A) Name of the Computer
     (/c parameter in Delprof2)
  B) true=run simulated (WhatIf)
     false=run
     (/l parameter in Delprof2)
  C) Only delete profiles that has not been used in X days.
     (/d parameter in Delprof2)
  D) Description, just notes

  Example: DESKTOP123;false;7;Meeting room computer, delete userprofiles not used in one week.

#>

$computers_txt = "D:\Delprof2_BatchRunnerAndLogger\computers.txt" #textfile with list of computers and parameters
$computers_txt_skip_lines = "1" #How many lines to skip in $computers_txt file (If you want to write some instructions in top etc)
$delprof_log_folder = "D:\Delprof2_BatchRunnerAndLogger\logs" #folder where the Delprof2 logs are saved
$script_log_folder = "D:\Delprof2_BatchRunnerAndLogger\logs" #folder where script logs are saved
$script_log_filename = "scriptrun_log.txt" #name of the script log
$delprof_exe = "D:\Delprof2_BatchRunnerAndLogger\DelProf2.exe" #location of DelProf2 exe-file.

$StartDateTime = Get-Date -format "dd.MM.yyyy-HH:mm:ss"
"$StartDateTime - Running Script" >> $script_log_folder\$script_log_filename

foreach($line in Get-Content $computers_txt | select -Skip $computers_txt_skip_lines)

    {
    
    $StartDateTime = Get-Date -format "dd.MM.yyyy-HH:mm:ss"

	$computername = $line.Split(";")[0]
	$whatifmode = $line.Split(";")[1]
    $notusedindays = $line.Split(";")[2]


    $delprof_arguments = @(
        if ($whatifmode -eq "true")
        {
        "/l" #List only, do not delete (what-if mode)
        }
        "/u" #Unattended (no confirmation)
        "/c:\\$computername" #Delete on remote computer instead of local machine
        if ($notusedindays -ge 1)
        {
        "/d:$notusedindays" #Delete only profiles not used in x days
        }
        "/i" #Ignore errors, continue deleting
        )

   "$StartDateTime - Running command: cmd.exe /c $delprof_exe $delprof_arguments" >> $script_log_folder\$script_log_filename
   $delprof_output = cmd.exe /c "$delprof_exe" $delprof_arguments



   $EndDateTime = Get-Date -format "dd.MM.yyyy-HHmmss"
   $delprof_output_path = "$delprof_log_folder\$EndDateTime-$computername.txt"
   $delprof_output | Out-File -FilePath $delprof_output_path
   $EndDateTime = Get-Date -format "dd.MM.yyyy-HH:mm:ss"
   "$EndDateTime - Logfile created: $delprof_output_path" >> $script_log_folder\$script_log_filename

    }

$EndDateTime = Get-Date -format "dd.MM.yyyy-HH:mm:ss"
"$EndDateTime - Script Completed" >> $script_log_folder\$script_log_filename

#End of Script
