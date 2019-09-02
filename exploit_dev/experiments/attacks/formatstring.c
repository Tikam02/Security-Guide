#include <stdio.h>

void main(int argc,char** argv)
{
	//printf accepts multiple arguments
	//firts argument is a format string
	//many programmers assume this is only argument
	printf(argv[1]);
}

/*
root@hal:~/Artemis/ctf/CTF/exd/experiments/attacks# gcc formatstring.c -o formatstring
root@hal:~/Artemis/ctf/CTF/exd/experiments/attacks# ./formatstring
root@hal:~/Artemis/ctf/CTF/exd/experiments/attacks# ./formatstring "hello developers"
hello developers
root@hal:~/Artemis/ctf/CTF/exd/experiments/attacks# ./formatstring "%p %p %p %p"
0x7fff73ff5bf8 0x7fff73ff5c10 0x7f3182ab1718 0x7f3182ab2d80
root@hal:~/Artemis/ctf/CTF/exd/experiments/attacks# ./formatstring "%p %p %p %p %n"
Segmentation fault

 */
