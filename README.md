# Vagrant-SQL-Dumper
Script that logs on to a vagrant vm and dumps a sql database. 
it is ment to be run from withn a folder inside a vagrant structure.

#Usage
./vagrantSqlDump.sh [-h host][-u username][-d database][-o outputfile][-k keysdirectory]


#Defaults
host     = 192.168.33.11

username = vagrant 
Used to connect to the ssh server running on the vm, not the mysql server

database = database 

outputFile = "$( realpath $( dirname $0 ) )/sqlDump"-"$( date "+%y%m%d-%H%M%S" )".sql 
Should end up looking something like: /home/user/projects/project/folder/sqlDump-160220-133700.sql
if the vagrantSqlDump.sh script is located in /home/user/projects/project/folder/

keysdirectory
This is a subfolder of the hidden folder ".vagrant" that holds the "private_key" file. 
This file is used to connect to the vagrant vm via ssh. 
If not specified by the user, the vagrantSqlDump script will automatically find this folder by looking in parrent 
folders from where the vagrantSqlDump script is located.
