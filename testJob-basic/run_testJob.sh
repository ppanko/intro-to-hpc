#!/bin/sh
#$ -V
#$ -cwd
#$ -S /bin/bash
#$ -N testJob
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe sm 10

module load intel R 

Rscript 02_testJob-parallel.R
