//Program to test id system calls.
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int
main(void)
{
	int returnCheck = 42;
	unsigned int uid, gid, ppid;

	uid = getuid();
	printf(1, "Current UID is: %d\n", uid);
	printf(1, "Setting UID to 100\n");
	returnCheck = setuid(100);
	printf(1, "Function returned %d\n", returnCheck);
	if (returnCheck == -1) {
		printf(2, "Error was encountered. Continuing tests.\n");
	}
	uid = getuid();
	printf(1, "Current UID is: %d\n", uid);

	gid = getgid();
	printf(1, "Current GID is: %d\n", gid);
	printf(1, "Setting GID to 100\n");
	returnCheck = setgid(100);
	printf(1, "Function returned %d\n", returnCheck);
	if (returnCheck == -1) {
		printf(2, "Error was encountered. Continuing tests.\n");
	}
	gid = getgid();
	printf(1, "Current GID is: %d\n", gid);

	ppid = getppid();
	printf(1, "My parent process is: %d\n", ppid);

	printf(1, "Setting UID to -42\n");
	returnCheck = setuid(-42);
	printf(1, "Function returned %d\n", returnCheck);
	if (returnCheck == -1) {
		printf(2, "Error was encountered. Continuing tests.\n");
	}
	uid = getuid();
	printf(1, "Current UID is: %d\n", uid);
	printf(1, "Setting GID to 90001\n");
	returnCheck = setgid(90001);
	printf(1, "Function returned %d\n", returnCheck);
	if (returnCheck == -1) {
		printf(2, "Error was encountered. Continuing tests.\n");
	}
	gid = getgid();
	printf(1, "Current GID is: %d\n", gid);
	printf(1, "Done!\n");

	exit();
}
