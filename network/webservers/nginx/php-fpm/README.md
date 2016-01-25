**Пример настройки виртуального хоста с php-fpm для Symfony2**

```
server {
        listen 80;

        index index.php index.html index.htm;
        
        server_name somedomain.com;

        root /var/www/somedomain.com/web;

        # Logging
        error_log /var/log/nginx/somedomain.com-error.log;
        access_log /var/log/nginx/somedomain.com-access.log;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri /app.php;
                # Uncomment to enable naxsi on this location
                # include /etc/nginx/naxsi.rules
        }

        # Only for nginx-naxsi used with nginx-naxsi-ui : process denied requests
        #location /RequestDenied {
        #       proxy_pass http://127.0.0.1:8080;    
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        location ~ ^/(app|app_dev|config)\.php(/|$) {
                fastcgi_split_path_info ^(.+\.php)(/.*)$;
        #       # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
        #
        #       # With php5-cgi alone:
        #       fastcgi_pass 127.0.0.1:9000;
        #       # With php5-fpm:
                fastcgi_pass unix:/var/run/php5-fpm.sock;
                fastcgi_index index.php;
                include fastcgi_params;

            fastcgi_param   PATH_INFO         $fastcgi_path_info;
            fastcgi_param   SCRIPT_FILENAME   $document_root$fastcgi_script_name;
        }
```

**fastcgi_split_path_info regex;** -

Defines a regular expression that captures a value for the $fastcgi_path_info variable. The regular expression should have two captures: the first becomes a value of the $fastcgi_script_name variable, the second becomes a value of the $fastcgi_path_info variable. For example, with these settings

```
location ~ ^(.+\.php)(.*)$ {
    fastcgi_split_path_info       ^(.+\.php)(.*)$;
    fastcgi_param SCRIPT_FILENAME /path/to/php$fastcgi_script_name;
    fastcgi_param PATH_INFO       $fastcgi_path_info;
```

and the “/show.php/article/0001” request, the SCRIPT_FILENAME parameter will be equal to “/path/to/php/show.php”, and the PATH_INFO parameter will be equal to “/article/0001”.
in case of error:

```
*10277 upstream sent too big header while reading response header from upstream, client: 127.0.0.1  ........
```

```
fastcgi_buffers 16 16k;
fastcgi_buffer_size 32k;
```

