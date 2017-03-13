```
tcpdump -i eth0 -ttt -nn -A 'ip proto \tcp and dst 192.168.0.39' -w tcpdumptest -с 100
```
	
-ttt - timestamp интервала от предыдущего пакета 
-w запись в файл
-nn не резолвить хост порт 
-с кол-во строк
-A ACHII для снифа http трафика
ip proto \tcp and dst 192.168.0.39 - фильтрик

Примеры:

arp запросы

```
tcpdump -vvv  -l -n -i eth0 -e arp

tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 65535 bytes
14:18:22.849463 24:c6:fd:23:a3:80 > ff:ff:ff:ff:ff:ff, ethertype ARP (0x0806), length 42: Ethernet (len 6), IPv4 (len 4), Request who-has 192.168.22.72 tell 192.168.22.69, length 28
14:18:22.849890 50:e5:19:3e:c8:d6 > 24:c6:fd:23:a3:80, ethertype ARP (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Reply 192.168.22.72 is-at 50:e5:19:3e:c8:d6, length 46
14:18:27.430827 50:e5:19:3e:c8:d6 > 24:c6:fd:23:a3:80, ethertype ARP (0x0806), length 60: Ethernet (len 6), IPv4 (len 4), Request who-has 192.168.22.69 (24:c6:fd:23:a3:80) tell 192.168.22.72, length 46
14:18:27.430869 24:c6:fd:23:a3:80 > 50:e5:19:3e:c8:d6, ethertype ARP (0x0806), length 42: Ethernet (len 6), IPv4 (len 4), Reply 192.168.22.69 is-at 24:c6:fd:23:a3:80, length 28
```

dhcp запросы

```
tcpdump -vvv  -l -n -i eth0 -e port 67 or port 68

```