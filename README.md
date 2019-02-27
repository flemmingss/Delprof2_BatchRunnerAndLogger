# Delprof2_BatchRunnerAndLogger
  A PowerShell script to run Delprof2 on multiple remote computers and log the results

**Description**  
  This script will run the application Delprof2  towards multiple computers with with various given parameters and log the results.
  This can be usefull for machines that get filled up with userprofiles.


**Requirements**
* Windows PowerShell
* DelProf2 (Freeware) - https://helgeklein.com/free-tools/delprof2-user-profile-deletion-tool/


**How to Use**  

* Download Delprof2 from https://helgeklein.com/download/
* Create a source-file ($computers_txt) for the script and format like this:

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

* Download the script and change the following variables:
```powershell
    $computers_txt = "D:\Delprof2_BatchRunnerAndLogger\computers.txt" #textfile with list of computers and parameters
    $computers_txt_skip_lines = "1" #How many lines to skip in $computers_txt file (If you want to write some instructions in top etc)
    $delprof_log_folder = "D:\Delprof2_BatchRunnerAndLogger\logs" #folder where the Delprof2 logs are saved
    $script_log_folder = "D:\Delprof2_BatchRunnerAndLogger\logs" #folder where script logs are saved
    $script_log_filename = "scriptrun_log.txt" #name of the script log
    $delprof_exe = "D:\Delprof2_BatchRunnerAndLogger\DelProf2.exe" #location of DelProf2 exe-file.
```
* Run or add to Windows Task Scheduler

**Running as Task in Windows Task Scheduler**

Here is an exable of action:
```
    Program/script: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
    Add arguments (optional): -noprofile -executionpolicy bypass -file "D:\Delprof2_BatchRunnerAndLogger\Delprof2_BatchRunnerAndLogger.ps1"
    Start in (optional): D:\Delprof2_BatchRunnerAndLogger\
```
**Changelog**  

* 27.02.2019
    * Release
