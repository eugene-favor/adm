**Redirect to antoher ip requests to specific port**

```
socat -d TCP-LISTEN:80,reuseaddr,fork TCP:11.22.33.44:80,forever &
```

**and bind it to ip adress**

```
socat -d TCP-LISTEN:12345,bind=11.22.33.44,reuseaddr,fork TCP:22.33.44.55:5432,forever &
```