## Programs 

> `count_files` 

&nbsp;&nbsp;&nbsp;Count the number of files in a specified [directory](https://github.com/ppanko/intro-to-hpc/blob/master/Glossary.md).

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
## Will count number of files in current directory by default
> bash count_files
10

## Or, can count files in a specific directory 
> bash count_files data/
9010
```
***
> `queue_check` 

&nbsp;&nbsp;&nbsp;An automated [qstat](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) that returns the queue status at a specified time interval.

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
## Run qstat every 60 seconds 
> bash queue_check 60
job-ID    prior   name    user       state     submit/start at      slots 
-------------------------------------------------------------------------
<job_id> 5.00000 testJob <eraider>     qw    10/26/2018 10:59:59       32        

```
***
> `quanah_sync` 

&nbsp;&nbsp;&nbsp;A wrapper function for [rsync](https://github.com/ppanko/intro-to-hpc/blob/master/BASH-cheatsheet.md) to make transferring files to and from Quanah easier. 

###### &nbsp;&nbsp;&nbsp;&nbsp;Example:

```bash
## Transfer a file from a local machine to Quanah  
bash quanah_sync -t <eraider> myProject/input_files.zip myFolder/   

## Transfer a file from Quanah to a local machine 
bash quanah_sync -f <eraider> myFolder/output_files.zip myProject/ 
```
***
