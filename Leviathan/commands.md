<h1>Commands Used In this CTF/Wargame</h1>
<hr>
<b>Commands Used</b>
<li>ls</li>
<li>ln</li>
<li>grep</li>
<li>ptrace-ltrace-strace</li>
<hr>
<li>ls</li>
<p> $ ls [optional ] [file|dir] </p>
<p>ls -a --> List all files including hidden file starting with '.'<br>
ls --color --> Colored list [=always/never/auto]</br>
ls -d --> list directories-with "/" <br>
ls -F --> add one char of /=>@| to entries <br>
ls -i --> list file's inode index number <br>
ls -l --> list with long format - show permissions <br>
ls -la --> list long format including with hidden files <br>
ls -lh --> list long format with readable file size<br>
ls -ls --> list with long format with file size<br>
ls -r  --> list in reverse order<br>
ls -R  --> list Recursively directory tree<br>
ls -s  --> list file size <br>
ls - S --> sort by File size<br>
ls -t --> sort by time and Date<br>
ls -X --> Sort By extension name<br>
list root directory --> $ ls / <br>
list parent directory --> $ .. <br>
list user's home directory --> $ ~ <br>
list all Subdirectories --> $ ls * <br> 
list files and directories with full path <br>
</p>
<hr>
<p><b>ltrace,ptrace and  strace</b></p>
<p>
<b>ptrace </b>is a system call which a program can use to:

    trace system calls
    read and write memory and registers
    manipulate signal delivery to the traced process

As you can see, ptrace is a really useful system call for tracing and manipulating other programs.<br>
<b>strace</b> is a system call and signal tracer.It is primarily used to trace system call(that is,funtion calls made from programs to the kernels),print the arguments passed to the system calls,print return values,timing information and more.It can also trace and output information about signals recievedd by the process.strace relies on the ptrace system calls.<br>

<b>ltrace</b>is a library call tracer and it is primarily used  to trace calls made by programs to library functions.it can also trace system calls and signals,like strace.
Both have similar command line options for thigs like printing timing information,return values,attaching to running processes and following forked processes.<br>

The <b>ptrace</b> system call is incredibly powerful and can be used to trace system calls,overwrite memory in a runnning program,read registers in a running program and more.
<b>strace</b>and<b>ltrace</b>both use <b>PTRACE_SYSCALL</b> to trace system calls.<b>ltrace</b> also uses <b>PTRACE_POKETEXT</b> to overwrite memory in a program in order to write a special instruction which halts the program.
</p>
<p>man strace,ptrace,ltrace</p> 
