**Проверить статус Raid-a**

```
cat /proc/mdstat

Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10] 
md1 : active raid1 sda2[0]
      961135480 blocks super 1.2 [2/1] [U_]
      bitmap: 7/8 pages [28KB], 65536KB chunk

sudo mdadm --detail /dev/md1
/dev/md1:
        Version : 1.2
  Creation Time : Fri Oct 28 13:46:45 2011
     Raid Level : raid1
     Array Size : 961135480 (916.61 GiB 984.20 GB)
  Used Dev Size : 961135480 (916.61 GiB 984.20 GB)
   Raid Devices : 2
  Total Devices : 1
    Persistence : Superblock is persistent

  Intent Bitmap : Internal

    Update Time : Wed Dec  4 11:21:22 2013
          State : active, degraded 
 Active Devices : 1
Working Devices : 1
 Failed Devices : 0
  Spare Devices : 0

           Name : ubuntu:1
           UUID : 454db5e0:b3a89ec8:e206fd4e:44d66f26
         Events : 19261453

    Number   Major   Minor   RaidDevice State
       0       8        2        0      active sync   /dev/sda2
       1       0        0        1      removed
```

Видно, что один диск выпал.

Посмотреть можно какой диск был в массиве можно так:

```
sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL
[sudo] password for vasja.pupkin: 
NAME    FSTYPE              SIZE MOUNTPOINT LABEL
sda                       931.5G            
├─sda1  swap               14.9G [SWAP]     
└─sda2  linux_raid_member 916.6G            ubuntu:1
  └─md1 ext4              916.6G /          
sdb                       931.5G            
├─sdb1                     14.9G            
└─sdb2  linux_raid_member 916.6G            ubuntu:1
  └─md1 ext4              916.6G /          
sr0                        1024M         
```

Проверяем выпавший диск (результат в приложенном файле sbd_check):

```
smartctl -a /dev/sdb
```

Меняем, если все плохо, добавляем в массив назад:

```
mdadm /dev/md1 --re-add /dev/sdb2
```


