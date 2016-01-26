**migration from one server to another**

on destination server:

```
cd /opt/destination/directory
nc -l -p 1111 | bzip2 -d | tar -xpf -
```

on source server:

cd /opt/source/directory
tar -cvpf - west | pbzip2 -p4 -vc | nc destination.server.com 1111