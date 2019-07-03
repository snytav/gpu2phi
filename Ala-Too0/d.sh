export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/compilers_and_libraries_2017.1.132/linux/compiler/lib/intel64

./c


rm -rf 1 4
mkdir 1
mkdir 4
cp all 1
cp 000_params.dat 1
cp 000_params.dat 4
cp all 4
cd 1
echo running single process
./all >&out1

cd ../4
echo running four processes
/opt/intel/compilers_and_libraries_2017.1.132/linux/mpi/bin64/mpirun -np 4 ./all >&out4

#cd ..
echo checking 1ST TIMESTEP current at 1,12,0 aSUM step 1
cat 1/2016*/compJx_at_aSUM_*_rank00000_nt00000001.dat|grep \ 1\ \ \ \ 12 >&1cur
cat 2/2016*/compJx_at_aSUM_*_rank00000_nt00000001.dat|grep \ 1\ \ \ \ 12 >&2cur

c1_aSUM1=`cat 1cur|gawk '{print($8)}'`
c2_aSUM1=`cat 2cur|gawk '{print($8)}'`

cmp 1cur 2cur >&cmp_cur
if [  -s cmp_cur ]
then
   echo 1ST TIMESTEP CURRENTS DIFFER
   cat 1cur |gawk '{printf("1PROC: %s\n",$0)}'
   cat 2cur |gawk '{printf("2PROC: %s\n",$0)}'
else
   echo 1ST TIMESTEP CURRENTS MATCH !!!!!!!!!!!!!!!!!!!!
fi

echo checking BEGIN TIMESTEP current at 1,12 beginCellOrder step 2
cat 1/2016*/compJx_at_beginCellOrder_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1beg
cat 2/2016*/compJx_at_beginCellOrder_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2beg

c1_beg2=`cat 1beg|gawk '{print($8)}'`
c2_beg2=`cat 2beg|gawk '{print($8)}'`


cmp 1beg 2beg >&cmp_cur
if [  -s cmp_cur ]
then
   echo 1ST TIMESTEP CURRENTS DIFFER
   cat 1cur |gawk '{printf("1PROC: %s\n",$0)}'
   cat 2cur |gawk '{printf("2PROC: %s\n",$0)}'
else
   echo 1ST TIMESTEP CURRENTS MATCH !!!!!!!!!!!!!!!!!!!!
fi

echo checking AFTER STEP-ALL-CELLS current at 1,12 afterStepAllCells
cat 1/2016*/compJx_at_afterStepAllCells_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1beg
cat 2/2016*/compJx_at_afterStepAllCells_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2beg

c1_astep2=`cat 1beg|gawk '{print($8)}'`
c2_astep2=`cat 2beg|gawk '{print($8)}'`


cmp 1beg 2beg >&cmp_cur
if [  -s cmp_cur ]
then
   echo AFTER STEP-ALL-CELLS DIFFER
   cat 1beg |gawk '{printf("1PROC: %s\n",$0)}'
   cat 2beg |gawk '{printf("2PROC: %s\n",$0)}'
else
   echo QQ 1ST TIMESTEP CURRENTS MATCH !!!!!!!!!!!!!!!!!!!!
fi

echo checking current BEFORE WRITE
cat 1/2016*/compJx_at_bWrite_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1bw
cat 2/2016*/compJx_at_bWrite_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2bw

c1_bw=`cat 1bw|gawk '{print($8)}'`
c2_bw=`cat 2bw|gawk '{print($8)}'`

echo checking current AFTER WRITE
cat 1/2016*/compJx_at_awrite_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1aw
cat 2/2016*/compJx_at_awrite_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2aw

c1_aw=`cat 1aw|gawk '{print($8)}'`
c2_aw=`cat 2aw|gawk '{print($8)}'`




echo checking current at 1,12,0 bSUM step 2
cat 1/2016*/compJx_at_bSUM_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1curb
cat 2/2016*/compJx_at_bSUM_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2curb

c1_bsum2=`cat 1curb|gawk '{print($8)}'`
c2_bsum2=`cat 2curb|gawk '{print($8)}'`


cmp 1cur 2cur >&cmp_curb
if [  -s cmp_curb ]
then
   echo CURRENTS DIFFER
   cat 1curb |gawk '{printf("1PROC: %s\n",$0)}'
   cat 2curb |gawk '{printf("2PROC: %s\n",$0)}'
else
   echo CURRENTS MATCH !!!!!!!!!!!!!!!!!!!!
fi


echo checking current at 1,12,0 aSUM step 2
cat 1/2016*/compJx_at_aSUM_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&1cur
cat 2/2016*/compJx_at_aSUM_*_rank00000_nt00000002.dat|grep \ 1\ \ \ \ 12 >&2cur

c1_asum2=`cat 1cur|gawk '{print($8)}'`
c2_asum2=`cat 2cur|gawk '{print($8)}'`


cmp 1cur 2cur >&cmp_cur
if [  -s cmp_cur ] 
then
   echo CURRENTS DIFFER
   cat 1cur |gawk '{printf("1PROC: %s\n",$0)}'
   cat 2cur |gawk '{printf("2PROC: %s\n",$0)}'
else
   echo CURRENTS MATCH !!!!!!!!!!!!!!!!!!!!
fi



echo CHECKING WRITE FROM CELLS TO GLOBAL ARRAY
cat 1/out1 |grep nt\ 2|grep global |grep rank\ 0|grep n\ \ \ \ 34 |sort -k17 -k18 -k19 >&cells2global1
cat 2/out2 |grep nt\ 2|grep global |grep rank\ 0|grep n\ \ \ \ 34 |sort -k17 -k18 -k19 >&cells2global2

#cat cells2global1
#cat cells2global2

cmp cells2global1 cells2global2 >&cmp_cell
if [  -s cmp_cell ]
then
   echo CELLS DIFFER
   cat cmp_cell
   ldiff=`cat cmp_cell|gawk '{print($7)}'`
   echo SHOWING LINES NUMBER $ldiff
   cat cells2global1 |gawk '{if(NR== '$ldiff') print}' |gawk '{printf("1P: %s\n",$0)}'
   cat cells2global2 |gawk '{if(NR== '$ldiff') print}' |gawk '{printf("2P: %s\n",$0)}'
   stl1=`cat cells2global1 |gawk '{if(NR== '$ldiff') print}'|gawk '{print($26)}'`
   stl2=`cat cells2global2 |gawk '{if(NR== '$ldiff') print}'|gawk '{print($26)}'`
   echo $stl1 $stl2

   echo 1 INITIAL VALUES DIFFERENCE
      cat cells2global1 |gawk '{print($26)}' >&c2g1_21 |gawk '{printf("1P: %s\n",$0)}'
      cat cells2global2 |gawk '{print($26)}' >&c2g2_21 |gawk '{printf("2P: %s\n",$0)}'
      ldiff=`cmp c2g2_21 c2g1_21 |gawk '{print($7)}'`
      echo LINE $ldiff

      cat cells2global1 |gawk '{if(NR=='$ldiff') print}' |gawk '{printf("1P: %s\n",$0)}'
      cat cells2global2 |gawk '{if(NR=='$ldiff') print}' |gawk '{printf("2P: %s\n",$0)}'

   
   echo 2 DIFFERENT CURRENTS BEING ADDED : 1st OCCURENCE
      cat cells2global2 |gawk '{print($28)}' >&c2g2_23
      cat cells2global1 |gawk '{print($28)}' >&c2g1_23
      cmp c2g2_23 c2g1_23 >&cmp_c2g
      if [ -s cmp_c2g ]
      then
        ldiff=`cmp c2g2_23 c2g1_23 |gawk '{print($7)}'`
        echo LINE $ldiff

        cat cells2global1 |gawk '{if(NR== '$ldiff') print}' |gawk '{printf("1PROC: %s\n",$0)}'
        cat cells2global2 |gawk '{if(NR== '$ldiff') print}' |gawk '{printf("2PROC: %s\n",$0)}'
      else
        echo COLUMNS MATCH !!!
      fi


   echo 3 FINAL VALUES
   tail -n 1 cells2global1 |gawk '{printf("1PROC: %s\n",$0)}'
   tail -n 1 cells2global2 |gawk '{printf("2PROC: %s\n",$0)}'
   fin1=`tail -n 1 cells2global1|gawk '{print($30)}'`
   fin2=`tail -n 1 cells2global2|gawk '{print($30)}'`


else
   echo CELLS MATCH !!!!!!!!!!!!!!!!!!!!
fi

echo                      1 PROC                2Proc
echo   aSUMstep1  $c1_aSUM1  $c2_aSUM1|gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   begin_nt2  $c1_beg2   $c2_beg2 |gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   astep_nt2  $c1_step2  $c2_step2|gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   bwritent2  $c1_bw  $c2_bw      |gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
#echo   wrfin_nt2  $fin1      $fin2    |gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo   awritent2  $c1_aw  $c2_aw      |gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   bSUM__nt2  $c1_bsum2  $c2_bsum2|gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'
echo   aSUM__nt2  $c1_asum2  $c2_asum2|gawk '{t= $3-$2;if(t < 0) t = -t;printf("%s %25.15e %25.15e %e\n",$1,$2,$3,t)}'



