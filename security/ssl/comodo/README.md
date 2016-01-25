* Root CA Certificate - AddTrustExternalCARoot.crt
* Intermediate CA Certificate - COMODORSAAddTrustCA.crt
* Intermediate CA Certificate - COMODORSADomainValidationSecureServerCA.crt
* Your PositiveSSL Certificate - www_example_com.crt (or the subdomain you gave them)

Combine the above crt files into a bundle (the order matters, here):

```
cat www_example_com.crt COMODORSADomainValidationSecureServerCA.crt  COMODORSAAddTrustCA.crt AddTrustExternalCARoot.crt > ssl-bundle.crt
```

Make sure your nginx config points to the right cert file and to the private key you generated earlier:

```
server {
    listen 443;

    ssl on;
    ssl_certificate /etc/nginx/ssl/example_com/ssl-bundle.crt;
    ssl_certificate_key /etc/nginx/ssl/example_com/example_com.key;

    # side note: only use TLS since SSLv2 and SSLv3 have had recent vulnerabilities
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;

    # ...

}
```




