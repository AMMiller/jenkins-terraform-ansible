#!/bin/bash
sudo su
apt update
apt install -y nfs-common

apt install -y tomcat8
rm -rf /var/lib/tomcat8/webapps/ROOT/*

# Mount EFS
mkdir -p /mnt/efs
cd /mnt/efs
efs_id="${efs_id}"
mount -t nfs4 -o  nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $efs_id:/ /mnt/efs
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab
