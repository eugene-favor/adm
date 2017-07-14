Rewriting URIs in Requests

```
location /users/ {
    rewrite ^/users/(.*)$ /show?user=$1 break;
}
```

```
server {
    ...
    rewrite ^(/download/.*)/media/(.*)\..*$ $1/mp3/$2.mp3 last;
    rewrite ^(/download/.*)/audio/(.*)\..*$ $1/mp3/$2.ra  last;
    return  403;
    ...
}
```

This example configuration distinguishes between two sets of URIs. URIs such as /download/some/media/file are changed to /download/some/mp3/file.mp3. Because of the last flag, the subsequent directives (the second rewrite and the return directive) are skipped but NGINX Plus continues processing the request, which now has a different URI. Similarly, URIs such as /download/some/audio/file are replaced with /download/some/mp3/file.ra. If a URI doesn’t match either rewrite directive, NGINX Plus returns the 403 error code to the client.

There are two parameters that interrupt processing of rewrite directives:

 * last – Stops execution of the rewrite directives in the current server or location context, but NGINX Plus searches for locations that match the rewritten URI, and any rewrite directives in the new location are applied (meaning the URI can be changed again).
 * break – Like the break directive, stops processing of rewrite directives in the current context and cancels the search for locations that match the new URI. The rewrite directives in the new location are not executed.