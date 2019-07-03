
for((i=0;i <= 1;i++))
do

for((l=0;l <= 21;l++))
do
  
   echo $i $l ============================================
   
#   diff 1/2016*/compJx_at_bWriteAllCurrents_$[i]_$[l]_0__*_rank00000_nt00000002.dat \
#        1/2016*/compJx_at_aWriteAllCurrents_$[i]_$[l]_0__*_rank00000_nt00000002.dat >&df1_$[i]_$[l]

#   diff 2/2016*/compJx_at_bWriteAllCurrents_$[i]_$[l]_0__*_rank00000_nt00000002.dat \
#        2/2016*/compJx_at_aWriteAllCurrents_$[i]_$[l]_0__*_rank00000_nt00000002.dat >&df20_$[i]_$[l]    

#   diff 2/2016*/compJx_at_bWriteAllCurrents_$[i]_$[l]_0__*_rank00001_nt00000002.dat \
#        2/2016*/compJx_at_aWriteAllCurrents_$[i]_$[l]_0__*_rank00001_nt00000002.dat >&df21_$[i]_$[l]

#   cat df20_$[i]_$[l] df21_$[i]_$[l] >&df2_$[i]_$[l]

   cat  2/2016*/compJx_at_aWriteAllCurrents_$[i]_$[l]_0__*_rank00000_nt00000002.dat \
        2/2016*/compJx_at_aWriteAllCurrents_$[i]_$[l]_0__*_rank00001_nt00000002.dat \
        | gawk '{ai[NR]=$1;al[NR]=$2;ak[NR]=$3;n[NR]=$4;x[NR]=$5;y[NR]=$6;z[Nr]=$7;b[NR]=$8}
                END{for(i=1;i<=NR/2;i++)printf("%10d %5d %5d %10d %10.3e %10.3e %10.3e %25.15e\n",ai[i],al[i],ak[i],n[i],x[i],y[i],z[i],b[i]+b[i+NR/2])}' >&sum_$[i]_$[l]
done
done
