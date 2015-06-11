#!/bin/bash
#Assign existing hostname to $hostn
hostn=$(cat /etc/hostname)

ipaddr=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`

if ! grep $hostn /etc/hosts
then
echo $ipaddr $hostn >> /etc/hosts
fi

#Display existing hostname
echo "Existing hostname is $hostn"

newhost=$1

#change hostname in /etc/hosts & /etc/hostname
sed -i "s/$hostn/$newhost/g" /etc/hosts
sed -i "s/$hostn/$newhost/g" /etc/hostname

hostname $newhost

#display new hostname
echo Existing hostname is `hostname`
