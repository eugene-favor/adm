####Recreate instance and change machine type####

**Delete instance first and keep all disks**

```
gcloud compute instances delete test-vpn-instance --keep-disks all
```

Options:

--keep-disks all - to keep all boot and attached disk

```
gcloud compute instances create test-vpn-instance --machine-type n1-standard-2 --disk name=test-vpn boot=yes --disk
name=test-vpn-additional --zone europe-west1-d --scopes=compute-rw --network=payment-ninja-root-subnet --address
test-vpn-instance-ip
```

Options:

--machine-type n1-standard-2 - set machine type (you can select from https://cloud.google.com/compute/docs/machine-types )
--disk name=test-vpn boot=yes - set BOOT disk from existant (you can choose disk only from zone where instance is created)
--disk name=test-vpn-additional - attach additional disk (you can choose disk only from zone where instance is created)
--zone europe-west1-d - select zone
--scopes=compute-rw - allow to execute "gcloud" commands from inside of instance
--network=payment-ninja-root-subnet - set network from existance gcloud compute networks list
--address test-vpn-instance-ip - attach external static IP from your list gcloud compute addresses list