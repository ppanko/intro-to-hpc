# BASH cheatsheet 

> bash (**b**ourne **a**gain **sh**ell) 

&nbsp;&nbsp;&nbsp;Language used to communicate with UNIX/UNIX-like operating systems.

&nbsp;&nbsp;&nbsp;Very useful for facilitating and running jobs on a computing cluster! 

> bash syntax basics 

&nbsp;&nbsp;&nbsp;Usually a command followed by arguments separated by a space.

&nbsp;&nbsp;&nbsp;Arguments can be variables, directory paths or options.  

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

## ** Common BASH commands **

> `pwd` (**p**rint **w**orking **d**irectory)

&nbsp;&nbsp;&nbsp;Shows what folder you are in 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
> pwd
/home/pavel/Documents
```
***

> `ls` (**l**i**s**t files)

&nbsp;&nbsp;&nbsp;Shows you the files for the specified directory 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> ls
01_serialExample.R  02_parallelExample.R  testJob.sh
```
***
> `mkdir` (**m**ake **dir**ectory)

&nbsp;&nbsp;&nbsp;Creates a directory (Needs a name)

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> mkdir newFolder
```
***
> `cp` (**c**o**p**y)

&nbsp;&nbsp;&nbsp;Copies a file or folder (Needs names of the original and the copy) 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> cp testJob.sh testJob-copy.sh 
```
***
> `mv` (**m**o**v**e)

&nbsp;&nbsp;&nbsp;Moves a file or folder (Needs to be directed where to move from and to) 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> mv testJob.sh newFolder/
```

## ** Network protocols **

> `ssh` (**s**ecure **sh**ell)

&nbsp;&nbsp;&nbsp;Access a remote computer 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
> ssh <eraider>@quanah.hpcc.ttu.edu
```
***
> `scp` (**s**ecure **c**o**p**y)

&nbsp;&nbsp;&nbsp;Copies files to a remote computer

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:
```bash
## From local to remote 
> scp testJob.sh <eraider>@quanah.hpcc.ttu.edu:testJob.sh

## From remote to local
> scp <eraider>@quanah.hpcc.ttu.edu:testResult.RDS
```

