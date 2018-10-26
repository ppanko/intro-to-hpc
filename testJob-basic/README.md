# Running a basic job 

This is a guide for facilitating and running a simple HPC job on the Quanah [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). The provided examples use the [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)

## 1. Transferring files  

The first step to running an HPC job is, _of course_, to create the script that does the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you want. You should always test your job multiple times on your [local computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) before thinking about using it [remotely](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), like on the Quanah [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

Assuming you have a job ready and you have an account with the HPCC ([see this if you don't](https://github.com/ppanko/intro-to-hpc/blob/master/README.md)), you will need to get your materials from your [local computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)) to the [remote computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)) on Quanah. This usually involves storing your scripts in a [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and transferring them to Quanah via a [network protocol](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). There are several ways to do this:

[Command line](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md):
   * Secure copy protocol ([scp](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md)) 
   * rsync
   
[Graphical](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md): 
   * WinSCP ([Here's an example](https://research.computing.yale.edu/support/hpc/user-manual/transfer-files-or-cluster))
   
##### Example: 
```bash
## My files are in the "testJob-basic" directory 
> ls testJob-basic
01_testJob-serial.R  02_testJob-parallel.R  testJob.sh

## Send all the files to Quanah via "scp" 
> scp -r testJob-basic <eraider>@quanah.hpcc.ttu.edu:.

## OR

## Send the files to Quanah via "rsync"
> rsync -ave testJob-basic <eraider>@quanah.hpcc.ttu.edu:.
```

***Note on large jobs***: if you are transferring very large files, the process may "strain" Quanah. In these cases it's recommended to use [Globus Connect](https://www.depts.ttu.edu/hpcc/userguides/general_guides/file_transfer.php).

***Note on small scripts***: if your script is really small, you might consider loggin in to Quanah using [`ssh`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) and directly copying the text of the script to new files created on Quanah. Make sure the text was copied over correctly. 
   
## 2. Configuring the job 

Setting up jobs on Quanah is easy but having a template makes it even easier. 

You can start by logging on to the cluster using [`ssh`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md): 

##### Example:
```bash
## Login to Quanah using your <eraider>
> ssh <eraider>@quanah.hpcc.ttu.edu
```

#### Shell script  

At this point you can submit the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) directly to the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) using [`qsub`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). However, this can be messy because you would also have to list all of the [parameters](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) of your job during the call to [`qsub`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). Creating a [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)) that contains all of the [parameters](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) can streamline this process.

The typical submission script looks just like [run_testJob.sh](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/run_testJob.R):
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

Each of the lines beginning with #$ are the [parameters](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) of your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). I will list some of the more important ones below but if you want more information, follow [this link](https://bioinformatics.mdc-berlin.de/intro2UnixandSGE/sun_grid_engine_for_beginners/how_to_submit_a_job_using_qsub.html). 

* `-N` - the name of your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).
* `-o` - the "output" file which contains any standard messages from the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Is named based on the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) name (e.g., testJob.o).
* `-e` - the "error" file which contains errors and warnings from the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). Is named based on the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) name (e.g., testJob.e)
* `-pe` - the "parallel environemnt". Currently the only choices are `sm` and `mpi`; simpler jobs should use `sm`. 

***Number of Processors***: the number to the right of `-pe sm` indicates the number of [processors](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you are requesting from the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). For `sm` jobs, the allowed number is 1-36 because 36 is the maximum number of [processors](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) for each [node](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). If you want to request additional [processors](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md), you might consider using the `mpi` parallel environment or creating an "array job" using the `-t` parameter (guides coming).  

***Modules***: After the section of [job parameters](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you will see a line that starts with "[module](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)". This command tells the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) which "packages" you want to use on Quanah. When running R [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) the [modules](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you will need are `intel` and `R`. 

***General organization***: Try to stay as organized as you can. A lot of common errors and mistakes can be alleviated by having a good naming convention for your files. Here's a few other things you may want to note:

* Have your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (e.g., [run_testJob.sh](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/run_testJob.R)) in the same [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) as your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) script (e.g, [02_testJob-parallel.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/02_testJob-parallel.R)).
* Make sure any other [directories](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) or files that you need _during_ the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are created before you run the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 
* If you are using R packages, make sure they are available on Quanah. If not, you will have to install them for your session (guide coming soon). 
* Pay special attention to how you save your results. Save to a pre-specified [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and use a descriptive file name. 

##### Example:
```bash
## Navigate to the testJob directory
> cd testJob

## Create a "data" directory to contain the result
mkdir data
```

## 3. Running and monitoring your job 

Once you have your [job script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) properly tested and your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is properly configured, you can submit the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). You can do so by providing your [shell script](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) as an argument to [`qsub`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). 

##### Example:
```bash
## Submit testJob 
> qsub run_testJob.sh
Your job <job_id> ("testJob") has been submitted
```

Once you run [`qsub`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) the [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) will be placed in a queue and will be on stand-by until the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) has allocated the proper resources to start your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) or until there is an error. You can check the status of the submitted [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) any time by using [`qstat`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). 

##### Example:
```bash
> qstat
job-ID    prior   name    user       state     submit/start at      slots 
-------------------------------------------------------------------------
<job_id> 5.00000 testJob <eraider>     qw    10/26/2018 10:59:59       32  
```

Alternatively, you can check your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) using HPCC's [queue status page](http://charlie.hpcc.ttu.edu/qstat/qstat.html). This webpage will give you information about all of the [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) submitted to the [cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and give you an idea of how many [processors](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) are available. 

If there is something wrong with your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) and you want to remove it and start again, you can use [`qdel`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). First, you will need to get your <job_id> via [`qstat`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) and then supply it to [`qdel`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md). 

##### Example: 
```bash
> qdel <job_id>
<eraider> has deleted job <job_id> 
```

## 4. Retrieving results 

Once your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) is done, [`qstat`](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) will return a blank line and your eraider will no longer be listed on the queue status page. An easy way to tell if your [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) terminated correctly is to check the .e or .o files using a text editor, such as `emacs`. 

```bash
> emacs testJob.e

## OR 

> emacs testJob.o
```
When finished checking the files, you can quit `emacs` by pressing Control-c. 

Assumming nothing went wrong with the job, you are ready to retrieve your results. This means that the data must be copied from the [remote computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to the [local computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) - essentially the opposite of step 1. Ideally, your results will be in a pre-specified location and have a known naming convention. Having this structure in place can make getting results to your computer really easy: 

```bash
## Transfer results to my "Documents" directory
scp -r <eraider>@quanah.hpcc.ttu.edu:testJob/data /home/pavel/Documents
```

**Congratulations!** You just ran a HPC [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) on the Quanah [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)
