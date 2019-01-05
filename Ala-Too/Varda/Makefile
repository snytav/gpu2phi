LD=icc
CUDACC=icc
CXX=mpiicc
CPP=mpiicc

LDFLAGS= -lm  -gdwarf-2
#CUDAFLAGS= --maxrregcount=128  -arch=sm_35 --ptxas-options=-v -I/usr/local/cuda-6.5/include/
CUDAFLAGS= #--maxrregcount=128 -g -arch=sm_35 -openmp -I/usr/local/cuda-6.5/include/  -gdwarf-2
#CUDAFLAGS= --maxrregcount=128 -g -arch=sm_35 -openmp -I/usr/local/cuda-7.5/include/  -gdwarf-2
CUDALIBS=  -g -lm -lmpi -L/ifs/opt/2013/intel/impi/4.1.3.049/lib64 -fopenmp
#CUDALIBS=  -g -lm -L/usr/local/cuda-6.5/lib64/ -openmp -lcuda -lcudart -lmpi -L/ifs/opt/2013/intel/impi/4.1.3.049/lib64
#CUDALIBS=  -g -lm -L/usr/local/cuda-7.5/lib64/ -openmp -lcuda -lcudart -lmpi -L/ifs/opt/2013/intel/impi/4.1.3.049/lib64
MPIFLAGS=
CFLAGS= -gdwarf-2

OBJ = main.o mpi_shortcut.o read_particles.o init.o diagnose.o params.o memory_control.o
            
main.o: main.cpp $(DEPS)
	$(CUDACC) -g -c -o $@ $< $(CUDAFLAGS) 
                    
%.o: %.cxx $(DEPS)
	$(CXX) -g -c -o $@ $< $(MPIFLAGS)

%.o: %.cpp $(DEPS)
	$(CPP) -g -c -o $@ $< $(CBFLAGS)
	
%.o: %.c $(DEPS)
	$(CPP) -g -c -o $@ $< $(CBFLAGS)	
                            
all: $(OBJ)
	$(LD)  -gdwarf-2 -g -o $@ $^ $(CFLAGS) $(DBFLAGS) $(CUDALIBS)

clean:
	rm *.o all    
