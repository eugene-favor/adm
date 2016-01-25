
####Миграция образов диска####

1. Делаем dump настроек образа

```
virsh dumpxml somevm > somevm.xml
```

```
<disk type='file' device='disk'>
  <driver name='qemu' type='raw'/>
  <source file='/home/images/somevm.img'>
  <target dev='vda' bus='virtio'/>
</disk>
```
или

```
<disk type='block' device='disk'>
  <driver name='qemu' type='raw' cache='writeback'/>
  <source dev='/dev/vg/somelvmpartion'/>
  <target dev='vdb' bus='virtio'/>
  <alias name='virtio-disk1'/>
  <address type='pci' domain='0x0000' bus='0x00' slot='0x07' function='0x0'/>
</disk>
```

2. Сохраняем XML на новой машинке, меняем путь к образу

```
source file=...

source dev=...
```

Добавляем virtlib


```
virsh define somevm.xml
```

3. Копируем образ (как зависит от того какой image - lmv партиция, файл..)

```
scp /home/images/munin.img root@newserver:/home/images/somevm.img
```

или

```
dd if=/dev/vg/somelvmpartion | ssh root@newserver dd of=/dev/vg/newsomelvmpartition
```

Посмотреть прогресс dd можно на новой хост машине:

```
kill -USR1  13564
```

13564 - proc id dd процесса 

Результат будет на source хосте


4.Запускаем VM на новом хосте (hypervisor)

```
virsh start somevm
```