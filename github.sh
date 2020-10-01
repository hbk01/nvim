#!/bin/env bash
# build by hbk01 (https://github.com/hbk01)
# This shell script will append ip address for github into hosts file.

# check permission
if [[ $UID -ne 0 ]]; then
    echo "This script need root permission."
    exit -1
fi

echo "" >> /etc/hosts
echo "# for github.com" >> /etc/hosts
echo "199.232.68.133 raw.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 gist.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 user-images.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 cloud.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 camo.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars0.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars1.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars2.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars3.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars4.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars5.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars6.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars7.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars8.githubusercontent.com" >> /etc/hosts
echo "199.232.68.133 avatars9.githubusercontent.com" >> /etc/hosts
echo "" >> /etc/hosts
echo "Success."
