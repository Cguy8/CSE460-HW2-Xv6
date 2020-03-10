#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_cps(void)
{
  return cps();
}

int
sys_nps(void)
{
  return nps();
}

int
sys_chpr (void)
{
  int pid, pr;
  if(argint(0, &pid) < 0)
    return -1;
  if(argint(1, &pr) < 0)
    return -1;

  return chpr ( pid, pr );
}

//edits for id system calls --- Colby Holloman
int
sys_getuid(void)
{
	return myproc()->uid;
}

int
sys_getgid(void)
{
	return myproc()->gid;
}

int
sys_getppid(void)
{
	if (myproc()->parent != 0)
		return myproc()->parent->pid;
	else return 0;
}

int
sys_setuid(void)
{
	int uid;
	if (argint(0,&uid) < 0)
		return -1;

	int returnValue = setuid((uint)uid);
	return returnValue;
}

int
sys_setgid(void)
{
	int gid;
	if (argint(0,&gid) < 0)
		return -1;

	int returnValue = setgid((uint)gid);
	return returnValue;
}

//starting edits---Ken Lin
int sys_date(void)
{
  struct rtcdate *d;
  if(argptr(0, (void*)&d, sizeof(struct rtcdate)) < 0)
    return -1;
  cmostime(d);
  return 0;
}
