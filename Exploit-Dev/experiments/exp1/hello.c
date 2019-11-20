#include "include/sfsyscall.h"

int main(void) 
{
        char buf[] = "Hello world!\n";
        write(1, buf, sizeof(buf));
        exit(0);
}
