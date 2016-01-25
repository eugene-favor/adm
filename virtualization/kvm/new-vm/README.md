####Create new  VM with vmbuilder (tested on Ubuntu 12.10 - quantal )####

To root

```
sudo su
```

First check if your CPU supports hardware virtualization

```
egrep '(vmx|svm)' --color=always /proc/cpuinfo
```

To install KVM and vmbuilder (a script to create Ubuntu-based virtual machines)


```
apt-get install ubuntu-virt-server python-vm-builder kvm-ipxe
add the user as which we're currently logged in (root) to the group libvirtd
adduser `id -un` libvirtd
adduser `id -un` kvm
```

check if KVM has successfully been installed

```
virsh -c qemu:///system list
```


We need to set up a network bridge on our server so that our virtual machines can be accessed from other hosts as if they were physical systems in the network

```
apt-get install bridge-utils
vim /etc/network/interfaces
```

```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet manual

auto br0
iface br0 inet static
        address 192.168.0.100
        network 192.168.0.0
        netmask 255.255.255.0
        broadcast 192.168.0.255
        gateway 192.168.0.1
        dns-nameservers 8.8.8.8 8.8.4.4
        bridge_ports eth0
        bridge_fd 9
        bridge_hello 2
        bridge_maxage 12
        bridge_stp off
```        
        
Restart the network

```
/etc/init.d/networking restart
```

reboot the system

```
reboot
```

We will use the vmbuilder tool to create VMs. (You can learn more about vmbuilder here.) vmbuilder uses a template to create virtual machines - this template is located in the /etc/vmbuilder/libvirt/ directory. First we create a copy:

```
mkdir -p /var/lib/libvirt/images/vm1/mytemplates/libvirt
cp /etc/vmbuilder/libvirt/* /var/lib/libvirt/images/vm1/mytemplates/libvirt/
```

Now we come to the partitioning of our VM. We create a file called vmbuilder.partition...

```
vim /var/lib/libvirt/images/vm1/vmbuilder.partition
root 8000
swap 4000
---
/var 20000
```

--- line makes that the following partition (/var in this example) is on a separate disk image


boot.sh that will be executed when the VM is booted for the first time

```
vim /var/lib/libvirt/images/vm1/boot.sh
```

```
# This script will run the first time the virtual machine boots
# It is ran as root.

# Expire the user account
passwd -e administrator

# Install openssh-server
apt-get update
apt-get install -qqy --force-yes openssh-server
cd /var/lib/libvirt/images/vm1/
vmbuilder kvm ubuntu --suite=precise --flavour=virtual --arch=amd64 --mirror=http://de.archive.ubuntu.com/ubuntu -o --libvirt=qemu:///system --ip=192.168.0.101 --gw=192.168.0.1 --part=vmbuilder.partition --templates=mytemplates --user=administrator --name=Administrator --pass=howtoforge --addpkg=vim-nox --addpkg=unattended-upgrades --addpkg=acpid --firstboot=/var/lib/libvirt/images/vm1/boot.sh --mem=256 --hostname=vm1 --bridge=br0
```

Before you start a new VM for the first time, you must define it from its xml file

```
virsh define /etc/libvirt/qemu/vm1.xml
virsh start vm1
```

Create second vm

```
mkdir -p /var/lib/libvirt/images/vm2/mytemplates/libvirt
cp /etc/vmbuilder/libvirt/* /var/lib/libvirt/images/vm2/mytemplates/libvirt/

vi /var/lib/libvirt/images/vm2/vmbuilder.partition

vi /var/lib/libvirt/images/vm2/boot.sh

cd /var/lib/libvirt/images/vm2/
vmbuilder kvm ubuntu --suite=precise --flavour=virtual --arch=amd64 --mirror=http://de.archive.ubuntu.com/ubuntu -o --libvirt=qemu:///system --ip=192.168.0.102 --gw=192.168.0.1 --part=vmbuilder.partition --templates=mytemplates --user=administrator --name=Administrator --pass=howtoforge --addpkg=vim-nox --addpkg=unattended-upgrades --addpkg=acpid --firstboot=/var/lib/libvirt/images/vm2/boot.sh --mem=256 --hostname=vm2 --bridge=br0
```
