/*
 * memory_control.cxx
 *
 *  Created on: Nov 16, 2016
 *      Author: snytav
 */


#include <sys/resource.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "mpi_shortcut.h"
#include <sys/sysinfo.h>


int GetDeviceMemory(size_t *m_free,size_t *m_total);

int get_mem_used_sizeMb()
{
  int i = 0;
  struct rusage r_usage;
  getrusage(RUSAGE_SELF,&r_usage);

  return (r_usage.ru_maxrss/1024/1024);
}

typedef struct {
    unsigned long size,resident,share,text,lib,data,dt;
} statm_t;

void read_off_memory_status(statm_t& result)
{
  unsigned long dummy;
  const char* statm_path = "/proc/self/statm";

  FILE *f = fopen(statm_path,"r");
  if(!f){
    perror(statm_path);
    abort();
  }
  if(7 != fscanf(f,"%ld %ld %ld %ld %ld %ld %ld",
    &result.size,&result.resident,&result.share,&result.text,&result.lib,&result.data,&result.dt))
  {
    perror(statm_path);
    abort();
  }
  fclose(f);
}

int get_mem_used_various(int nt,char *where)
{
	statm_t result;
	FILE *f;
	char s[100];
	size_t m_free,m_total;
    struct sysinfo info;

	sprintf(s,"memory_usage_rank%05d.dat",getRank());

	if((f = fopen(s,"at")) == NULL) return 1;

	 sysinfo(&info);
	 GetDeviceMemory(&m_free,&m_total);

	read_off_memory_status(result);

	fprintf(f,"nt %08d %20s RAM free %10u USED: size %ld resident %ld share %ld text %ld lib %ld data %ld dt %ld GPU total %10u free %10u (in Kb)\n",
			nt,
			where,
			info.freeram/1024,
			result.size/1024,
			result.resident/1024,
			result.share/1024,
			result.text/1024,
			result.lib/1024,
			result.data/1024,
			result.dt/1024,
			m_total/1024,
			m_free/1024
			);
	fclose(f);
	return 0;
}




