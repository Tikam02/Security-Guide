Finding subdomains with SSL certs

If you find that port 443 is open, or an SSL port is open, you might be able to leverage this to get yourself some subdomains! You can either click on the cert and navigate and read all the information until you find some other valid certnames.

Or you can use this one-liner, (I recommend doing both though).

echo | openssl s_client -connect 0x00sec.org:443  | openssl x509 -noout -text | grep DNS | sed 's/,/\n/g'

Once you’ve got these, put them in your hosts file or try and request with curl:

curl -vv 'Host: yournewdomain.com' 10.10.10.40

You might get lucky! If you want to bruteforce these, you can use the auxiliary/scanner/http/vhost_scanner module in Metasploit.