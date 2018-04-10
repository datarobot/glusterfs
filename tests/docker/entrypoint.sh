#!/bin/bash
# This entrypoint runs at the start of the gluster container

rpcbind
# rpc.statd

mknod -m 0660 /dev/loop0 b 7 0
mknod -m 0660 /dev/loop1 b 7 1
mknod -m 0660 /dev/loop2 b 7 2
mknod -m 0660 /dev/loop3 b 7 3

sed -i "s/obtain_device_list_from_udev = 1/obtain_device_list_from_udev = 0/" /etc/lvm/lvm.conf
sed -i "s/udev_sync = 1/udev_sync = 0/" /etc/lvm/lvm.conf
sed -i "s/udev_rules = 1/udev_rules = 0/" /etc/lvm/lvm.conf

exec $*
