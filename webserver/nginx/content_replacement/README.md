```
location / {
    sub_filter      /blog/ /blog-staging/;
    sub_filter_once off;
}


location / {
    sub_filter     'href="http://127.0.0.1:8080/'    'href="https://$host/';
    sub_filter     'img src="http://127.0.0.1:8080/' 'img src="https://$host/';
    sub_filter_once on;
}
```