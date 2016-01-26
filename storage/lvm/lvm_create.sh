#!/bin/sh

lvcreate -L 61G -n somelvmpartiotion vg
lvcreate -L 41G -n somelvmpartiotion2 vg

mkfs -t ext4 /dev/vg/somelvmpartiotion
mkfs -t ext4 /dev/vg/somelvmpartiotion2

