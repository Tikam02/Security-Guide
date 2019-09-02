;exitcall.asm
[SECTION .text]
global _start
_start:
mov    ebx,0 ;exit code, 0=normal exit
mov    eax,1 ;exit command to kernel
int    0x80  ;interrupt 80 hex, call kernel

