NGINX rate limiting uses the leaky bucket algorithm, which is widely used in telecommunications and packet‑switched computer networks to deal with burstiness when bandwidth is limited. The analogy is with a bucket where water is poured in at the top and leaks from the bottom; if the rate at which water is poured in exceeds the rate at which it leaks, the bucket overflows. 


```

limit_req_zone $binary_remote_addr zone=mylimit:10m rate=10r/s;

server {
    location /login/ {
        limit_req zone=mylimit;

        proxy_pass http://my_upstream;
    }
}

```

zone=mylimit:10m - Defines the shared memory zone used to store the state of each IP address and how often it has accessed a request‑limited URL. Keeping the information in shared memory means it can be shared among the NGINX worker processes. The definition has two parts: the zone name identified by the zone= keyword, and the size following the colon. State information for about 16,000 IP addresses takes 1 megabyte, so our zone can store about 160,000 addresses.

rate - Sets the maximum request rate. In the example, the rate cannot exceed 10 requests per second

```
location /login/ {
    limit_req zone=mylimit burst=20;

    proxy_pass http://my_upstream;
}
```

The burst parameter defines how many requests a client can make in excess of the rate specified by the zone

