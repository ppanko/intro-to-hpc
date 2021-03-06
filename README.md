[![DOI](https://zenodo.org/badge/154785479.svg)](https://zenodo.org/badge/latestdoi/154785479)

# Introduction to High-Performance Computing Using R 
This repository provides example materials for High-Performance Computing using the "[Quanah](https://www.depts.ttu.edu/hpcc/operations/equipment.php)" cluster provided by the [High-Performance Computing Center](https://www.depts.ttu.edu/hpcc/) at Texas Tech University.

The provided examples are for running jobs using the [R language/environment](https://www.r-project.org/about.html). 

## What is High-Performance Computing? 
High Performance Computing (HPC) is the use of a computer cluster or other high-performance computer (e.g., a supercomputer) to do computational jobs very very quickly. The benefit of this approach is the efficiency of performance - the user is able to split the job to run in parallel on several nodes (computers) or several processors on a single node.   

In short, HPC is a good technique for when you have a lot of data to process or need to run many analyses. 

## Getting started 

1. Get an HPCC account

    You will need to [request](https://www.depts.ttu.edu/hpcc/accounts/facultyrequest.php) an account from the HPCC to access the Quanah cluster. This is free and requests are approved fairly quickly. 

   > Here's a link to the request form: 
https://www.depts.ttu.edu/hpcc/accounts/studentrequestform.php
 
2. Configure `ssh` connection

    Connections to the Quanah cluster are made through the "Secure Shell" (`ssh`) network protocol. Mac and Unix-like operating systems have access to `ssh` naturally but Windows needs some extra help.   
 
   If you are a Windows user, you can either:
      * Download Cygwin and configure `ssh` ([comprehensive guide](https://docs.oracle.com/cd/E24628_01/install.121/e22624/preinstall_req_cygwin_ssh.htm#EMBSC150)) 

      OR

      * Download [puTTY](https://www.putty.org/) and [WinSCP](https://winscp.net/eng/download.php)
 
   If you are a macOS user: 
      * You may need to enable `ssh`: 
      
          *System Preferences pane* → *Sharing applet* → *check the Remote Login checkbox*
3. Sign in 
    
    You will need your "eraider" identification code and Texas Tech password to log in. 

## Resources 

Verified users are invited to try running any of the available example jobs all having the format "testJob-[type]". 

***Basic job example***:

The [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) directory contains all of the relevant files needed to run a simple example HPC job as well as a [walkthrough with examples](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md). Here is the outline of the contents of [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic):

* [testJob-basic directory](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) - a directory showing a simple example R job, contains: 
    * [run_testJob.sh](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/run_testJob.sh) - a shell script used to submit the "02" basic script to Quanah's job scheduler. 
    * [01_testJob-serial.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/01_testJob-serial.R) - an R script showing serial execution (not used - just an example). 
    * [02_testJob-parallel.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/02_testJob-parallel.R) - an R script showing parallel execution. Can be submitted to Quanah via run_testJob.sh
    * [README](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md) - a walkthrough showing a workflow for running a job on Quanah.

***Array job example***:

Similarly, the [testJob-array](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-array) directory contains materials for running an array HPC job as well as a [walkthrough](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-array/README.md). The outline of the [testJob-array](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-array) directory is as follows: 

* [testJob-array directory](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-array) - a directory showing a simple example R job, contains: 
    * [run_testJob-array.sh](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-array/run_testJob-array.sh) - a shell script used to submit the "01" array script to Quanah's job scheduler. 
    * [01_testJob-array.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-array/01_testJob-array.R) - an R script showing a stratified array job. Can be submitted to Quanah via run_testJob-array.sh  
    * [README](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-array/README.md) - a walkthrough showing a workflow for running an array job on Quanah.

---

Three pages of learning materials are provided for your convenience. These are often referenced by the [testJob walkthrough](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md):  

* [BASH cheatsheet](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) - the BASH language is used to communicate with Quanah and execute jobs. 
* [Glossary](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) - A list of definitions for common HPC-related terminology. 
* [Local R package installation](https://github.com/ppanko/intro-to-hpc/blob/master/local-R-packages.md) - A tutorial for installing R packages not available by default on Quanah. 
 
Additionally, there is a directory containing several downloadable [BASH](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) scripts to help automate common tasks on Quanah: 

* [Programs](https://github.com/ppanko/intro-to-hpc/tree/master/programs) 
 
 TODO:
 * mpi jobs
 * mpi job array (yikes)
 * Port forwarding for off-campus access 
    
If you have any comments or suggestions, please email me at pavel.panko@ttu.edu
