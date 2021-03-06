/* *
 * Copyright 1993-2012 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 */
#include <stdio.h>
#include <stdlib.h>

#include <unistd.h>



int readParameterFile(int *beam_plasma,int *start_from_file,
		              double *tex0,double *tey0,double *tez0,
		              double *Tb,double *rimp,
		              double *rbd,double *ni,
			          double *lx,double *ly,double *lz,
			          int *lp,int *nx,int *ny,int *nz,
			          double *tau,double *B0,
			          int *np,double *bx,double *by,double *bz,
			          double *pl_y,double *pl_z,
			          int *ts,int *ms,int *phase)

{
	FILE *f;
	char str[1000];
	int n;

	if((f = fopen("000_params.dat","rt")) != NULL)
	{
        puts("reading parameter file directly from current path");
	}
	else
	{
	   if((f = fopen("0_plasma.dat","rt")) == NULL)
	   {
		   return 1;
	   }
	   else
	   {
           fgets(str,1000,f);
	       *beam_plasma = atoi(str);

	       fclose(f);

           if(*beam_plasma == 0)
	       {
	           chdir("./beam");
           }
	       else
           {
		       chdir("./plasma");
	       }

           if((f = fopen("000_params.dat","rt")) == NULL)
	       {
		       return 1;
  	       }
	   }
	}

	fgets(str,1000,f);
	*tex0 = atof(str);
	fgets(str,1000,f);
	*tey0 = atof(str);
	fgets(str,1000,f);
	*tez0 = atof(str);
	fgets(str,1000,f);
	*rimp = atof(str);
	fgets(str,1000,f);
	*Tb   = atof(str);
	fgets(str,1000,f);
	*rbd = atof(str);
	fgets(str,1000,f);
	*ni  = atof(str);
	fgets(str,1000,f);
	*B0 = atof(str);
	fgets(str,1000,f);
	*lx = atof(str);
	fgets(str,1000,f);
	*ly = atof(str);
	fgets(str,1000,f);
	*lz = atof(str);

	fgets(str,1000,f);
	*pl_y = atof(str);
	fgets(str,1000,f);
	*pl_z = atof(str);



	fgets(str,1000,f);
	*bx = atof(str);
	fgets(str,1000,f);
	*by = atof(str);
	fgets(str,1000,f);
	*bz = atof(str);

	fgets(str,1000,f);
	*np = atoi(str);
	fgets(str,1000,f);
	*nx = atoi(str);
	fgets(str,1000,f);
	*ny = atoi(str);
	fgets(str,1000,f);
	*nz = atoi(str);
	fgets(str,1000,f);
	*tau = atof(str);
	fgets(str,1000,f);
    *beam_plasma = atoi(str);
	fgets(str,1000,f);
	*start_from_file = atoi(str);
	fgets(str,1000,f);
	*phase = atoi(str);
	fgets(str,1000,f);
    *ts = atoi(str);
	fgets(str,1000,f);
    *ms = atoi(str);


	return 0;
}
