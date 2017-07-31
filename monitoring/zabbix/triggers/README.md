Template Linux

/etc/passwd has been changed on {HOST.NAME}

```
{{HOST.NAME}:vfs.file.cksum[/etc/passwd].diff(0)}>0
```

Configured max number of opened files is too low on {HOST.NAME}
```
{{HOST.NAME}:kernel.maxfiles.last(0)}<1024
```

Configured max number of processes is too low on {HOST.NAME}
```
{{HOST.NAME}:kernel.maxproc.last(0)}<256
```

Disk I/O is overloaded on {HOST.NAME}
```
{{HOST.NAME}:system.cpu.util[,iowait].last(0)}>80
```

Free disk space is less than 2% on volume /
```
{{HOST.NAME}:vfs.fs.size[/,pfree].last(0)}<2
```

Free disk space is less than 20% on volume /
```
{{HOST.NAME}:vfs.fs.size[/,pfree].last(0)}<20
```

Free inodes is less than 2% on volume /
```
{{HOST.NAME}:vfs.fs.inode[/,pfree].last(0)}<2
```

Free inodes is less than 20% on volume /
```
{{HOST.NAME}:vfs.fs.inode[/,pfree].last(0)}<2
```

 Host information was changed on {HOST.NAME}
 ```
 {{HOST.NAME}:system.uname.diff(0)}>0
 ```
 
 Host name of zabbix_agentd was changed on {HOST.NAME}
 ```
 {{HOST.NAME}:agent.hostname.diff(0)}>0
 ```
 
 Hostname was changed on {HOST.NAME}
 ``` 
 {{HOST.NAME}:system.hostname.diff(0)}>0
 ```

 Lack of available memory on server {HOST.NAME}
 ```
 {{HOST.NAME}:vm.memory.size[available].last(0)}<50M
 ```

Lack of free swap space on {HOST.NAME}

``` 
{{HOST.NAME}:system.swap.size[,pfree].last(0)}<50
```


Processor load is too high on {HOST.NAME}

``` 
{{HOST.NAME}:system.cpu.load[percpu,avg1].last(0)}>2
``` 

Too many processes on {HOST.NAME}

``` 
{{HOST.NAME}:proc.num[].last(0)}>300
``` 

Too many processes running on {HOST.NAME}
```
{{HOST.NAME}:proc.num[,,run].last(0)}>30
```

Version of zabbix_agent(d) was changed on {HOST.NAME}
``` 
{{HOST.NAME}:agent.version.diff(0)}>0
```

Zabbix agent on {HOST.NAME} is unreachable

``` 
{{HOST.NAME}:agent.ping.nodata(90)}=1
```

{HOST.NAME} has just been restarted

``` 
{{HOST.NAME}:system.uptime.change(0)}<0
```

Template Some App


Check listen port
```
{{HOST.NAME}:net.tcp.listen[{$SOMEAPPPORT}].last()}=0
```