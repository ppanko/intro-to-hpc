# Introduction to High-Performance Computing 
This repository provides example materials for High-Performance Computing using the "[Quanah](https://www.depts.ttu.edu/hpcc/operations/equipment.php)" cluster provided by the [High-Performance Computing Center](https://www.depts.ttu.edu/hpcc/) at Texas Tech University.

The provided examples are for running jobs using the [R language/environment](https://www.r-project.org/about.html). 

## What is High-Performance Computing? 
High Performance Computing (HPC) is the use of a computer cluster or other high-performance computer (e.g., a supercomputer) to do computational jobs very very quickly. The benefit of this approach is the efficiency of performance - the user is able to split the job to run in parallel on several nodes (computers) or several processors on a single node.   

In short, HPC is a good technique for when you have a lot of data or need to run many analyses. 

## Getting started 

1. Get an HPCC account

    You will need to [request](https://www.depts.ttu.edu/hpcc/accounts/facultyrequest.php) an account from the HPCC to access the Quanah cluster. This is free and requests are approved fairly quickly. 

   > Here's a link to the request form: 
https://www.depts.ttu.edu/hpcc/accounts/studentrequestform.php
 
2. Configure ssh connection

    Connections to the Quanah cluster are made through the "Secure Shell" (`ssh`) network protocol. Mac and Unix-like operating systems have access to `ssh` naturally but Windows needs some extra help.   
 
   If you are a Windows user, you can either:
      * Download Cygwin and configure ssh ([comprehensive guide](https://docs.oracle.com/cd/E24628_01/install.121/e22624/preinstall_req_cygwin_ssh.htm#EMBSC150)) 

      OR

      * Download [puTTY](https://www.putty.org/) and [WinSCP](https://winscp.net/eng/download.php)
 
   If you are a macOS user: 
      * You may need to enable ssh: 
      
          *System Preferences pane* → *Sharing applet* → *check the Remote Login checkbox*

## Resources 

Verified users are invited to try running an example job called "testJob". The [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) directory contains a all of the relevant files needed to run "testJob" as well as a [walkthrough with examples](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md). Here is the outline of the contents of [testJob-basic](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic):

* [testJob-basic directory](https://github.com/ppanko/intro-to-hpc/tree/master/testJob-basic) - a directory showing a simple example R job, contains: 
    * [run_testJob.sh](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/02_testJob-parallel.R) - a shell script used to submit the "02" script to Quanah's job scheduler. 
    * [01_testJob-serial.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/01_testJob-serial.R) - an R script showing serial execution. 
    * [02_testJob-parallel.R](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/02_testJob-parallel.R) - an R script showing parallel execution. Can be submitted to Quanah via run_testJob.sh
    * [README](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md) - a walkthrough showing a workflow for running "testJob" on Quanah.

Two pages of learning materials are provided for your convenience and are often referenced by the [testJob walkthrough](https://github.com/ppanko/intro-to-hpc/blob/master/testJob-basic/README.md):  

* [BASH cheatsheet](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) - the BASH language is used to communicate with Quanah and execute jobs. 
* [Glossory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) - A list of definitions for common HPC-related terminology. 
 
    
If you have any comments or suggestions, please email me at pavel.panko@ttu.edu
