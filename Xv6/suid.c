//suid.c sets the user ID
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
  uint uid;
  if(argc != 2)
  {
    printf(1, "usage: suid USER_ID\n");
    exit();
  }
  
  uid = atoi(argv[1]);  
  uid = suid(uid);
  printf(1, "UID is now: %d\n", uid);
  
  exit();
}
