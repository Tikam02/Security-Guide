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



## Rererences:

- [Websockets Tutorials](https://blog.teamtreehouse.com/an-introduction-to-websockets)

