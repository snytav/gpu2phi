echo 1 PROC ===================================
cat 1/*/add_beam_stat_rank00000_nt0000000$1.dat
echo 2 PROC 0 =================================
cat 2/*/add_beam_stat_rank00000_nt0000000$1.dat
echo 2 PROC 1 =================================
cat 2/*/add_beam_stat_rank00001_nt0000000$1.dat

cat 2/*/add_beam_stat_rank0000?_nt0000000$1.dat |grep final |sort -n -k2 |gawk '{$3="";print}'  >&add2

cat 1/*/add_beam_stat_rank00000_nt0000000$1.dat |grep final |sort -n -k2 |gawk '{$3="";print}'  >&add1

diff add1 add2 

