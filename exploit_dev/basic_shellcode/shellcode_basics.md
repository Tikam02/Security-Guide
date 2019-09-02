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
<li>"\x31\xc0"                                           xorl    %eax,%eax    </li>   
 <li> "\x99"                                            cdq== movl eax edx  </li>   
 <li> "\x52"                                              push edx                    </li>
 <li> "\x68\x2f\x63\x61\x74"                pushl 0x7461632f  </li>
 <li>"\x68\x2f\x62\x69\x6e"                pushl 0x6e69622f </li>
<li> "\x89\xe3"                                         mov ebx,esp   </li>
<li> "\x52"                                             push edx      </li>
<li>"\x68\x73\x73\x77\x64"                  pushl 0x64777373 </li>  
<li>"\x68\x2f\x2f\x70\x61"                pushl  0x61702f2f  </li>
<li>"\x68\x2f\x65\x74\x63"               pushl 0x6374652f </li>
<li>"\x89\xe1"                                       mov ecx,esp  </li>
<li>"\xb0\x0b"                                     mov  $0xb,%al            </li>                  
<li>"\x52"                                             push edx </li>
<li>"\x51"                                              push ecx </li>
<li>"\x53"                                             push ebx </li>
<li>"\x89\xe1"                                      mov ecx,esp   </li>
 <li>"\xcd\x80" ;                                    int 80h    </li>

<hr>
<p>In this repo/file there are three files:<br>
1.list.c ---->> which just calls execve to list all root files<br>
2. testshellcode.c ---->> Assembly language shellcode syntax embedded in c that is above Hex-opcodes <--> Assembly instructions.<br>
$ gcc -static -g -o testshellcode testshelcode.c <br>
$ ./testshellcod<br>
3.testshellcode.asm ---->> pure asm shellcode.<br>
$ nasm -f elf testshellcode.asm <br>
$ ld testshellcode.o -o testshellcode <br>
$ ./testshellcode<br>
</p>
These Three files will give you the same result.



