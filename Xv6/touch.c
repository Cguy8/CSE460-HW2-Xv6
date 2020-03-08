#include "types.h"
#include "stat.h"
#include "fcntl.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int fd;

  for (int i = 0; i < argc; i++)
  {
    fd = open(argv[i], O_CREATE);
    close(fd);
  }
 
  exit();

}
