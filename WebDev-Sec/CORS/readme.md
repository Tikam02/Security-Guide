# CORS

## What is CORS?

- Web pages are under the restrictions of same-origin policy, which means scripts contained in a web page cannot access data in another page with different origin. 

- Cross-Origin Resource Sharing (CORS) is a mechanism that uses additional HTTP headers to tell browsers to give a web application running at one origin, access to selected resources from a different origin. A web application executes a cross-origin HTTP request when it requests a resource that has a different origin (domain, protocol, or port) from its own.

> An example of a cross-origin request: the front-end JavaScript code served from https://domain-a.com uses XMLHttpRequest to make a request for https://domain-b.com/data.json.

- For security reasons, browsers restrict cross-origin HTTP requests initiated from scripts. For example, XMLHttpRequest and the Fetch API follow the same-origin policy. This means that a web application using those APIs can only request resources from the same origin the application was loaded from, unless the response from other origins includes the right CORS headers.

- The Cross-Origin Resource Sharing standard works by adding new HTTP headers that let servers describe which origins are permitted to read that information from a web browser. Additionally, for HTTP request methods that can cause side-effects on server data (in particular, HTTP methods other than GET, or POST with certain MIME types), the specification mandates that browsers "preflight" the request, soliciting supported methods from the server with the HTTP OPTIONS request method, and then, upon "approval" from the server, sending the actual request. Servers can also inform clients whether "credentials" (such as Cookies and HTTP Authentication) should be sent with requests.

- CORS failures result in errors, but for security reasons, specifics about the error are not available to JavaScript. All the code knows is that an error occurred. The only way to determine what specifically went wrong is to look at the browser's console for details.


a. Pre-flight Requests

- A preflight request is automatically issued by a browser and in normal cases, front-end developers don't need to craft such requests themselves. It appears when request is qualified as "to be preflighted" and ommited for simple requests.

- For example, a client might be asking a server if it would allow a DELETE request, before sending a DELETE request, by using a preflight request:

```javascript
OPTIONS /resource/foo 
Access-Control-Request-Method: DELETE 
Access-Control-Request-Headers: origin, x-requested-with
Origin: https://foo.bar.org
```
- If the server allows it, then it will respond to the preflight request with an Access-Control-Allow-Methods response header, which lists DELETE:

```javascript
HTTP/1.1 204 No Content
Connection: keep-alive
Access-Control-Allow-Origin: https://foo.bar.org
Access-Control-Allow-Methods: POST, GET, OPTIONS, DELETE
Access-Control-Max-Age: 86400
```
- The preflight response can be optionally cached for the requests created in the same url using Access-Control-Max-Age header like in the above example.

b. to enable CORS for a general CORS request, you need to add the following headers:

- For preflight request which can be filtered by check method is ‘OPTIONS’:

```javascript
Access-Control-Allow-Origin
Access-Control-Allow-Credentials
```

- For actual CORS request which is not OPTIONS and has a Access-Control-Request-Method header:

```javascript
Access-Control-Allow-Origin
Access-Control-Allow-Methods
Access-Control-Allow-Headers
Access-Control-Allow-Credentials
(Optional) Access-Control-Max-Age
(Optional) Access-Control-Expose-Headers
```

## CORS Exploit

- Prerequisites

    - BURP HEADER> Origin: https://evil.com
    - VICTIM HEADER> Access-Control-Allow-Credential: true
    - VICTIM HEADER> Access-Control-Allow-Origin: https://evil.com


# References:

- [Mozila](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)

- [CORS, preflighted requests & OPTIONS method ](https://dev.to/effingkay/cors-preflighted-requests--options-method-3024)


