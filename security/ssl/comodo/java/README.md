Generate key and request

```
keytool -genkey -alias server_name -keyalg RSA -keysize 2048 -keystore server_name_keystore.jks

keytool -certreq -keyalg RSA -alias server_name -file server_name_certreq.csr -keystore server_name_keystore.jks
```

Import cert in keystore

```
 keytool -import -trustcacerts -alias server_name -keystore server_name_keystore.jks -file server_name.p7b
 
```

Check keystore

```
keytool -list -keystore server_name_keystore.jks -v
```

