#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N testJob-array
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe sm 10  
#$ -t 1-4:1

module load intel R 

Rscript 01_testJob-array.R
