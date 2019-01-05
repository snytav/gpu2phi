BEGIN{nr0 = 0}
{
    fn[NR]   = $14
    i1[NR]   = $15
    l1[NR]   = $16
    k1[NR]   = $17
    st[NR]   = $12

    f = fn[NR]
    i = $15
    l = $16
    k = $17
    jx[f,i,k,l] += $18

    if($8 == 0) nr0++
}
END{
    print("rank0 ",nr0)

    for(j=1;j <= nr0;j++)
    {
        f = fn[j]
        i = i1[j]
        l = l1[j]
        k = k1[j]
        s = st[j]
        
        printf("%10d %d %3d %3d %3d %25.15e\n",f,s,i,l,k,jx[f,i,l,k])    
    }

}
