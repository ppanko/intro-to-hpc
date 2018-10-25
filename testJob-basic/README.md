# Running a basic job 

## 1. Getting started

The first step to running an HPC job is to of course create the script that does the job. 

Assuming you've done this step and you have an account with the HPCC ([see this if you don't]), you will need to get your materials to Quanah. This usually involves storing your scripts in a directory and transferring them to Quanah via a [network protocol](). There are several ways to do this:

[Command line]():
   * Secure copy protocol([scp]()) 
   * rsync or quanah_sync 
   
[Graphical](): 
   * WinSCP ([Here's an example](https://research.computing.yale.edu/support/hpc/user-manual/transfer-files-or-cluster))
   
##### Example: 
```bash
## My files are in the "testJob-basic" directory 
> ls testJob-basic
...

## Send the files to Quanah via "scp" 
scp -r testJob-basic <eraider>@quanah.hpcc.ttu.edu:.

## OR

## Send the files to Quanah via "rsync"
rsync -ave testJob-basic <eraider>@quanah.hpcc.ttu.edu:.
```

***Note***: if you are transferring very large files they may "strain" Quanah. In these cases it's recommended to use [Globus Connect](https://www.depts.ttu.edu/hpcc/userguides/general_guides/file_transfer.php).
   
