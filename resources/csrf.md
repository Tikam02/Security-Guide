### CSRF
*****

CSRF (Cross site request forgery) is the vulnerability that tricks the user to submit the malicious request if there is no implementation of the Anti-CSRF tokens in the forms or site. When implemented your website https://vulnerables.com will include a random generated number or token to every page which is impossible to guess by the attacker so https://vulnerables.com will include it when they serve it to you. It differs each time they serve any page to anybody so attacker won’t be able to generate a valid request because of the wrong token.

### What is CSRF attack?
CSRF is an attack that tricks the victim to send a malicious request this request can change the victim information like Email, Username, Passwords and etc…
