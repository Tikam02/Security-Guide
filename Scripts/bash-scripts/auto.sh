# for automating the domain and their responses
for domain in `crtsh $1`; do
	echo $domain | tee -a recon/hackerone.com/$1-11-11.2020.txt
	curl -i -s $domain | tee recon/hackerone.com/curlout/$domain.txt
done
