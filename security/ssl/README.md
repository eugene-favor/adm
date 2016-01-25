**generate csr + new key**

openssl req -new -newkey rsa:2048 -nodes -keyout example_com.key -out example_com.csr

**Подготовка сертификата для инсталяции на сервер**

Для lighttpd

```
cat private.key our_signed.crt > our_signed.pem
```

В виртуальных хостах

```
ssl.pemfile = "/etc/lighttpd/certs/current/our_signed.pem"
ssl.ca-file = "/etc/lighttpd/certs/current/sf_bundle.crt"
```

sf_bundle.crt, our_signed.crt Скачивается с authority (например с godaddy)

Для nginx

```
cat our_signed.crt sf_bundle.crt > our_cer_budnle.crt
```


