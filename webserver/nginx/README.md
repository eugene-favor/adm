Установка nginx + веб firewall naxsi (oneliner) :

```

cd /usr/dist/ && wget http://nginx.org/download/nginx-(version).tar.gz && tar -xvf nginx-(version).tar.gz \
&& cd nginx-(version) && \
./configure --prefix=/opt/nginx-(version)-naxsi --add-module=../naxsi-core-0.49/naxsi_src/ \
--with-http_ssl_module --without-mail_pop3_module --without-mail_smtp_module --without-mail_imap_module \
--without-http_scgi_module && make && make install && cd /opt/ \
&& mv /opt/nginx-(version)-naxsi/conf /opt/nginx-(version)-naxsi/conf-default && \
ln -s /opt/nginx-conf/conf /opt/nginx-(version)-naxsi/conf && ln -s /opt/nginx-conf/conf.d
/opt/nginx-(version)-naxsi/conf.d && \
ln -s /opt/nginx-conf/html /opt/nginx-(version)-naxsi/html && ln -s /export/storage0/nginx-logs
/opt/nginx-(version)-naxsi/logs && \
/etc/init.d/nginx stop && unlink nginx && \
ln -s /opt/nginx-(version)-naxsi /opt/nginx && /etc/init.d/nginx start

```