./c
rm -rf 2
mkdir 2
cp all 2
cp 1/000_params.dat 2
cd 2
mpirun -np 2 ./all >&out2
cat out2|grep d_N
cd ..

tail 2/out2
echo ADD BEAM =================================
cat 2/*/add_beam_stat_rank0000*
