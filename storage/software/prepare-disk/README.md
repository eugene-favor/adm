Подготовить партицию для монтирования

```
lsblk
fdisk /dev/sdb 
lsblk
mkfs.ext4 /dev/sdb1
mkdir /persistence
ls -l
vim /etc/fstab
ls -l /dev/disk/by-label/
vim /etc/fstab
ls -l /dev/disk/by-label/
e2label /dev/sdb1 persistence-img
ls -l /dev/disk/by-label/
vim /etc/fstab
```