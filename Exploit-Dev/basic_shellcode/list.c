#include<unistd.h>
main()
{
    char *ls[3];
    ls[0]="/bin/cat";
    ls[1]="/etc/passwd";
    ls[2]=NULL;
    execve(ls[0],ls,NULL);
}
