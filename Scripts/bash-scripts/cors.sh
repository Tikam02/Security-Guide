# Script for checking if the website has misconfigured CORS by using curl


#curl --head 'https://sketch.pixiv.net/@user_fnvj5388' -H 'Origin: https://artemis01.github.io'

url=$1

 
#curl --insecure --head ${url} -H 'Origin: https://artemis01.github.io' 


#curl -H "Access-Control-Request-Method: GET" -H "Origin: http://example.com" -I https://s3.amazonaws.com/your-bucket/file

#curl -H "Origin: http://example.com" --verbose \
#https://www.googleapis.com/discovery/v1/apis?fields=


curl -H "Origin: http://example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Requested-With" \
  -X OPTIONS --verbose \
  ${url} \
    





