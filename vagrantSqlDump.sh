#!/bin/bash

# script that logs on to a vagrant vm and dumps a sql database. 
# it's ment to be run from withn a folder inside a vagrant structure.

# initzialize empty/default parameters 
hostname="192.168.33.11"
username=vagrant # to connect to the ssh server running on the vm, not the mysql server
database=database 
outputFile="$( realpath $( dirname $0 ) )/sqlDump"-"$( date "+%y%m%d-%H%M%S" )".sql # /home/user/projects/project/folder/database-160220-133700.sql

# parse the input-parameters with getops and overide the defaults
OPTIND=1 # Reset in case getopts has been used previously in the shell.
while getopts "h:u:d:o:k:" opt; do
    case "$opt" in
    h)  hostname=$OPTARG
        ;;
    u)  username=$OPTARG
        ;;
    d)  database=$OPTARG
        ;;
    o)  outputFile=$OPTARG
        ;;
    k)  keysDirectory=$OPTARG
        ;;
    esac
done
shift $((OPTIND-1))
[ "$1" = "--" ] && shift

# try to find the .vagrant directory if no custom keysDirectory was specified
if [[ -z $keysDirectory ]]; then
	while [[ "/" != "$(pwd)" ]]; do
		if [[ -d .vagrant ]]; then
			cd .vagrant/machines/default/virtualbox
			break
		fi
		cd ..
	done
else
	cd $keysDirectory
fi

echo "Trying to run mysqldump on $hostname as $username (it wont actually add it to the list of know hosts, it's all lies)" 
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i private_key "$username"@"$hostname" \
	"mysqldump -h localhost -u root --password='root' $database " > $outputFile