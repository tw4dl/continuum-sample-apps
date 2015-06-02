#!/bin/bash

if [ ! -d /home/vagrant/continuum-sample-apps/vagrant/continuum-setup.conf ]; then
	echo "Please copy continuum-setup.conf.template to continuum-setup.conf and update the value of first name element."
	exit 1
fi
# update IP address to use eth1's IP address
IP=$(ifconfig eth1 | grep "inet addr:" | cut -d: -f2| cut -d" " -f1)
sed -i.bak -e s/"\"ip\":\".*\""/"\"ip\":\"${IP}\""/g /home/vagrant/continuum-sample-apps/vagrant/continuum-setup.conf
/opt/apcera/continuum/bin/continuum-setup -config=/home/vagrant/continuum-sample-apps/vagrant/continuum-setup.conf 2>&1 | tee /var/log/continuum-install.log

# auto-updated token after the setup
TOKEN=$(cat /CONTINUUM_DNS_TOKEN)
sed -i.bak -e s/"\"token\":\".*\""/"\"token\":\"${TOKEN}\""/g /home/vagrant/continuum-sample-apps/vagrant/continuum-setup.conf