#AUTHOR - Tikam Alma
#Recon Like you Own it

mkdir -p ./$1-output;

amass enum  -ip  -d $1 | tee ~/tools/recon/$1-output/$1.txt;
	
#all hosts
cat ~/tools/recon/$1-output/$1.txt | cut -d']' -f 2 | awk '{print $1}' | sort -u  >> ~/tools/recon/$1-output/$1-domains.txt;

#for getting IP address
cat  ~/tools/recon/$1-output/$1.txt | cut -d']' -f2 | awk '{print $2}' | tr ',' '\n' | sort -u >> ~/tools/recon/$1-output/$1-ip.txt;

#IPV4 Ips
cat ~/tools/recon/$1-output/$1-ip.txt | cut -d']' -f2 | awk '{print $2}' | tr ',' '\n' | sort -u | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" >> ~/tools/recon/$1-output/$1-ips-ipv4.txt;


#CRTSh

curl -s "https://crt.sh/?q=%.$1&output=json" | jq '.[].name_value' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > ~/tools/recon/$1-output/hosts-crtsh.txt

#Certspotter

#curl -s https://certspotter.com/api/v0/certs\?$1\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > ~/tools/recon/$1-output/hosts-certspotter.txt

# Certspotter - Domain
#curl "https://api.certspotter.com/v1/issuances?domain=&expand=dns_names&expand=issuer&expand=cert"

# Certspotter - Domain+Subdomains
#curl "https://api.certspotter.com/v1/issuances?domain=&include_subdomains=true&expand=dns_names&expand=issuer&expand=cert"


curl "https://api.certspotter.com/v1/issuances?domain=$1&include_subdomains=true&expand=dns_names&expand=issuer&expand=cert&output=json" | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > ~/tools/recon/$1-output/hosts-certspotter.txt


#Host Woordlist
sed 's/$/.'$1'/' ~/tools/wordlists/SecLists-master/Discovery/DNS/subdomains-top1million-20000.txt > ~/tools/recon/$1-output/hosts-wordlist.txt

# Mix and filter out

cat   ~/tools/recon/$1-output/$1-domains.txt ~/tools/recon/$1-output/$1-ip.txt ~/tools/recon/$1-output/$1-ips-ipv4.txt ~/tools/recon/$1-output/hosts-crtsh.txt ~/tools/recon/$1-output/hosts-certspotter.txt | sort -u | tee ~/tools/recon/$1-output/hosts-all.txt

#cp hosts-all.txt to ~/root/tools/massdns/recons


cp ~/tools/recon/$1-output/hosts-all.txt ~/tools/massdns/recons;


# MassDns
cd ~/tools/massdns/bin;
./massdns -r ~/tools/massdns/resolvers.txt -t A -o S -w ~/tools/recon/$1-output/massdns.out ~/tools/massdns/recons/hosts-all.txt;

# The first part is the host, second part is the DNS record type such as A, CNAME, etc. And the final part is the IP/host which the host resolved to.
# Clean massdns.txt

cat ~/tools/recon/$1-output/massdns.out | awk '{print $1}' | sed 's/.$//' | sort -u > ~/tools/recon/$1-output/hosts-online.txt


#After determining which hosts are online, the next interesting part is to find open ports. I could use nmap for this, but it’s way too slow for this, and masscan is perfect.
cat ~/tools/recon/$1-output/massdns.out | awk '{print $3}' | sort -u | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" > ~/tools/recon/$1-output/ips-online.txt


#Finally it’s time to run masscan. Providing it with the list of online IP’s. The following command will send 10,000 packets every second and check all 65535 ports. 
#It will report back only the ones that are seen as open, and output will be written to a simple list file named masscan.out.

#masscan -iL ~/tools/recon/koho.ca-output/ips-online.txt --rate 10000 -p1-65535 --only-open -oL masscan.out > ~/tools/recon/koho.ca-output/masscan.txt

#  masscan --rate 10000 -p1-65535 $(<ips-online.txt xargs -I % getent  hosts % | awk {'print $1'} | sort -u | tr '\n' ',' | sed 's/,$//') > ~/tools/recon/$1-output/masscan.txt

masscan -iL ~/tools/recon/$1-output/ips-online.txt --open --rate 60000 -p1-65535 | awk '{print $4}' > ~/tools/recon/$1-output/masscan.txt

#Once this is complete, use nmap to see which services that are running on each port:

# $ nmap -sV -p[port,port,...] [ip]
