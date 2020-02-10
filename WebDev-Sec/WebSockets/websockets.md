# Websockets

## What are Websockets?



WebSockets are a bi-directional, full duplex communications protocol initiated over HTTP. They are commonly used in modern web applications for streaming data and other asynchronous traffic.

In this section, we'll explain the difference between HTTP and WebSockets, describe how WebSocket connections are established, and outline what WebSocket messages look like. 


## Why Websockets were Introduced?

- Servers to client connection HTTP.In,Http request-response it involves and HTTP connection open for a time until server has some data to push to the client.
Every time an HTTP request is made, a bunch of Headers and cookie data were transferred to the server, which eventually leads to large amount of data that need to be transferred,which in turn increases latency.

- Then the developers made a solution to overcome this problem,the need for a persistent low latency connection that can support transactions initiated by either the client or server.This is what exactly websockets provide.

- WebSockets initiates a bi-directional realtime communication between servers and clients.

## Difference between HTTP and WebSockets.

- Most communication between web browsers and web sites uses HTTP. With HTTP, the client sends a request and the server returns a response. Typically, the response occurs immediately, and the transaction is complete. Even if the network connection stays open, this will be used for a separate transaction of a request and a response.

- Some modern web sites use WebSockets. WebSocket connections are initiated over HTTP and are typically long-lived. Messages can be sent in either direction at any time and are not transactional in nature. The connection will normally stay open and idle until either the client or the server is ready to send a message.

- WebSockets are particularly useful in situations where low-latency or server-initiated messages are required, such as real-time feeds of financial data. 

## What are WebSockets used For?

- Social Feeds
- Multiplayer games
- Collabrative editing/Coding
- Clickstream data
- Financial Tickets
- Sports updates
- Multimedia chats
- Location-Based Apps
- Online Education

## Websockets Connection

- To establish the connection, the browser and server perform a WebSocket handshake over HTTP. The browser issues a WebSocket handshake request like the following:

```javascript
GET /chat HTTP/1.1
Host: normal-website.com
Sec-WebSocket-Version: 13
Sec-WebSocket-Key: wDqumtseNBJdhkihL6PW7w==
Connection: keep-alive, Upgrade
Cookie: session=KOsEJNuflw4Rd9BDNrVmvwBF9rEijeE2
Upgrade: websocket
```

- If the server accepts the connection, it returns a WebSocket handshake response like the following:

```javascript
HTTP/1.1 101 Switching Protocols
Connection: Upgrade
Upgrade: websocket
Sec-WebSocket-Accept: 0FFP+2nmNIf/h+4BP36k9uzrYGk=
```
- At this point, the network connection remains open and can be used to send WebSocket messages in either direction

>  Several features of the WebSocket handshake messages are worth noting:

- The Connection and Upgrade headers in the request and response indicate that this is a WebSocket handshake.
- The Sec-WebSocket-Version request header specifies the WebSocket protocol version that the client wishes to use. This is typically 13.
- The Sec-WebSocket-Key request header contains a Base64-encoded random value, which should be randomly generated in each handshake request.
- The Sec-WebSocket-Accept response header contains a hash of the value submitted in the Sec-WebSocket-Key request header, concatenated with a specific string defined in the protocol specification. This is done to prevent misleading responses resulting from misconfigured servers or caching proxies.


## Exploits

### Manipulating WebSocket messages to exploit vulnerabilities

 The majority of input-based vulnerabilities affecting WebSockets can be found and exploited by tampering with the contents of WebSocket messages.

For example, suppose a chat application uses WebSockets to send chat messages between the browser and the server. When a user types a chat message, a WebSocket message like the following is sent to the server:

{"message":"Hello Carlos"}

The contents of the message are transmitted (again via WebSockets) to another chat user, and rendered in the user's browser as follows:

<td>Hello Carlos</td>

In this situation, provided no other input processing or defenses are in play, an attacker can perform a proof-of-concept XSS attack by submitting the following WebSocket message:

{"message":"<img src=1 onerror='alert(1)'>"} 

1. Start Chat App
2. Observe the Chat request and response by intercepting
3. Intercept the "chat messages"
4. Alter the "chat messsage" with XSS script : <img src=1 onerror='alert(1)'> 
5. And send the request
6. we will get the XSS attack.

### Manipulating the WebSocket handshake to exploit vulnerabilities

Manipulating the WebSocket handshake to exploit vulnerabilities

Some WebSockets vulnerabilities can only be found and exploited by manipulating the WebSocket handshake. These vulnerabilities tend to involve design flaws, such as:

    Misplaced trust in HTTP headers to perform security decisions, such as the X-Forwarded-For header.
    Flaws in session handling mechanisms, since the session context in which WebSocket messages are processed is generally determined by the session context of the handshake message.
    Attack surface introduced by custom HTTP headers used by the application.


## Rererences:

- [Websockets Tutorials](https://blog.teamtreehouse.com/an-introduction-to-websockets)

