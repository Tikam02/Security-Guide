
curl -s "https://crt.sh/?q=%.<domain>&output=json" | jq '.[].name_value' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > hosts-crtsh.txt

curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u > hosts-certspotter.txt


curl https://www.threatcrowd.org/searchApi/v2/domain/report/\?domain=$1 |jq .subdomains |grep -o ‘\w.*$1’curl https://api.hackertarget.com/hostsearch/\?q\=$1 | grep -o '\w.*$1'

curl https://crt.sh/?q=%.$1 | grep "$1" | cut -d '>' -f2 | cut -d '<' -f1 | grep -v " " | sort -u

curl https://certspotter.com/api/v0/certs?domain=$1 | grep  -o '\[\".*\"\]'
