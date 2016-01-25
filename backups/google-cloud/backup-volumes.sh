#!/bin/bash

# GCUTILPATH
GCUTILPATH=/usr/bin/

# Project name
project=someproject-id

# Mount point of data disk
persistencemnt=/persistence

# Name of data disk
persistencedisk="someinstance-persistence-disk"

#List of persistent disks
list="someinstance-root-disk someinstance-persistence-disk"

disklist=$list

# Rotation, how many days  to keep
days=7

zone=europe-west1-b

for i in $disklist
do
        echo "Starting snapshot for $i disk $project"

        sync
        createsnap="${GCUTILPATH}gcloud compute disks snapshot $i --snapshot-name "$i""-`date +%y%m%d`" --project="$project" --zone $zone"

        if [ "$i" == "$persistencedisk" ];then

                echo "Freeze $persistencemnt for $i disk"

                fsfreeze -f $persistencemnt
                eval $createsnap
                fsfreeze -u $persistencemnt
        else
                echo "Not freeze for $i disk"

                eval $createsnap
        fi

        echo "Snapshot for $i finished"
done

#Rotation
for i in $disklist
do
        snapshot="$i""-`date +%y%m%d -d "$days day ago"`"
        exist="`${GCUTILPATH}gcloud compute snapshots list --project $project | grep $snapshot`"

        if [ -z "$exist" ];then
                echo "Warning, snapshot $snapshot was not found"
        else
                echo "Starting rotation for $i"

                ${GCUTILPATH}gcloud compute snapshots delete $snapshot --project="$project" --quiet

                echo "Rotation for $i finished"
        fi
done

echo "All done."