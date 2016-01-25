####Get system info####

**get common info**

```
lshw
```

get ram

```
free -m
dmidecode --type memory | less
```

OR

```
dmidecode --type 17
```

Некотрорые понятия о RAM


DIMM - форм-фактор (стандарт, задающий габаритные размеры технического изделия) модулей памяти DRAM. Данный форм-фактор пришёл на смену форм-фактору SIMM. 
форм-фактор DIMM предназначен для памяти типа SDRAM.
первые в форм-факторе DIMM появились модули с памятью типа FPM, а затем и EDO. 
Модуль SO-DIMM предназначен для использования в ноутбуках или в качестве расширения памяти на плате, поэтому отличается уменьшенным габаритом.
В дальнейшем в модули DIMM стали упаковывать память типа DDR, DDR2, DDR3 и DDR4, отличающуюся повышенным быстродействием.
DDR SDRAM (от англ. Double Data Rate Synchronous Dynamic Random Access Memory — синхронная динамическая память с произвольным доступом и удвоенной скоростью передачи данных)
DDR2 SDRAM (англ. double-data-rate two synchronous dynamic random access memory — синхронная динамическая память с произвольным доступом и удвоенной скоростью передачи данных, второе поколение) 
DDR3 SDRAM (англ. double-data-rate three synchronous dynamic random access memory — синхронная динамическая память с произвольным доступом и удвоенной скоростью передачи данных, третье поколение)

Существуют следующие типы DIMM:

72-pin SO-DIMM (не совместима с 72-pin SIMM) — используется для FPM DRAM и EDO DRAM
100-pin DIMM — используется для принтеров SDRAM
144-pin SO-DIMM — используется для SDR SDRAM (иногда также для EDO RAM) в портативных компьютерах
168-pin DIMM — используется для SDR SDRAM (реже для FPM/EDO DRAM в рабочих станциях/серверах)
172-pin MicroDIMM — используется для DDR SDRAM
184-pin DIMM — используется для DDR SDRAM
200-pin SO-DIMM — используется для DDR SDRAM и DDR2 SDRAM
214-pin MicroDIMM — используется для DDR2 SDRAM
204-pin SO-DIMM — используется для DDR3 SDRAM
240-pin DIMM — используется для DDR2 SDRAM, DDR3 SDRAM и FB-DIMM DRAM
256-pin SO-DIMM — используется для DDR4 SDRAM
284-pin DIMM — используется для DDR4 SDRAM

get cpu

Get phisical cpu count + model:

```
lshw | grep -i cpu
```

Get total cpu core count:

```
grep -c processor /proc/cpuinfo
```
get motherboadr info

```
lshw | less
```
```
*-core
       description: Motherboard
       product: Z77A-G45 (MS-7752)
       vendor: MSI
```

get hdd

Get phisical device (hdd or hardware raid)

```
lshw -class disk
```

Get block divice (/dev/sda, ..)

```
fdisk -l
```

And

```
smartctl -i /dev/sda
```


For me not work for hardware raid