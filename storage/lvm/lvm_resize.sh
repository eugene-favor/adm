#!/bin/bash

lvdisplay /dev/vg/game
#  --- Logical volume ---
#  LV Name                /dev/vg/game
#  VG Name                vg
#  LV UUID                im7qZh-wFuH-3nyv-Q4t3-Mbe1-8zD4-ZNem8x
#  LV Write Access        read/write
#  LV Status              available
#  # open                 1
#  LV Size                465.66 GiB
#  Current LE             119209
#  Segments               1
#  Allocation             inherit
#  Read ahead sectors     auto
#  - currently set to     256
#  Block device           252:3

lvresize -L +500GB /dev/vg/game
#  Extending logical volume game to 965.66 GiB
#  Logical volume game successfully resized
lvdisplay /dev/vg/game
#  --- Logical volume ---
#  LV Name                /dev/vg/game
#  VG Name                vg
#  LV UUID                im7qZh-wFuH-3nyv-Q4t3-Mbe1-8zD4-ZNem8x
#  LV Write Access        read/write
#  LV Status              available
#  # open                 1
#  LV Size                965.66 GiB
#  Current LE             247209
#  Segments               1
#  Allocation             inherit
#  Read ahead sectors     auto
#  - currently set to     256
#  Block device           252:3

df -kh
#Filesystem               Size  Used Avail Use% Mounted on
#/dev/mapper/vg-root       46G  4.3G   40G  10% /
#udev                      32G  8.0K   32G   1% /dev
#tmpfs                     13G  312K   13G   1% /run
#none                     5.0M     0  5.0M   0% /run/lock
#none                      32G     0   32G   0% /run/shm
#/dev/mapper/vg-postgres   19G   67M   19G   1% /var/lib/postgresql
#/dev/sda1                894M   50M  796M   6% /boot
#/dev/mapper/vg-log        19G  192M   18G   2% /var/log
#/dev/mapper/vg-game      459G  198M  435G   1% /opt

df -h
#Filesystem               Size  Used Avail Use% Mounted on
#/dev/mapper/vg-root       46G  4.3G   40G  10% /
#udev                      32G  8.0K   32G   1% /dev
#tmpfs                     13G  312K   13G   1% /run
#none                     5.0M     0  5.0M   0% /run/lock
#none                      32G     0   32G   0% /run/shm
#/dev/mapper/vg-postgres   19G   67M   19G   1% /var/lib/postgresql
#/dev/sda1                894M   50M  796M   6% /boot
#/dev/mapper/vg-log        19G  192M   18G   2% /var/log
#/dev/mapper/vg-game      459G  198M  435G   1% /opt

root@erida:/home/favor# resize2fs -p /dev/mapper/vg-game
#resize2fs 1.42 (29-Nov-2011)
#Filesystem at /dev/mapper/vg-game is mounted on /opt; on-line resizing required
#old_desc_blocks = 30, new_desc_blocks = 61
#Performing an on-line resize of /dev/mapper/vg-game to 253142016 (4k) blocks.
#The filesystem on /dev/mapper/vg-game is now 253142016 blocks long.

root@erida:/home/favor# df -h
#Filesystem               Size  Used Avail Use% Mounted on
#/dev/mapper/vg-root       46G  4.3G   40G  10% /
#udev                      32G  8.0K   32G   1% /dev
#tmpfs                     13G  312K   13G   1% /run
#none                     5.0M     0  5.0M   0% /run/lock
#none                      32G     0   32G   0% /run/shm
#/dev/mapper/vg-postgres   19G   67M   19G   1% /var/lib/postgresql
#/dev/sda1                894M   50M  796M   6% /boot
#/dev/mapper/vg-log        19G  192M   18G   2% /var/log
#/dev/mapper/vg-game      951G  200M  903G   1% /opt



lvdisplay
  --- Logical volume ---
  LV Name                /dev/baculavg/full
  VG Name                baculavg
  LV UUID                mBgaKm-z9kg-usgZ-Zd37-K6OR-SU3S-AkeV32
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                2.83 TiB
  Current LE             741888
  Segments               5
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:3
   
  --- Logical volume ---
  LV Name                /dev/baculavg/incremental
  VG Name                baculavg
  LV UUID                4xabxm-98KC-bbfD-qJfg-pvX1-2ccW-1Lp3MX
  LV Write Access        read/write
  LV Status              available
  # open                 1
  LV Size                1.22 TiB
  Current LE             318966
  Segments               2
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     256
  Block device           252:4

