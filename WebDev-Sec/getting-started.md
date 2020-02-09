# How to get Started?

## Master The Curl

- [Popular Curl Examples](https://www.keycdn.com/support/popular-curl-examples)

- [Curl in bash Scripts](https://linuxhint.com/curl_bash_examples/)

- [Curl Project Home](https://curl.haxx.se/docs/httpscripting.html)


## Important header Informations:


> No-referrer — No referrer information is sent.

> No-referrer-when-downgrade — This is the default behavior if no policy is specified. It always passes the full path and will pass a value from HTTPS > HTTPS but not HTTPS > HTTP.

>Origin — Sends the domain but not the full path.

> Origin-when-cross-origin — Sends the full path when on the same domain, but only the domain when passing to another website.

> Same-origin — Sends the full path if it’s the same domain, but strips the value if going to another website.

> Strict-origin — Sends the domain for HTTPS > HTTPS and HTTP > HTTP, but not HTTPS > HTTP.

> Strict-origin-when-cross-origin — Sends the full path if on the same domain and from one secure page to another, sends the domain if going from HTTPS on one domain to another domain, and doesn’t pass if going from a secure domain to an insecure domain.

> Unsafe-url — Sends the full path.
