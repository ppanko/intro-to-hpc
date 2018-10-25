# Running a basic job 

This is a guide for transferring and running "testJob" on the Quanah cluster. 

## 1. Transferring files  

The first step to running an HPC job is to of course create the script that does the job. You should always test your job multiple times on your local computer before thinking about HPC. 

Assuming you've done this step and you have an account with the HPCC ([see this if you don't]), you will need to get your materials to Quanah. This usually involves storing your scripts in a directory and transferring them to Quanah via a [network protocol](). There are several ways to do this:

[Command line]():
   * Secure copy protocol ([scp]()) 
   * rsync or quanah_sync 
   
[Graphical](): 
   * WinSCP ([Here's an example](https://research.computing.yale.edu/support/hpc/user-manual/transfer-files-or-cluster))
   
##### Example: 
```bash
## My files are in the "testJob-basic" directory 
> ls testJob-basic
...

## Send the files to Quanah via "scp" 
> scp -r testJob-basic <eraider>@quanah.hpcc.ttu.edu:.

## OR

## Send the files to Quanah via "rsync"
> rsync -ave testJob-basic <eraider>@quanah.hpcc.ttu.edu:.
```

***Note on large jobs***: if you are transferring very large files they may "strain" Quanah. In these cases it's recommended to use [Globus Connect](https://www.depts.ttu.edu/hpcc/userguides/general_guides/file_transfer.php).

***Note on small scripts***: if your script is really small, you might consider loggin in to Quanah using `ssh` and directly copying the text of the script to new files created on Quanah. Make sure the text was copied over correctly. 
   
## 2. Configuring the job 

Setting up jobs on Quanah is easy but having a template makes it even easier. 

You can start by logging on to the cluster: 

##### Example:
```bash
ssh <eraider>@quanah.hpcc.ttu.edu
```

At this point you can submit a job directly using [`qsub`](). However, this can be messy because you would also have to list all of the parameters of your job during the call to `qsub`. Creating a [shell script]() that contains all of the parameters can streamline this process

The typical submission script looks just like run_testJob.sh:
```bash
#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N testJob
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe sm 36

module load intel R 

Rscript 02_testJob-parallel.R
```
#### Job parameters 

Each of the lines beginning with #$ are the parameters of your job. I will list some of the more important ones below but if you want more information, follow [this](https://bioinformatics.mdc-berlin.de/intro2UnixandSGE/sun_grid_engine_for_beginners/how_to_submit_a_job_using_qsub.html) link. 

* `-N` - the name of your job.
* `-o` - the "output" file which contains any standard messages from the job.
* `-e` - the "error" file which contains and errors from the job.
* `-pe` - the "parallel environemnt". Currently the only choices are `sm` and `mpi`; simpler jobs should use `sm`. 

***Number of Processors***: the number to the right of `-pe sm` indicates the number of processors you are requesting from Quanah. For `sm` jobs, the allowed number is 1-36. If you want to request additional cores, you might consider using `mpi` or creating an array job using the `-t` parameter (guide coming soon).  

Keep in mind, a good naming convention is always a good way to keep your files organized. For example, 
