#!/bin/bash

##############################################
# Scrip to migrate Zimbra To Zimbra          #
# @João Pires - joaopires.vilela@gmail.com   #
#                                            #
# to use change the values of the variables  #
##############################################

# Origin and destination host
host1="example.com"
host2="example.com"

# Origin server admin user
admin_user1="userAdmin1@domain"
pass1="adminPassw1"

# Destination server admin user
admin_user2="userAdmin2@doamin"
pass2="adminPassw2"

# File with accounts
dataFile="/tmp/accounts.txt"

# Creating the migration directory
mkdir /opt/zimbra/backup/migration/ || echo "directory already exists"

# Command to start the migration
time for acct in $(cat $dataFile);
do
    curl -k -u $admin_user1:$pass1 "https://$host1:7071/home/$acct/?fmt=tgz" > /opt/zimbra/backup/migration/$acct.tgz
    `curl -v -k -u $admin_user2:$pass2 --data-binary @/opt/zimbra/backup/migration/$acct.tgz "https://$host2:7071/service/home/$acct/?fmt=tgz&resolve=skip"`
    rm -rf /opt/zimbra/backup/migration/$acct.tgz
done

