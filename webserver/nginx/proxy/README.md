proxy from 80 to 8080 server

```
server {
    listen 8080;
    root /data/up1;

    location / {
    }
}

server {
    location / {
        proxy_pass http://localhost:8080/;
    }

    location ~ \.(gif|jpg|png)$ {
        root /data/images;
    }
}
```

A regular expression should be preceded with ~


Setting Up FastCGI Proxying

```
server {
    location / {
        fastcgi_pass  localhost:9000;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param QUERY_STRING    $query_string;
    }

    location ~ \.(gif|jpg|png)$ {
        root /data/images;
    }
}
```
proxied server operating on localhost:9000 through the FastCGI protocol


SCRIPT_FILENAME parameter is used for determining the script name
QUERY_STRING parameter is used to pass request parameters


By default, NGINX redefines two header fields in proxied requests, “Host” and “Connection”, and eliminates the header fields whose values are empty strings. “Host” is set to the $proxy_host variable, and “Connection” is set to close.

To change these setting, as well as modify other header fields, use the proxy_set_header directive. 

```
location /some/path/ {
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_pass http://localhost:8000;
}


```

To prevent a header field from being passed to the proxied server, set it to an empty string as follows:

```
location /some/path/ {
    proxy_set_header Accept-Encoding "";
    proxy_pass http://localhost:8000;
}
```

Configuring Buffers

By default NGINX buffers responses from proxied servers. A response is stored in the internal buffers and is not sent to the client until the whole response is received. Buffering helps to optimize performance with slow clients, which can waste proxied server time if the response is passed from NGINX to the client synchronously. However, when buffering is enabled NGINX allows the proxied server to process responses quickly, while NGINX stores the responses for as much time as the clients need to download them.

proxy_buffering by default it is set to on and buffering is enabled.


number of buffers is increased and the size of the buffer for the first portion of the response is made smaller than the default.
```
location /some/path/ {
    proxy_buffers 16 4k;
    proxy_buffer_size 2k;
    proxy_pass http://localhost:8000;
}
```

Specify the proxy_bind directive and the IP address of the necessary network interface:

```
location /app1/ {
    proxy_bind 127.0.0.1;
    proxy_pass http://example.com/app1/;
}

location /app2/ {
    proxy_bind 127.0.0.2;
    proxy_pass http://example.com/app2/;
}

#The IP address can be also specified with a variable. For example, the $server_addr variable passes the IP address of the network interface that accepted the request

location /app3/ {
    proxy_bind $server_addr;
    proxy_pass http://example.com/app3/;
}
```

