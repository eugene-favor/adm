A regular expression is preceded with the tilde (~) for case-sensitive matching, or the tilde-asterisk (~*) for case-insensitive matching. 

```
location ~ \.html? {
    ...
}
```

```
error_page 404 /404.html;

location /old/path.html {
    error_page 404 =301 http:/example.com/new/path.html;
}

```

The following configuration is an example of passing a request to the back end when a file is not found. Because there is no status code specified after the equals sign in the error_page directive, the response to the client has the status code returned by the proxied server (not necessarily 404).

```
server {
    ...
    location /images/ {
        # Set the root directory to search for the file
        root /data/www;

        # Disable logging of errors related to file existence
        open_file_cache_errors off;

        # Make an internal redirect if the file is not found
        error_page 404 = /fetch$uri;
    }

    location /fetch/ {
        proxy_pass http://backend/;
    }
}
```

The open_file_cache_errors directive prevents writing an error message if a file is not found. This is not necessary here since missing files are correctly handled.