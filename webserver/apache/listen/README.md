```
Listen 80
Listen 8000

Listen 192.0.2.1:80
Listen 192.0.2.5:8000

Listen [2001:db8::a00:20ff:fea7:ccea]:80

Listen 192.170.2.1:8443 https
```
ote that if the <VirtualHost> is set for an address and port that the server is not listening to, it cannot be accessed.