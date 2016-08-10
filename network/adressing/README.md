####Network interface configurationEdit

**Add ip adress**

```
ip addr add 192.168.9.101/32 dev eth0
```

**Remove ip adress**

```
ip addr del 192.168.9.101/32 dev eth0
```

**Show ip adresses**

```
ip addr show
```

**Up interface**

```
ifconfig enp0s8 up
```

OR

```
ifup enp0s8
```
