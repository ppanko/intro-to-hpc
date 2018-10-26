# Running a basic job 

This is a guide for transferring and running "testJob" on the Quanah cluster. 

## 1. Transferring files  

The first step to running an HPC job is, _of course_, to create the script that does the [job]() you want. You should always test your job multiple times on your [local computer]() before thinking about using it [remotely](), like on the Quanah cluster. 

Assuming you have a job ready and you have an account with the HPCC ([see this if you don't]()), you will need to get your materials to Quanah. This usually involves storing your scripts in a directory and transferring them to Quanah via a [network protocol](). There are several ways to do this:

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

## Send all the files to Quanah via "scp" 
> scp -r testJob-basic <eraider>@quanah.hpcc.ttu.edu:.

## OR

## Send the files to Quanah via "rsync"
> rsync -ave testJob-basic <eraider>@quanah.hpcc.ttu.edu:.
```

***Note on large jobs***: if you are transferring very large files, the process may "strain" Quanah. In these cases it's recommended to use [Globus Connect](https://www.depts.ttu.edu/hpcc/userguides/general_guides/file_transfer.php).

***Note on small scripts***: if your script is really small, you might consider loggin in to Quanah using `ssh` and directly copying the text of the script to new files created on Quanah. Make sure the text was copied over correctly. 
   
## 2. Configuring the job 

Setting up jobs on Quanah is easy but having a template makes it even easier. 

You can start by logging on to the cluster: 

##### Example:
```bash
## Login to Quanah using your <eraider>
> ssh <eraider>@quanah.hpcc.ttu.edu
```

#### Shell script  

At this point you can submit a job directly to the job scheduler using [`qsub`](). However, this can be messy because you would also have to list all of the parameters of your job during the call to `qsub`. Creating a [shell script]() that contains all of the parameters can streamline this process.

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
* `-o` - the "output" file which contains any standard messages from the job. Is named based on the job name (e.g., testJob.o).
* `-e` - the "error" file which contains and errors from the job. Is named based on the job name (e.g., testJob.e)
* `-pe` - the "parallel environemnt". Currently the only choices are `sm` and `mpi`; simpler jobs should use `sm`. 

***Number of Processors***: the number to the right of `-pe sm` indicates the number of processors you are requesting from the job scheduler. For `sm` jobs, the allowed number is 1-36. If you want to request additional cores, you might consider using `mpi` or creating an array job using the `-t` parameter (guide coming soon).  

***Modules***: After the section of job parameters you will see a line that starts with "module". This command tells the job scheduler which "packages" you want to use. When running R jobs the modules you will need are `intel` and `R`. 

***General organization***: Try to stay as organized as you can. A lot of common errors and mistakes can be alleviated by having a good naming convention for your files. Here's a few other things you may want to note:

* Have your shell script (e.g., run_testJob.sh) in the same directory as your job script (e.g, 02_testJob-parallel.R).
* Make sure any other directories or files that you need _during_ the job are created before you run the job. 
* If you are using R packages, make sure they are available. If not you will have to install them for your session (guide coming soon). 
* Pay special attention to how you save your results. Save to a pre-specified directory and use a descriptive file name. 

##### Example:
```bash
## Navigate to the testJob directory
> cd testJob

## Create a "data" directory to contain the result
mkdir data
```

## 3. Running and monitoring your job 

Once you have your job script properly tested and your shell script is properly configured, you can submit the job to the scheduler. You can do so by providing your shell script as an argument to `qsub`. 

##### Example:
```bash
## Submit testJob 
> qsub run_testJob.sh
Your job <job_id> ("testJob") has been submitted
```

Once you run `qsub` the job will be placed in a queue and will be on stand-by until the scheduler has allocated the proper resources for your job or there is an error. You can check the status of your job any time by using `qstat`. 

##### Example:
```bash
> qstat
job-ID    prior   name    user       state     submit/start at      slots 
-------------------------------------------------------------------------
<job_id> 5.00000 testJob <eraider>     qw    10/26/2018 10:59:59       32  
```

Alternatively, you can check your job using HPCC's [queue status page](http://charlie.hpcc.ttu.edu/qstat/qstat.html). This webpage will give you all of the information about all of the jobs submitted to the cluster and give you an idea of how many processors are available. 

If there is something wrong with your job and you want to remove it and start again, you can use [`qdel`](). First, you will need to get your <job_id> via `qstat` and then supply it to `qdel`. 

##### Example: 
```bash
> qdel <job_id>
<eraider> has deleted job <job_id> 
```

## 4. Retrieving results 

Once your job is done, qstat will return a blank and your eraider will no longer be listed on the queue status page. An easy way to tell if your job terminated correctly is to check the .e or .o files using a text editor, such as `emacs`. 

```bash
> emacs testJob.e

## OR 

> emacs testJob.o
```
When finished checking the files, you can quit `emacs` by pressing Control-c. 

Assumming nothing went wrong with the job, you are ready to retrieve your results. This means that the data must be copied from the [remote computer]() to the [local computer]() - essentially the opposite of step 1. Ideally, your results will be in a pre-specified location and have a known naming convention. Having this structure in place can make this process really easy: 



