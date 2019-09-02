
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>

int main(void) {
	char *arg[2];
	
	arg[0] = "/bin/sh";
	arg[1] = NULL;

	execve("/bin/sh", arg, NULL);
	return 0;
}
