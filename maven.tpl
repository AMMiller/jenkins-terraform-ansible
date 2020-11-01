#!/bin/bash
sudo su
apt update && \
apt install -y git default-jdk maven && \
apt install -y nfs-common && \
cd /tmp && \
git clone https://github.com/AMMiller/boxfuse.git && \
mvn package -f /tmp/boxfuse/pom.xml

# Mount EFS
mkdir -p /mnt/efs
cd /mnt/efs
efs_id="${efs_id}"
mount -t nfs4 -o  nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $efs_id:/ /mnt/efs
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab
