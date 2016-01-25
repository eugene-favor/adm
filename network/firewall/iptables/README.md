####Add DNAT roule to input traffic (port redirect)####

```
iptables -t nat -A PREROUTING -p tcp -d 11.22.33.44 --dport 80 -j DNAT --to-destination 11.22.33.44:6080
iptables-save > /etc/iptables.rules
vim /etc/network/interfaces
```

**add it to restore rule after reboot**

```
pre-up iptables-restore < /etc/iptables.rules
```