#!/bin/bash

ROLE=$1
ADMIN_USER=root
MASTER_HOST=192.168.50.31
SLAVE_USER=slave
SLAVE_PASS=slavepw
FLOATING_IP=192.168.50.100
FLOATING_DEV=eth1


[ -z $ROLE ] && exit

# Disable iptables
echo "Stopping firewall..."
service iptables stop 2>&1 >> /dev/null

# Yum Repo
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

echo "Verifying vim is installed..."
rpm -q --quiet vim || yum install -y vim

echo "Verifying ruby is installed..."
rpm -q --quiet ruby || yum install -y ruby

echo "Verifying rubygems is installed..."
rpm -q --quiet rubygems || yum install -y rubygems

cd /vagrant
gem install bundler
bundle install --verbose

echo "Verifying redis is installed..."
rpm -q --quiet redis || yum --enablerepo=remi,remi-test install -y redis

# Setup one system to be a slave to start with
if [ "${ROLE}" == "slave" ]; then
  echo "Checking Replication Status... (TODO)"
elif [ "${ROLE}" == "master" ]; then
  echo "Checking for Floating VIP..."
  /sbin/ip addr list | grep "${FLOATING_IP}" 2>&1 > /dev/null
  if [  $? == 1 ]; then
    echo "Installing Floating VIP ${FLOATING_IP}..."
    /sbin/ip addr add ${FLOATING_IP} dev ${FLOATING_DEV}
  fi
fi
