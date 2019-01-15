# BASH cheatsheet 

> [BASH](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) (**b**ourne **a**gain **sh**ell) 

&nbsp;&nbsp;&nbsp;Language used to communicate with UNIX/[UNIX-like](https://en.wikipedia.org/wiki/Unix-like) operating systems.

&nbsp;&nbsp;&nbsp;Very useful for facilitating and running [jobs](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) on a [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md)! 

&nbsp;

> BASH syntax basics 

&nbsp;&nbsp;&nbsp;Usually a command followed by arguments, each separated by a space.

&nbsp;&nbsp;&nbsp;Arguments can be variables, [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) paths or options.  

&nbsp;

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
## Shows files in the current directory
> ls 

## Shows files in the current directory even if they are hidden
> ls -f

## Shows the files in the specified directory
> ls /home/pavel/Documents

## Shows files in the specified directory even if they are hidden
> ls -f /home/pavel/Documents

```
&nbsp;
# Contents
This cheatsheet gives a basic overview for BASH commands and programs commonly used when navigating the Quanah [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) provided by the [HPCC](https://www.depts.ttu.edu/hpcc/) at Texas Tech. 

Warning: This guide assumes you have an assigned eraider identity (refered to as \<eraider\> below) and are able to log in to Quanah. See the [here](https://github.com/ppanko/intro-to-hpc/blob/master/README.md) for more information. 

  
### [Go to: Common BASH commands](#common-bash-commands)

   `pwd` `ls` `mkdir` `cp` `mv` `rm`
    
### [Go to: Network protocols & programs](#network-protocols-and-programs)

   `ssh` `scp` `wget`
   
### [Go to: Job scheduler commands](#job-scheduler-commands)

  `qsub` `qstat` `qdel` 
  
  &nbsp;
  
***

## Common BASH commands 
> `pwd` (**p**rint **w**orking **d**irectory)

&nbsp;&nbsp;&nbsp;Shows what [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) you are in.

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
> pwd
/home/pavel/Documents
```
***
> `ls` (**l**i**s**t files)

&nbsp;&nbsp;&nbsp;Shows you the file names in the specified [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> ls
01_testJob-serial.R  02_testJob-parallel.R  testJob.sh
```
***
> `mkdir` (**m**ake **dir**ectory)

&nbsp;&nbsp;&nbsp;Creates a [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (Needs a name).

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> mkdir newFolder
```
***
> `cp` (**c**o**p**y)

&nbsp;&nbsp;&nbsp;Copies a file or [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (Needs names of the original and the copy). 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## Copy the file "testJob.sh" 
> cp testJob.sh testJob-copy.sh

## Copy the directory "testJob"
> cp -r testJob testJob-copy 
```
***
> `mv` (**m**o**v**e)

&nbsp;&nbsp;&nbsp;Moves a file or [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (Needs to be told what to move from and to). 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## Moving testJob.sh to the "newFolder" directory
> mv testJob.sh newFolder/

## Moves the directory "testJob" inside "newFolder"
> mv testJob newFolder  
```
***
> `rm` (**r**emo**v**e)

&nbsp;&nbsp;&nbsp;Delete a file or [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) (Needs a name). 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## Delete the file "testJob-copy.sh" 
> rm testJob-copy.sh 

## Delete the directory "newFolder" 
> rm -r newFolder  
```
***
&nbsp;
## Network protocols and programs 
> `ssh` (**s**ecure **sh**ell)

&nbsp;&nbsp;&nbsp;Access a [remote computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> ssh <eraider>@quanah.hpcc.ttu.edu
```
***
> `scp` (**s**ecure **c**o**p**y)

&nbsp;&nbsp;&nbsp;Copies [local](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) files or [directories](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to a [remote computer](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## Copy file from local to remote 
> scp testJob.sh <eraider>@quanah.hpcc.ttu.edu:testJob.sh

## Copy file from remote to local
> scp <eraider>@quanah.hpcc.ttu.edu:testResult.RDS /home/pavel/Documents

## Copy directory from local to remote 
> scp -r testJob <eraider>@quanah.hpcc.ttu.edu:testJob.sh

## Copy directory from remote to local
> scp -r <eraider>@quanah.hpcc.ttu.edu:data /home/pavel/Documents
```
***
> `wget` (**w**eb **get**)

&nbsp;&nbsp;&nbsp;Get files from the internet.

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
wget https://github.com/ppanko/intro-to-hpc/BASH-cheatsheet.md
```
***
&nbsp;
## Job scheduler commands 
> `qsub` (**q**ueue **sub**mit)

&nbsp;&nbsp;&nbsp;Submit a [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) to the [computer cluster](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md). 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> qsub testJob.sh
Your job <job_id> ("testJob") has been submitted
```
***
> `qstat` (**q**ueue **stat**us)

&nbsp;&nbsp;&nbsp;Check the status of the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) queue for \<eraider\>. 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
 > qstat
job-ID    prior   name    user       state     submit/start at      slots 
-------------------------------------------------------------------------
<job_id> 5.00000 testJob <eraider>     qw    10/26/2018 10:59:59       32        

```
***
> `qdel` (**q**ueue **del**ete)

&nbsp;&nbsp;&nbsp;Delete a submitted [job](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) from the [job scheduler](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) queue.  

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bashx
 > qdel <job_id>
<eraider> has deleted job <job_id> 
```
***
> `qalter` (**q**ueue **alter**)

&nbsp;&nbsp;&nbsp;Alter a submitted (but not running) [job's](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md) parameters.  

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## Put job on hold
> qalter -h u <job_id>

## Release job on hold
> qalter -h U <job_id>
```







