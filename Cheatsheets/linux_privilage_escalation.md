# Enumeration is the key.
>(Linux) privilege escalation is all about:

 -   Collect - Enumeration, more enumeration and some more enumeration.
 -    Process - Sort through data, analyse and prioritisation.
 -   Search - Know what to search for and where to find the exploit code.
  -  Adapt - Customize the exploit, so it fits. Not every exploit work for every system "out of the box".
  -  Try - Get ready for (lots of) trial and error.
****

## Operating System
#### What's the distribution type? What version?
```
  cat /etc/issue
  cat /etc/*-release
  cat /etc/lsb-release      # Debian based
  cat /etc/redhat-release   # Redhat based
```

#### What's the kernel version? Is it 64-bit?
```
 cat /proc/version
 uname -a
 uname -mrs
 rpm -q kernel
 dmesg | grep Linux
 ls /boot | grep vmlinuz-
```
#### What can be learnt from the environmental variables?

```
 cat /etc/profile
 cat /etc/bashrc
 cat ~/.bash_profile
 cat ~/.bashrc
 cat ~/.bash_logout
 env
 set
```

#### Is there a printer?
``` 
 lpstat -a
```

*****
## Applications & Services 

#### What services are running? Which service has which user privilege?
```
 ps aux
 ps -ef
 top
 cat /etc/services
```



