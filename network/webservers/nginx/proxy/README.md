**Настройка прокси**

```
server {
        listen 11.22.33.44:80;
        server_name somesubdomain.somedomain.com;

        client_max_body_size 101M;

        keepalive_timeout 10s 15;
        keepalive_requests 75;

        location / {
                proxy_pass http://22.33.44.55:80;

                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header User-Agent $http_user_agent;

                proxy_connect_timeout 120;
                proxy_send_timeout    120;
                proxy_read_timeout    180;
        }
}

```

Следует учесть что для того, чтоб сервер-получатель правильно определял IP отправителя - следует считывать заголовок - "X-Real-IP", если используется HTTP протокол для проверки адреса

Если SSL то:

```
server {
         listen 11.22.33.44:443 ssl;
         ssl_certificate /etc/nginx/ssl/somesubdomain.somedomain.com.budle.crt;
         ssl_certificate_key /etc/nginx/ssl/somesubdomain.somedomain.com.com.key;
 
         server_name somesubdomain.somedomain.com;
 
         client_max_body_size 101M;
 
         keepalive_timeout 10s 15;
         keepalive_requests 75;
 
         location / {
                 proxy_pass https://22.33.44.55:443;
 
                 proxy_set_header Host $host;
                 proxy_set_header X-Real-IP $remote_addr;
                 proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                 proxy_set_header User-Agent $http_user_agent;
 
                 proxy_set_header X-Forwarded-Proto $scheme;
 
                 proxy_connect_timeout 120;
                 proxy_send_timeout    120;
                 proxy_read_timeout    180;
         }
 }
 
```