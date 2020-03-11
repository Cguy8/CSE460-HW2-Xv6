//sgid.c sets the user ID
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  uint gid;
  if(argc != 2)
  {
    printf(1, "usage: sgid USER_ID\n");
    exit();
  }
  
  gid = atoi(argv[1]);  
  gid = sgid(gid);
  printf(1, "GID is now: %d\n", gid);
  
  exit();
}
