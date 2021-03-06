#!/bin/bash
set -e

# Install MongoDB
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D68FA50FEA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org
/bin/sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
systemctl enable mongod

