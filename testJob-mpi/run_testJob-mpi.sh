
#!/bin/sh
#$ -cwd
#$ -S /bin/bash
#$ -N testJob-mpi
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q omni
#$ -P quanah
#$ -pe mpi 180

source /etc/profile.d/lmod.sh
module load intel R impi

export OMP_NUM_THREADS=1

rm $JOB_NAME.o $JOB_NAME.e

mpirun -n 1 --hostfile machinefile.$JOB_ID Rscript ./01_testJob-mpi.R &> testJob-mpi.out
