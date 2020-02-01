## Vertical Privilege Escalation

1. Unprotected Functionality

- A vertical privilege escalation arises when an application has weak or does not build
  a good protection over sensitive functionality.

- Example - Admin panels can be opened by users just by linking /admin url.

``` https://example.com/admin ```

 This might in fact be accessible by any user, not only administrative users who have a link to the functionality in their user interface. In some cases, the administrative URL might be disclosed in other locations, such as the robots.txt file:

 ``` https://insecure-website.com/robots.txt```

Even if the URL isn't disclosed anywhere, an attacker may be able to use a wordlist to brute-force the location of the sensitive functionality. 


- Check for /robots.txt ->> Unprotected admin functionality
- check for  the URL that  might be disclosed in JavaScript that constructs the user interface based on the user's role. -->>  Unprotected admin functionality with unpredictable URL


2. Parameter Based Access Control Methods

- Some applications determine the user's access rights or role at login, and then store this information in a user-controllable location, such as a hidden field, cookie, or preset query string parameter. The application makes subsequent access control decisions based on the submitted value. For example:

```html
https://insecure-website.com/login/home.jsp?admin=true
https://insecure-website.com/login/home.jsp?role=1
```

- This approach is fundamentally insecure because a user can simply modify the value and gain access to functionality to which they are not authorized, such as administrative functions. 

a. User role controlled by Request parameter

- chane cookies like admin:true or admin:1

b. User role can be modified in user profile.

- example : 

```text
Log in using the supplied credentials.

Click on "My Account" and submit a new email address.

Observe that the response contains your role ID.

Send the email submission request to Burp Repeater, add "roleid":2 into the JSON in the request body, and resend it.

Observe that the response shows your roleid has changed to 2.

Browse to /admin and delete carlos.
```



3.Broken access control resulting from platform misconfiguration

Some applications enforce access controls at the platform layer by restricting access to specific URLs and HTTP methods based on the user's role. For example an application might configure rules like the following:

DENY: POST, /admin/deleteUser, managers

This rule denies access to the POST method on the URL /admin/deleteUser, for users in the managers group. Various things can go wrong in this situation, leading to access control bypasses.

Some application frameworks support various non-standard HTTP headers that can be used to override the URL in the original request, such as X-Original-URL and X-Rewrite-URL. If a web site uses rigorous front-end controls to restrict access based on URL, but the application allows the URL to be overridden via a request header, then it might be possible to bypass the access controls using a request like the following:

POST / HTTP/1.1
X-Original-URL: /admin/deleteUser 


a. URL-based access control can be circumvented

Try to load /admin and observe that you get blocked.

Observe that the response is very plain, suggesting it may originate from a front-end system.

Send the request to Burp Repeater. Change the URL in the request line to / and add the HTTP header X-Original-URL: /invalid. Observe that the application returns a "not found" response. This indicates that the back-end system is processing the URL from the X-Original-URL header.

Change the value of the X-Original-URL header to /admin. Observe that you can now access the admin page.

To delete the user carlos, add ?username=carlos to the real query string, and change the X-Original-URL path to /admin/delete.

b. Method-based access control can be circumvented

- An alternative attack can arise in relation to the HTTP method used in the request. The front-end controls above restrict access based on the URL and HTTP method. Some web sites are tolerant of alternate HTTP request methods when performing an action. If an attacker can use the GET (or another) method to perform actions on a restricted URL, then they can circumvent the access control that is implemented at the platform layer. 


Log in using the admin credentials.

Browse to the admin panel, promote carlos, and send the HTTP request to Burp Repeater.

Open a private/incognito browser window, and log in with the non-admin credentials.

Attempt to re-promote carlos with the non-admin user by copying that user's session cookie into the existing Burp Repeater request, and observe that the response says "Unauthorized".

Change the method from POST to POSTX and observe that the response changes to "missing parameter".

Convert the request to use the GET method by right-clicking and selecting "Change request method".

Change the username parameter to your username and resend the request.

4. Horizontal privilege escalation

 Horizontal privilege escalation arises when a user is able to gain access to resources belonging to another user, instead of their own resources of that type. For example, if an employee should only be able to access their own employment and payroll records, but can in fact also access the records of other employees, then this is horizontal privilege escalation.

Horizontal privilege escalation attacks may use similar types of exploit methods to vertical privilege escalation. For example, a user might ordinarily access their own account page using a URL like the following:

https://insecure-website.com/myaccount?id=123

Now, if an attacker modifies the id parameter value to that of another user, then the attacker might gain access to another user's account page, with associated data and functions. 

> User ID controlled by request parameters.

- For example If a user has log in then the user has a specific API key or something APIs, and the logged in user has link like this https://www.example.com/myaccount?id=user1 

- and if "user1" is changed to "user2" then we can access "user2" API key and retrieve resources.

- https://www.example.com/myaccount?id=user1  --->>> https://www.example.com/myaccount?id=user2

- Changing ID parameters

> User ID controlled by request parameter,with unpredictable user IDs.

- In some applications, the exploitable parameter does not have a predictable value. For example, instead of an incrementing number, an application might use globally unique identifiers (GUIDs) to identify users. Here, an attacker might be unable to guess or predict the identifier for another user. However, the GUIDs belonging to other users might be disclosed elsewhere in the application where users are referenced, such as user messages or reviews. 

- If a blog post has some user name then it must be given a unique user ID with that username link.Find that user id and fuzz with other users to get API keys or resources.
- If "user1" logs in and has user-id while sending mail - "userid?=abcdef" and that user reads blog of "user2", a blog by - user2, by clicking on "user2" name it will give us "user2" userid which will be mostly like "userid?=fghijk".

- Intercept and send requests from user1 and user2's "userid" and get access controls.

> User ID controlled by request parameter with data leakage in redirect 

- In some cases, an application does detect when the user is not permitted to access the resource, and returns a redirect to the login page. However, the response containing the redirect might still include some sensitive data belonging to the targeted user, so the attack is still successful. 

- When user1 logs in and goes to my account there is his API-key.

- Intercept the my account "click" and change the user-id "id?=user1" to "id?=user2" the API key of user-2 will be there.

- Observe that although the response is now redirecting you to the homepage, it has a body containing the API key belonging to carlos.


5. Horizontal to vertical Privilege Escalation

-  Often, a horizontal privilege escalation attack can be turned into a vertical privilege escalation, by compromising a more privileged user. For example, a horizontal escalation might allow an attacker to reset or capture the password belonging to another user. If the attacker targets an administrative user and compromises their account, then they can gain administrative access and so perform vertical privilege escalation.

- For example, an attacker might be able to gain access to another user's account page using the parameter tampering technique already described for horizontal privilege escalation:

> https://insecure-website.com/myaccount?id=456

- If the target user is an application administrator, then the attacker will gain access to an administrative account page. This page might disclose the administrator's password or provide a means of changing it, or might provide direct access to privileged functionality. 


- Use when changing password or email address, if user1 has screen of changing user-mail and password, then fuzz the userid with "admin" or "administrator" you'll get something like if "userid?=administrator" then probably get adminstrator email and password change page or API key for login as Admin.

6. Insecure direct object references








