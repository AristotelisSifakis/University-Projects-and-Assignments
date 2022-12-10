#! /bin/bash
if [ $# -ne 4 ]; then
echo "Script needs a root folder parameter to run"
echo "Script needs a number paramater for the amount of db folders to run"
echo "Script needs a number parameter for the amount of datafolders to create"
echo "Script need a username parameter to run"
exit 1
fi

ROOTFOLDER=$1
no_of_DBFOLDERS=$2
no_of_DATAFOLDERS=$3
USERNAME=$4

if [ ! -d $ROOTFOLDER ]; then
echo "The rootfolder you have inputed does not exist"
exit 2
fi

usernameExists=$(grep -c ^"$USERNAME" /etc/passwd)

if [ $usernameExists -lt 1 ]; then
echo "The username you have inputed does not exist"
exit 3
fi

for (( i=1; i<=$no_of_DBFOLDERS; i++ ));
do
if [ ! -d $ROOTFOLDER/dbfolder$i ]; then
mkdir $ROOTFOLDER/dbfolder$i
fi
done

for (( i=1; i<=$no_of_DATAFOLDERS; i++ ));
do
if [ ! -d $ROOTFOLDER/datafolder$i ]; then
mkdir $ROOTFOLDER/datafolder$i
chown $USERNAME $ROOTFOLDER/datafolder$i
fi
done

