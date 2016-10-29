CFLAGS	         =  
FFLAGS	         =-Wno-tabs
CPPFLAGS         =
FPPFLAGS         =
LOCDIR           = src/ksp/ksp/examples/tutorials/
MANSEC           = KSP
CLEANFILES       = main *.o *.mod 
NP               = 1
OBJ				 = dm_type.o dm_mat.o dm.o 
OBJMAIN			 = ${OBJ} main.o 

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules

main: ${OBJMAIN}  chkopts
	-${FLINKER} -o main ${OBJMAIN}  ${PETSC_KSP_LIB}

tiny:
	make clean
	make main 
	-@${MPIEXEC} -n 1 ./main -m 3 -n 2 -k 1 -ep 3.1 -debug -ksp_type bcgs -pc_type bjacobi -sub_ksp_type preonly -sub_pc_type jacobi

small:
	make clean
	make main 
	-@${MPIEXEC} -n 2 ./main -m 3 -n 2 -k 2 -ep 3.1 -debug -ksp_type bcgs -pc_type bjacobi -sub_ksp_type preonly -sub_pc_type jacobi

middle:
	make clean
	make main 
	-@${MPIEXEC} -n 4 ./main -m 3 -n 2 -k 2 -ep 3.1 -log_view -ksp_type bcgs -pc_type bjacobi -sub_ksp_type preonly -sub_pc_type jacobi

big:
	make clean
	make main 
	-@${MPIEXEC} -n 16 ./main -m 300 -n 300 -k 5 -ep 3.1 -log_view -ksp_type bcgs -pc_type bjacobi -sub_ksp_type preonly -sub_pc_type jacobi

huge:
	make clean
	make main 
	-@${MPIEXEC} -n 16 ./main -m 1000 -n 1000 -k 5 -ep 3.1 -log_view -ksp_type bcgs -pc_type bjacobi -sub_ksp_type preonly -sub_pc_type jacobi



#include ${PETSC_DIR}/lib/petsc/conf/test
