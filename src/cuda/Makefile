NVCC=nvcc
NVCCOPTIONS=-w -arch sm_35
#--ptxas-options=-v

all:
	$(NVCC) $(NVCCOPTIONS) -o copyArray-solution.x copyArray-solution.cu

clean:
	rm -f *.o *.x
