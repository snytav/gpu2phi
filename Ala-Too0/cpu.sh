
rm *.o all
icc -c main.cpp --maxrregcount=128 -g -arch=sm_35 -I/usr/local/cuda-7.5/include/ -g -L/usr/local/cuda-7.5/lib64/ -lcuda -lcudart >compile.out 2>&1
cat compile.out
ls -l main.o
exit
mpicxx -c -g mpi_shortcut.cxx
g++ -c -g init.cpp

mpicxx -g -o cuda_all main.o init.o mpi_shortcut.o -g -L/usr/local/cuda-7.5/lib64/ -lcuda -lcudart -lm >link.out 2>&1
ls -l all
