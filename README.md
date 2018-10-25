# Introduction to High-Performance Computing 
This repository provides example materials for High-Performance Computing using the "[Quanah](https://www.depts.ttu.edu/hpcc/operations/equipment.php)" cluster provided by the [High-Performance Computing Center](https://www.depts.ttu.edu/hpcc/) at Texas Tech University.

The provided examples are for running jobs using the [R language/environment](https://www.r-project.org/about.html). 

## What is High-Performance Computing? 
High Performance Computing (HPC) is the use of a computing cluster or other high-performance computer (e.g., a supercomputer) to do computational jobs very very quickly. This is because the job may be split to run on several computers on the cluster in parallel.   

HPC is a good tool for when you have a lot of data or need to run many analyses. 

## Getting started 

1. Get an HPCC account

    You will need to [request](https://www.depts.ttu.edu/hpcc/accounts/facultyrequest.php) an account from the HPCC to access the Quanah cluster. This is free and should be approved fairly quickly 

   > Here's a link to the request form: 
https://www.depts.ttu.edu/hpcc/accounts/studentrequestform.php
 
2. Configure ssh connection

    Connections to the Quanah cluster are made through the "Secure Shell" (ssh) network protocol. Mac and Unix-like operating systems have access to ssh naturally but Windows needs some extra help.   
 
   If you are a Windows user, you can either:
      * Download Cygwin and configure ssh ([comprehensive guide](https://docs.oracle.com/cd/E24628_01/install.121/e22624/preinstall_req_cygwin_ssh.htm#EMBSC150)) 

      OR

      * Download [puTTY](https://www.putty.org/) and [WinSCP](https://winscp.net/eng/download.php)
 
   If you are a macOS user: 
      * You may need to enable ssh: 
      
          *System Preferences pane* → *Sharing applet* → *check the Remote Login checkbox*

## Resources 

* BASH cheatsheet - the BASH language is used to communicate with Quanah and execute jobs. 
* 
