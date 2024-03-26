#!/bin/sh

# install to sda
BDEV=vda

# x-wrt.img.gz in disk part sda2
DDEV=vda1

# static ip
#network=172.21.170.245,255.255.240.0,172.21.175.253,8.8.8.8

# static ip swap eth0 eth1
#network="117.18.13.159,255.255.255.0,117.18.13.1,8.8.8.8,initscript=dWNpIHNldCBuZXR3b3JrLmxhbi5pZm5hbWU9ZXRoMQp1Y2kgc2V0IG5ldHdvcmsud2FuLmlmbmFtZT1ldGgwCnVjaSBjb21taXQgbmV0d29yawo="

# dhcp ip
network=dhcp

vmroot=/tmp/block
mkdir -p $vmroot
mount /dev/${DDEV} $vmroot || exit 0
cp $vmroot/x-wrt.img.gz /tmp/x-wrt.img.gz && {
	cd /
	umount $vmroot
	sync
	(zcat /tmp/x-wrt.img.gz;
	 echo open=443,network=$network;
	) >/dev/$BDEV && reboot
}