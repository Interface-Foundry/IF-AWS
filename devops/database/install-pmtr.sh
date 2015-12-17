#!/bin/bash
git clone git@github.com:troydhanson/pmtr.git ~/pmtr
cd ~/pmtr
make
sudo ./install-pmtr.sh
cd -
sudo ln -sf "$PWD"/pmtr.conf /etc/pmtr.conf
echo 'done installing pmtr'
echo 'use tail -f /var/log/syslog to view pmtr daemon logs'
