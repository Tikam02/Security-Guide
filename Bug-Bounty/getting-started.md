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

