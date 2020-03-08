# for automating the domain and their responses CERTIFICATE TRANSPARANCY
for domain in `crtsh $1`; do
	echo $domain | tee -a recon/koho.ca/$1-13-02.2020.txt
	curl -i -s $domain | tee recon/koho.ca/curlout/$domain.txt
done
