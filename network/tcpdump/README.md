```
tcpdump -i eth0 -ttt -nn -A 'ip proto \tcp and dst 192.168.0.39' -w tcpdumptest -с 100
```
	
-ttt - timestamp интервала от предыдущего пакета 
-w запись в файл
-nn не резолвить хост порт 
-с кол-во строк
-A ACHII для снифа http трафика
ip proto \tcp and dst 192.168.0.39 - фильтрик