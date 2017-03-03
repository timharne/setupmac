#!/bin/bash
# script to bootstrap setting up a mac with ansible 

function uninstall {

echo "WARNING : This will remove homebrew and all applications installed through it"
echo "are you sure you want to do that? [y/n]"
read confirmation

if [ $confirmation == "y" ]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
    exit 0
else
  echo "keeping everything intact"
  exit 0
fi

}

if [ $1 == "uninstall" ]; then
    uninstall
fi

echo "==========================================="
echo "Setting up your mac using daemonza/setupmac"
echo "==========================================="

sudo easy_install pip
sudo easy_install ansible

git clone https://github.com/daemonza/setupmac.git /tmp/
if [ ! -d /tmp/setupmac ]; then
    echo "failed to find setupmac."
    echo "git cloned failed"
    exit 1
else
    cd setupmac
    ansible-playbook -i ./hosts playbook.yml --verbose
fi

exit 0