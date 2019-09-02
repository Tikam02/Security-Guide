
# What is Subdomain Takeover?

Subdomain takeover is a process of registering a non-existing domain name to gain control over another domain. The most common scenario of this process follows:

```

    Domain name (e.g., sub.example.com) uses a CNAME record to another domain (e.g., sub.example.com CNAME anotherdomain.com).
    At some point in time, anotherdomain.com expires and is available for registration by anyone.
    Since the CNAME record is not deleted from example.com DNS zone, anyone who registers anotherdomain.com has full control over sub.example.com until the DNS record is present.

```

The implications of the subdomain takeover can be pretty significant. Using a subdomain takeover, attackers can send phishing emails from the legitimate domain, perform cross-site scripting (XSS), or damage the reputation of the brand which is associated with the domain. You can read more about implications (risks) in my other post.

Subdomain takeover is not limited to CNAME records. NS, MX and even A records (which are not subject to this post) are affected as well. This post deals primarily with CNAME records. However, use cases for NS and MX records are presented where needed.

# [Basics Of Subdomain Takeover](https://0xpatrik.com/subdomain-takeover-basics/)


### Bug Hunter's Method -   Steps to take when approaching a target.
#### Why so many tools & techniques?

The more techniques used, the more chances to find interesting subdomains that others might have missed.
Some bug hunters recommend using only a handful of tools (like Amass, Massdns, Subfinder & Gobuster). But people who have a bad Internet connection & no VPS won’t be able to use these highly effective & fast tools. So choose whatever works for you!

### Methods

   - Scraping
   - Brute-force
   - Alterations & permutations of already known subdomains
   - Online DNS tools
   - SSL certificates
   - Certificate Transparency
   - Search engines
   - Public datasets
   - DNS aggregators
   - Git repositories
   - Text parsing (HTML, JavaScript, documents…)
   - VHost discovery
   - ASN discovery
   - Reverse DNS
   - Zone transfer (AXFR)
   - DNSSEC zone walking
   - DNS cache snooping
   - Content-Security-Policy HTTP headers
   - Sender Policy Framework (SPF) records
   - Subject Alternate Name (SAN)



1) Verify target’s scope (*.example.com);

2) Run Sublist3r on example.com and output all findings to a file called output:

```
$ sublist3r example.com -o output
...
$ cat output
foo.example.com
bar.example.com
admin.example.com
dev.example.com
www.example.com
git.example.com

```
3) Check which domains resolve:
```
$ while read domain; do if host "$domain" > /dev/null; then echo $domain; fi; done < output >> domains
```
4) Run webscreenshot on the domains file:
```
$ python webscreenshot.py -i domains output example
...
$ eog example
```
Tip: Look for 404 pages, login panels, directory listings and old-looking pages when reviewing the screenshots.

5) Run dirsearch on the domains file:
```
$ dirsearch-one
```

6) Check for open redirects using dirsearch on the domains file:
```
$ openredirect
```

## Getting Start

When brute forcing subdomains, the hacker iterates through a wordlist and based on the response can determine whether or not the host is valid. Please note, that it is very important to always check if the target has a wildcard enabled, otherwise you will end up with a lot of false-positives. Wildcards simply mean that all subdomains will return a response which skews your results. You can easily detect wildcards by requesting a seemingly random hostname that the target most probably has not set up.

``` $ host randomifje8z193hf8jafvh7g4q79gh274.example.com ```

host - host is a simple utility for performing DNS lookups. It is normally used to convert names to IP addresses and vice versa.

dig - Dig stands for (Domain Information Groper) is a network administration command-line tool for querying Domain Name System (DNS) name servers. It is useful for verifying and troubleshooting DNS problems and also to perform DNS lookups and displays the answers that are returned from the name server that were queried.

For the best results while brute forcing subdomains, I suggest creating your own personal wordlist with terms that you have come across in the past or that are commonly linked to services that you are interested in. For example, I often find myself looking for hosts containing the keywords "jira" and "git" because I sometimes find vulnerable Atlassian Jira and GIT instances.

If you are planning on brute forcing subdomains, I highly recommend taking a look at Jason Haddix's word list. Jason went to all the trouble of merging lists from subdomain discovery tools into one extensive list.


[Jason Hadix Wordlist](https://gist.github.com/jhaddix/86a06c5dc309d08580a018c66354a056)
 
## Automating your workflow

When hunting for subdomain takeovers, automation is key. The top bug bounty hunters constantly monitor targets for changes and continuously have an eye on every single subdomain that they can find. For this guide, I do not believe it is necessary to focus on monitoring setups. Instead, I want to stick to simple tricks that can save you time and can be easily automated.

The first task that I love automating is filtering out live subdomains from a list of hosts. When scraping for subdomains, some results will be outdated and no longer reachable; therefore, we need to determine which hosts are live. Please keep in mind, as we will see later, just because a host does not resolve, does not necessarily mean it cannot be hijacked. This task can easily be accomplished by using the.

```
while read subdomain; do
if host "$subdomain" > /dev/null; then
# If host is live, print it into
# a file called "live.txt".
echo "$subdomain" >> live.txt
fi
done < subdomain-list.txt
```
![Alt text](https://github.com/Tikam02/ReBuild/blob/master/img/sd1.png)

For taking screenshots, my go-to tool is currently EyeWitness. This tool generates an HTML document containing all the screenshots, response bodies, and headers from your list of hosts.

```$ ./EyeWitness -f live.txt -d out --headless```

EyeWitness can be a little too heavy for some cases and you might only want to store the page's contents via a simple GET request to the top-level directory of the subdomain. For cases like these, I use Tom Hudson's meg. meg sends requests concurrently and then store the output into plain-text files. This makes it a very efficient and light-weight solution for sieving through your subdomains and allows you to grep for keywords.

```$ meg -d 10 -c 200 / live.txt```



## Exploitation

Right, now you control a subdomain belonging to the target, what can you do next? When determining plausible attack scenarios with a misconfigured subdomain, it is crucial to understand how the subdomain interacts with the base name and the target's core service.

### Cookies

If the base name is vulnerable to session fixation and uses HTTPOnly cookies, you can set a cookie and then when the user restarts their browser, your malicious cookie will take precedence over the newly generated cookie because cookies are sorted by age.

### Cross-Origin Resource Sharing

Cross-Origin Resource Sharing (CORS), is a technology that allows a host to share contents of a page cross-origin. Applications create a scope with a set of rules that permits hosts to extract data including authenticated data. Some applications permit subdomains to make cross-origin HTTP requests with the assumption that subdomains are trusted entities. When you hijack a subdomain look for CORS headers — Burp Suite Pro's scanner usually picks them up — and see if the application whitelists subdomains. This could allow you to steal data from an authenticated user on the main application.

### Oauth whitelisting

Similar to Cross-Origin Resource Sharing, the Oauth flow also has a whitelisting mechanic, whereby developers can specify which callback URIs should be accepted. The danger here once again is when subdomains have been whitelisted and therefore you can redirect users during the Oauth flow to your subdomain, potentially leaking their Oauth token.

### Content-Security Policies

The Content-Security Policy (CSP) is yet another list of hosts that an application trusts, but the goal here is to restrict which hosts can execute client-side code in the context of the application. This header is particularly useful if one wants to minimise the impact of cross-site scripting. If your subdomain is included in the whitelist, you can use your subdomain to bypass the policy and execute malicious client-side code on the application.

```
$ curl -sI https://hackerone.com | grep -i "content-security-policy"
content-security-policy: default-src 'none'; base-uri 'self'; block-all-mixed-content; child-src www.youtube-nocookie.co
m; connect-src 'self' www.google-analytics.com errors.hackerone.net; font-src 'self'; form-action 'self'; frame-ancestor
s 'none'; img-src 'self' data: cover-photos.hackerone-user-content.com hackathon-photos.hackerone-user-content.com profi
le-photos.hackerone-user-content.com hackerone-us-west-2-production-attachments.s3-us-west-2.amazonaws.com; media-src 's
elf' hackerone-us-west-2-production-attachments.s3-us-west-2.amazonaws.com; script-src 'self' www.google-analytics.com;
style-src 'self' 'unsafe-inline'; report-uri https://errors.hackerone.net/api/30/csp-report/?sentry_key=61c1e2f50d21487c
97a071737701f598

```

### Reporting subdomain takeovers

Before you even attempt to report a subdomain takeover, make sure that you are in fact able to serve content on the subdomain. However, whatever you do, do not publish anything on the index page, even if it is a harmless picture of a frog as demonstrated earlier. It is best practice to serve an HTML file on a hidden path containing a secret message in an HTML comment. That should be enough to demonstrate the issue when initially contacting the programme about your finding. Only once the team has given you permission, should you attempt to escalate the issue and actually demonstrate the overall impact of the vulnerability. In most cases though, the team should already be aware of the impact and your report should contain information concerning the exploitability of subdomain takeovers.

Take your time when writing up a report about a subdomain takeover as this type of issue can be extremely rewarding and nobody can beat you to the report since you are — hopefully — the only one that has control over the subdomain.

*****

## Notable tools

There is a wide variety of tools out there for subdomain takeovers. This section contains some notable ones that have not been mentioned so far.

#### Altdns

In order to recursively brute force subdomains, take a look at Shubham Shah's Altdns script. Running your custom word list after fingerprinting a target through Altdns can be extremely rewarding. I like to use Altdns to generate word lists to then run through other tools.

#### Commonspeak

Yet another tool by Shubham, Commonspeak is a tool to generate word lists using Google's BigQuery. The goal is to generate word lists that reflect current trends, which is particularly important in a day and age where technology is rapidly evolving. It is worth reading https://pentester.io/commonspeak-bigquery-wordlists/ if you want to get a better understanding of how this tool works and where it gathers keywords from.

#### SubFinder

A tool that combines both scraping and brute forcing beautifully is SubFinder. I have found myself using SubFinder more than Sublist3r now as my general-purpose subdomain discovery tool. In order to get better results, make sure to include API keys for the various services that SubFinder scrapes to find subdomains.

#### Massdns

Massdns is a blazing fast subdomain enumeration tool. What would take a quarter of an hour with some tools, Massdns can complete in a minute. Please note, if you are planning on running Massdns, make sure you provide it with a list of valid resolvers. Take a look at https://public-dns.info/nameservers.txt, play around with the resolvers, and see which ones return the best results. If you do not update your list of resolvers, you will end up with a lot of false-positives.

```
$ ./scripts/subbrute.py lists/names.txt example.com | ./bin/massdns -r lists/resolvers.txt -t A -o S -w results.txt

```


#### SUBLIST3R
```
$ git clone https://github.com/aboul3la/Sublist3r.git
$ cd Sublist3r
$ sudo pip install -r requirements.txt
```
#### Aliases 

```
alias sublist3r='python /path/to/Sublist3r/sublist3r.py -d '

alias sublist3r-one=". <(cat domains | awk '{print \"sublist3r \"$1 \" -o \" $1 \".txt\"}')"
```

#### Dirsearch

```
$ git clone https://github.com/maurosoria/dirsearch.git
$ cd dirsearch/db
$ wget https://gist.githubusercontent.com/EdOverflow/c4d6d8c43b315546892aa5dab67fdd6c/raw/7dc210b17d7742b46de340b824a0caa0f25cf3cc/open_redirect_wordlist.txt

```

##### 💬 Aliases

```
alias dirsearch='python3 /path/to/dirsearch/dirsearch.py -u '

alias dirsearch-one=". <(cat domains | awk '{print \"dirsearch \"\$1 \" -e *\"}')"

alias openredirect=". <(cat domains | awk '{print \"dirsearch \"\$1 \" -w /path/to/dirsearch/db/open_redirect_wordlist.txt -e *\"}')"

```

####  webscreenshot 

```
$ git clone https://github.com/maaaaz/webscreenshot.git
```


AltDNS
```
    Description
        Subdomain discovery through alterations and permutations
        https://github.com/infosec-au/altdns
    Installation

    git clone https://github.com/infosec-au/altdns.git
    cd altdns
    pip install -r requirements.txt

    Usage:
        Generate a list of altered subdomains: ./altdns.py -i known-subdomains.txt -o new_subdomains.txt

        Generate a list of altered subdomains & resolve them: ./altdns.py -i known-subdomains.txt -o new_subdomains.txt -r -s resolved_subdomains.txt
        Other options
            -w wordlist.txt: Use custom wordlist (default altdns/words.txt)
            -t 10 Number of threads
            -d $IP: Use custom resolver
```
Amass
```
    Description
        Brute force, Google, VirusTotal, alt names, ASN discovery
        https://github.com/OWASP/Amass
    Installation
        go get -u github.com/OWASP/Amass/...
    Usage
        Get target’s ASN from http://bgp.he.net/
        amass -d target.com -o $outfile
        Get subdomains from ASN: amass.netnames -asn $asn
```
Assets-from-spf
```
    Description
        Parse net blocks & domain names from SPF records
        https://github.com/yamakira/assets-from-spf
    Installation

    git clone https://github.com/yamakira/assets-from-spf.git
    pip install click ipwhois

    Usage
        cd the-art-of-subdomain-enumeration; python assets_from_spf.py target.com
        Options
            --asn: Enable ASN enumeration
```
BiLE-suite
```
    Description
        HTML parsing, reverse DNS, TLD expansion, horizontal domain correlation
        https://github.com/sensepost/BiLE-suite
    Installation

    aptitude install httrack
    git clone https://github.com/sensepost/BiLE-suite.git

    Usage
        List links related to a site: cd BiLE-suite; perl BiLE.pl target.com target
        Extract subdomains from the results of BiLe.pl: ` cat target.mine 	grep -v “Link from” 	cut -d’:’ -f2 	grep target.com 	sort 	uniq`
```
Bing
```
    Search engine
    Usage
        Find subsomains: site:target.com
        Find subdomains & exclude specific ones: site:target.com -site:www.target.com
```
Censys_subdomain_enum.py
```
    Description
        Extract domains & emails from SSL/TLS certs collected by Censys
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/censys_subdomain_enum.py
    Installation

    pip install censys
    git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git

        Add your CENSYS API ID & SECRET to the-art-of-subdomain-enumeration/censys_subdomain_enum.py
    Usage
        cd the-art-of-subdomain-enumeration; python censys_enumeration.py target.com
```
Cloudflare_enum.py
```
    Description
        Extract subdomains from Cloudflare
        DNS aggregator
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/cloudflare_subdomain_enum.py
    Installation

    pip install censys
    git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git

    Usage
        the-art-of-subdomain-enumeration; python cloudflare_subdomain_enum.py your@cloudflare.email target.com
```
Crt_enum_psql.py
```
    Description
        Query crt.sh postgres interface for subdomains
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/crt_enum_psql.py
    Installation

    pip install psycopg2
     git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git

    Usage
        cd python the-art-of-subdomain-enumeration; python crtsh_enum_psql.py target.com
```
Crt_enum_web.py
```
    Description
        Parse crt.sh web page for subdomains
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/crt_enum_web.py
    Installation

    pip install psycopg2
     git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git

    Usage
        cd python the-art-of-subdomain-enumeration; python3 crtsh_enum_web.py target.com
```
CTFR
```
    Description
        Enumerate subdomains using CT logs (crt.sh)
        https://github.com/UnaPibaGeek/ctfr
    Installation

    git clone https://github.com/UnaPibaGeek/ctfr.git
    cd ctfr
    pip3 install -r requirements.txt

    Usage
        cd ctfr; python3 ctfr.py -d target.com -o $outfile
```
Dig
```
    Description
        Zone transfer, DNS lookups & reverse lookups
    Installation
        Installed by default in Kali, otherwise:
        aptitude instal dnsutils
    Usage dig +multi AXFR target.com dig +multi AXFR $ns_server target.com
```
Domains-from-csp
```
    Description
        Extract domain names from Content Security Policy(CSP) headers
        https://github.com/yamakira/domains-from-csp
    Installation

    git clone https://github.com/yamakira/domains-from-csp.git
    pip install click

    Usage
        Parse CSP header for domains: cd domains-from-csp; python csp_parser.py $URL
        Parse CSP header & resolve the domains: cd domains-from-csp; python csp_parser.py $URL -r
```
Dnscan
```
    Description
        AXFR, brute force
        https://github.com/rbsec/dnscan
    Install

    git clone https://github.com/rbsec/dnscan.git
    cd dnscan
    pip install -r requirements.txt

    Usage
        Subdomain brute-force of a domain: dnscan.py -d target.com -o outfile -w $wordlist
        Subdomain brute-force of domains listed in a file (one by line): dnscan.py -l $domains_file -o outfile -w $wordlist
        Other options:
            -i $file: Output discovered IP addresses to a text file
            -r: Recursively scan subdomains
            -T: TLD expansion
```
Dnsrecon
```
    Description
        DNS zone transfer, DNS cache snooping, TLD expansion, SRV enumeration, DNS records enumeration, brute-force, check for Wildcard resolution, subdomain scraping, PTR record lookup, check DNS server cached records, mDNS records enumeration…
        https://github.com/darkoperator/dnsrecon
    Installation
        aptitude install dnsrecon on Kali, or:

        git clone https://github.com/darkoperator/dnsrecon.git
        cd dnsrecon
        pip install -r requirements.txt

    Usage
        Brute-force: dnsrecon -d target.com -D wordlist.txt -t brt
        DNS cache snooping: dnsrecon -t snoop -D wordlist.txt -n 2.2.2.2 where 2.2.2.2 is the IP of the target’s NS server
        Options
            --threads 8: Number of threads
            -n nsserver.com: Use a custom name server
            Output options
                --db: SQLite 3 file
                --xml: XML file
                --json: JSON file
                --csv: CSV file
```
Dnssearch
```
    Description
        Subdomain brute-force
        https://github.com/evilsocket/dnssearch
    Installation

    go get github.com/evilsocket/dnssearch

        Add ~/go/bin/ to PATH by adding this line to ~/.profile: export PATH=$PATH:/home/mima/go/bin/
    Usage
        dnssearch -domain target.com -wordlist $wordlist
        Other options
            -a bool: Lookup A records (default true)
            -txt bool: Lookup TXT records (default false)
            -cname bool: Show CNAME records (default false)
            -consumers 10: Number of threads (default 8)
```
Domained
```
    Description
        Wrapper for Sublist3r, Knock, Subbrute, Massdns, Recon-ng, Amass & SubFinder
        https://github.com/cakinney/domained
    Installation

    git clone https://github.com/cakinney/domained.git
    cd domained
    pip install -r ./ext/requirements.txt
    python domained.py --install

    Usage
        Run Sublist3r (+subbrute), enumall, Knock, Amass & SubFinder: python domained.py -d target.com
        Run only Amass & Subfinder: python domained.py -d target.com --quick
        Brute-force with massdns & subbrute with Seclist wordlist, plus Sublist3r, Amass, enumall & SubFinder: python domained.py -d target.com --b
        Bruteforce with Jason Haddix’s All.txt wordlist, plus Sublist3r, Amass, enumall & SubFinder: python domained.py -d target.com -b --bruteall
        Other options
            --notify: Send Pushover or Gmail notifications
            --noeyewitness: No Eyewitness
            --fresh: Delete old data from output folder
```
Fierce
```
    Description
        AXFR, brute force, reverse DNS
        https://github.com/bbhunter/fierce-domain-scanner (original link not available anymore)
    Installation
        Installed by default on Kali
    Usage fierce -dns target.com
```
Gobuster
```
    Description
        todo
        https://github.com/OJ/gobuster
    Installation

    git clone https://github.com/OJ/gobuster.git
    cd gobuster/
    go get && go build
    go install

    Usage
        gobuster -m dns -u target.com -w $wordlist
        Other options:
            -i: Show IP addresses
            -t 50: Number of threads (default 10)
```
Google
```
    Search engine
    Usage
        Find subsomains: site:*.target.com
        Find subdomains & exclude specific ones: site:*.target.com -site:www.target.com -site:help.target.com
```
Knock
```
    Description
        AXFR, virustotal, brute-force
        https://github.com/guelfoweb/knock
    Install

    apt-get install python-dnspython
    git clone https://github.com/guelfoweb/knock.git
    cd knock
    nano knockpy/config.json # <- set your virustotal API_KEY
    python setup.py install

    Usage
        Use default wordlist: knockpy target.com
        Use custom wordlist: knockpy target.com -w $wordlist
        Resolve domain name & get response headers: knockpy -r target.com or knockpy -r $ip
        Save scan output in CSV: knockpy -c target.com
        Export full report in JSON: knockpy -j target.com
```
Ldns-walk
```
    Description
        DNSSEC zone walking
    Installation
        aptitude install ldnsutils
    Usage
        Detect if DNSSEC NSEC or NSEC3 is used:
            ldns-walk target.com
            ldns-walk @nsserver.com target.com
        If DNSSEC NSEC is enabled, you’ll get all the domains
        If DNSSEC NSEC3 is enabled, use Nsec3walker
```
Massdns
```
    Description
        DNS resolver
        https://github.com/blechschmidt/massdns
    Installation

    git clone https://github.com/blechschmidt/massdns.git
    cd massdns/
    make

    Usage
        Resolve domains: cd massdns; ./bin/massdns -r lists/resolvers.txt -t AAAA -w results.txt domains.txt -o S -w output.txt
        Subdomain brute-force: ./scripts/subbrute.py wordlist.txt target.com | ./bin/massdns -r lists/resolvers.txt -t A -o S -w output.txt
        Get subdomains with CT logs parser & resolve them with Massdns: ./scripts/ct.py target.com | ./bin/massdns -r lists/resolvers.txt -t A -o S -w output.txt
        Other options:
            -s 5000: Number of concurrent lookups (default 10000)
            -t A (default), -t AAAA, -t PTR…: Type of DNS records to retrieve
            Output options
                -o S -w output.txt: Save output as simple text
                -o F: Save output as full text
                -o J: Save output as ndjson
```
Nsec3walker
```
    Description
        DNSSEC NSEC3 zone walking
        https://dnscurve.org/nsec3walker.html
    Installation

    wget https://dnscurve.org/nsec3walker-20101223.tar.gz
    tar -xzf nsec3walker-20101223.tar.gz
    cd nsec3walker-20101223
    make

    Usage

    ./collect target.com > target.com.collect
    ./unhash  target.com.collect > target.com.unhash
    cat target.com.unhash | grep "target" | wc -l
    cat target.com.unhash | grep "target" | awk '{print $2;}'
```
Rapid7 Forward DNS dataset (Project Sonar)
```
    Description
        Public dataset containing the responses to DNS requests for all forward DNS names known by Rapid7’s Project Sonar
        https://opendata.rapid7.com/sonar.fdns_v2/
    Installation
        aptitude install jq pigz
    Usage

    wget https://scans.io/data/rapid7/sonar.fdns_v2/20170417-fdns.json.gz
    cat 20170417-fdns.json.gz | pigz -dc | grep ".target.org" | jq`
```
San_subdomain_enum.py
```
    Description
        Extract subdomains listed in Subject Alternate Name(SAN) of SSL/TLS certificates
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/san_subdomain_enum.py
    Installation
        git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git
    Usage
        cd python the-art-of-subdomain-enumeration; ./san_subdomain_enum.py target.com
```
Second Order
```
    Description
        Second-order subdomain takeover scanner
        Can also be leveraged as an HTML parser to enumerate subdomains
        https://github.com/mhmdiaa/second-order
    Installation
        go get github.com/mhmdiaa/second-order
    Usage
        Create a new copy of the default config.json file: cp ~/go/src/github.com/mhmdiaa/second-order/config.json ~/go/src/github.com/mhmdiaa/second-order/config-subs-enum.json
        And edit ` ~/go/src/github.com/mhmdiaa/second-order/config-subs-enum.json to replace “LogCrawledURLs”: false with “LogCrawledURLs”: true`
        second-order -base https://target.com -config config.json -output target.com
        Look for new subdomains in the resulting folder (./target.com)
```
Subbrute
```
    Description
        Brute-force
        https://github.com/TheRook/subbrute
    Installation

    aptitude install python-dnspython
    git clone https://github.com/TheRook/subbrute.git

    Usage
        Test a single domain: ./subbrute.py target.com
        Test multiple domains: ./subbrute.py target1.com target2.com
        Test a list of domains: ./subbrute.py -t domains.txt
        Enumerate subdomains, then their own subdomains:

        ./subbrute.py target.com > target.out
        ./subbrute.py -t target.out

        Other options
            -s wordlist.txt: Use a custom subdomains wordlist
            -p: Print data from DNS records
            -o outfile.txt: Save output in Greppable format
            -j JSON: Save output to JSON file
            -c 10: Number of threads (default 8)
            -r resolvers.txt: Use a custom list of DNS resolvers
```
Subfinder
```
    Description
        VirusTotal, PassiveTotal, SecurityTrails, Censys, Riddler, Shodan, Bruteforce
        https://github.com/subfinder/subfinder
    Installation:
        go get github.com/subfinder/subfinder
        Configure API keys: ./subfinder --set-config VirustotalAPIKey=0x41414141
    Usage
        Scraping: ./subfinder -d target.com -o $outfile
        Scraping & brute-force: subfinder -b -d target.com -w $wordlist -o $outfile
        Brute-force only: ./subfinder --no-passive -d target.com -b -w $wordlist -o $outfie
        Other options:
            -t 100: Number of threads (default 10)
            -r 8.8.8.8,1.1.1.1 or -rL resolvers.txt: Use custom resolvers
            -nW: Exclude wildcard subdomains
            -recursive: Use recursion
            -o $outfile -oJ: JSON output
```
Sublist3r
```
    Description
        Baidu, Yahoo, Google, Bing, Ask, Netcraft, DNSdumpster, VirusTotal, Threat Crowd, SSL Certificates, PassiveDNS
        https://github.com/aboul3la/Sublist3r
    Installation

    git clone https://github.com/aboul3la/Sublist3r.git
    cd Sublist3r
    pip install -r requirements.txt

    Usage
        Scraping: ./sublist3r.py -d target.com -o $outfile
        Bruteforce: ./sublist3r.py -b -d target.com -o $outfile
        Other options:
            -p 80,443: Show only subdomains which have open ports 80 and 443
```
Theharvester
```
    Description
        Tool for gathering subdomain names, e-mail addresses, virtual hosts, open ports/ banners, and employee names from different public sources
        Scraping, Brute-force, Reverse DNS, TLD expansion
        Scraping sources: Threatcrowd, Crtsh, Google, googleCSE, google-profiles, Bing, Bingapi, Dogpile, PGP, LinkedIn, vhost, Twitter, GooglePlus, Yahoo, Baidu, Shodan, Hunter
        https://github.com/laramies/theHarvester
    Installation
        aptitude install theharvester
    Usage
        Scraping: theharvester -d target.com -b all
        Other options:
            -h output.html: Save output to HTML file
            -f output.html: Save output to HTML & XML files
            -t: Also do TLD expansion discovery
            -c: Also do subdomain bruteforce
            -n: Also do a DNS reverse query on all ranges discovered
```
vhost-brute
```
    Description
        vhosts brute-force
        https://github.com/gwen001/vhost-brute
    Installation

    aptitude install php-curl
    git clone https://github.com/gwen001/vhost-brute.git

    Usage
        php vhost-brute.php --ip=$ip --domain=target.com --wordlist=$outfile
        Other options:
            --threads=5: Maximum threads (default 1)
            --port: Set port
            --ssl: Force SSL
```
Virtual-host-discovery
```
    Description
        vhosts brute-force
        https://github.com/jobertabma/virtual-host-discovery
    Installation
        git clone https://github.com/jobertabma/virtual-host-discovery.git
    Usage
        cd virtual-host-discover; ruby scan.rb --ip=1.1.1.1 --host=target.com --output output.txt
        Other options
            --ssl=on: Enable SSL
            --port 8080: Use a custom port
            --wordlist wordlist.txt: Use a custom wordlist
```
Virustotal_subdomain_enum.py
```
    Description
        Query VirusTotal API for subdomains
        DNS aggregator
        https://github.com/appsecco/the-art-of-subdomain-enumeration/blob/master/virustotal_subdomain_enum.py
    Installation
        git clone https://github.com/appsecco/the-art-of-subdomain-enumeration.git
    Usage
        python virustotal_subdomain_enum.py target.com 40
```

****

# Important Links 
[Hackerone-SubDomain - Takeover](https://www.hackerone.com/blog/Guide-Subdomain-Takeovers)


[Automating your reconnaissance workflow with meg ](https://dev.to/edoverflow/-automating-your-reconnaissance-workflow-with-meg-2koi)

[Edoverflow-blog](https://dev.to/edoverflow)


[Subdomain-Takeover-Basics](https://0xpatrik.com/subdomain-takeover-basics/)

[How To Do Your Reconnaissance Properly Before Chasing A Bug Bounty](https://medium.com/bugbountywriteup/guide-to-basic-recon-bug-bounties-recon-728c5242a115)

[10 Rules of Bug Bounty](https://hackernoon.com/10-rules-of-bug-bounty-65082473ab8c)

[BUG BOUNTY HUNTING (METHODOLOGY , TOOLKIT , TIPS & TRICKS , Blogs)](https://medium.com/bugbountywriteup/bug-bounty-hunting-methodology-toolkit-tips-tricks-blogs-ef6542301c65)


[LevelUp 0x02 — Bug Bounty Hunter Methodology v3 — Notes](https://medium.com/@nicklaus_park/levelup-0x02-bug-bounter-hunter-methodology-v3-8f5b802af2ad)

[Subdomain Takeover-Cheatsheet](https://pentester.land/cheatsheets/2018/11/14/subdomains-enumeration-cheatsheet.html)

[Hackerone-Subdomain Takeover](https://www.hackerone.com/blog/Guide-Subdomain-Takeovers)
