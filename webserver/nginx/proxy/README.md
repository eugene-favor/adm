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