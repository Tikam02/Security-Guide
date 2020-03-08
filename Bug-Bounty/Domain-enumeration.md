# Methodologies


## Domain Enumeration

1. Enumerate all the domains+subdomains

```bash
amass enum  -ip  -d <domain>
```

2. Extract the hosts from the Amass file, to create a file named hosts-amass.txt.

```bash
$ cat amass_output/amass.txt | cut -d']' -f 2 | awk '{print $1}' | sort -u > hosts-amass.txt
```

3. To get the IP’s I change the $1 to $2 in awk, and use tr before sort -u to replace commas with newline then write the output to a file named ips-amass.txt

```bash
> cat amass_output/amass.txt | cut -d']' -f2 | awk '{print $2}' | tr ',' '\n' | sort -u > ips-amass.txt

```

4. This output contains both IPv4 and IPv6 results. If I only want a list of IPv4 addresses I add a final grep to the above command after sort -u.

```bash
grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b"
```

5. Check domains with crt.sh

```bash
$ curl -s "https://crt.sh/?q=%.<domain>&output=json" | jq '.[].name_value' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > hosts-crtsh.txt
```

6. Check domains with Cert Spotter

```bash
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > hosts-certspotter.txt

```

7. create a final wordlist using a dictionary list. There’s a lot of good lists out there, but I normally look at the lists in DNS discovery from SecLists.

```bash
$ sed 's/$/.<domain>/' subdomains-top1mil-20000.txt > hosts-wordlist.txt

```
> This command will append .<domain> to every line and write the output to hosts-wordlist.txt

```bash
$ cat subdomains-top1mil-20000.txt
www
mail
ftp

...$ sed 's/$/.example.com/' subdomains-top1mil-20000.txt > hosts-wordlist.txt


$ cat hosts-wordlist.txt
www.example.com
mail.example.com
ftp.example.com
```

8. There should be these four files:

	- hosts-amass.txt
        - hosts-crtsh.txt
        - hosts-certspotter.txt 
        - hosts-wordlist.txt

9. This will be merged, sorted and duplicates will be removed and written to a file named hosts-all.txt.

```bash
$ cat hosts-amass.txt hosts-crtsh.txt hosts-certspotter.txt hosts-wordlist.txt | sort -u > hosts-all.txt
```
10. Filter only Inscope domains

- Create a hosts-ignore.txt file and put all the out-of scope domains and IP.

- next use grep to remove out of scope hosts and create a hosts-inscope.txt

```bash
$ grep -vf hosts-ignore.txt hosts-all.txt > hosts-inscope.txt
```

11. Next use MassDns - becuase we need additional information and ports and services,

```bash
$ massdns -r resolvers.txt -t A -o S -w massdns.out hosts-inscope.txt
```

12. Filter Only Online services

```bash
$ cat massdns.out | awk '{print $1}' | sed 's/.$//' | sort -u > hosts-online.txt
```

13. After determining which hosts are online, the next interesting part is to find open ports. 

14. et all the IP’s from the previous massdns.out

```bash
$ cat massdns.out | awk '{print $3}' | sort -u | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" > ips-online.txt
```

15. Run massscan

```bash
sudo masscan -iL ips-online.txt --rate 10000 -p1-65535 --only-open -oL masscan.out
```

> Output 

```bash
$ cat masscan.out 
#masscan
open tcp 25 13.111.18.27 1556466271
open tcp 80 209.133.79.61 1556466775
open tcp 443 209.133.79.66 1556467350
```

16. Once this is complete I can use nmap to see which services that are running on each port:

```bash
$ nmap -sV -p[port,port,...] [ip]
```