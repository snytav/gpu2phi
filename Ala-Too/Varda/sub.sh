#!/bin/sh
 
#PBS -l walltime=00:30:00
#PBS -l select=1:ncpus=1:mpiprocs=1:mem=4000m
 
cd $PBS_O_WORKDIR
 
## Set variables for ITAC:
source /opt/intel/itac/8.1.3.037/bin/itacvars.sh
 
## Set variables for Intel compiler:
source /opt/intel/composerxe/bin/compilervars.sh intel64

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/Compiler/11.1/072/lib/intel64
export I_MPI_CC=icc

pwd 
hostname
## Compile with '-trace' parameter to use ITAC:
./c
#rm *.o all
#icc -m64 -c rnd.cpp
#icc -c -g -trace    main.cpp >&err_main
#mpiicc -c -g -trace mpi_shortcut.cxx >&mpi_err.txt
#icc -c -g -trace    init.cpp
#icc -c -g -trace    params.cxx
#icc -c -g -trace    diagnose.cxx 2>&1 > err_diagnose
#icc -c -g -trace    read_particles.c
#mpiicc -o -trace    all *.o -L/opt/intel/impi/5.0.1.035/intel64/lib/ -fopenmp -L/Compiler/11.1/038/lib/intel64/
#nvcc -O2 -lineinfo -c main.cu --ptxas-options=-v --keep -arch=sm_35 -I/usr/local/cuda-7.0/include >&c_out

#ls -l all
#date

 
## Count the number of MPI processes:
MPI_NP=`wc -l $PBS_NODEFILE | awk '{ print $1 }'`
 
## Add '-trace' parameter:
mpirun -trace -machinefile $PBS_NODEFILE -np $MPI_NP ./all
