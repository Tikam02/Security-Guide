# Script for checking if the website has misconfigured CORS by using curl


#curl --head 'https://sketch.pixiv.net/@user_fnvj5388' -H 'Origin: https://artemis01.github.io'

url=$1

 
curl --head ${url} -H 'Origin: https://artemis01.github.io'

 
cat  headers

 
cat headers | head -n 1 | cut '-d ' '-f2'
