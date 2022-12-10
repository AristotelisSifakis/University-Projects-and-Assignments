#! /bin/bash

if [ $# -ne 4 ]; then
echo "You need to input a username for the script to run"
echo "You need to input a directory (or file) to be backup up for the script to run"
echo "You need to input a target file or directory for the backup to be stored in for the script to run"
echo "You need to input a time of day for the backup to be created at, for the script to run (for example 3pm or 1am)"
exit 1
fi

username=$1
source=$2
target=$3
atTime=$4
usernameExists=$(grep -c ^"$username" /etc/passwd)

if [ $usernameExists -lt 1 ]; then
echo "The username you have inputed does not exist"
exit 2
fi

if [ ! -d "/home/$username/$source" ] && [ ! -f "/home/$username/$source" ]; then
echo "The second parameter must be a file or a directory"
exit 3
fi

if [ -f $target ]; then
at $atTime <<< "tar -rvf $target /home/$username/$source"
else
if [ -d $target ]; then
at $atTime <<ENDMARKER
tar -cvf backup2 /home/$username/$source
mv backup2 $target
ENDMARKER
else
echo "The third parameter must be a file or a directory"
exit 4
fi
fi

backupResult=$?

if [ $backupResult -ne 0 ]; then
echo "Could not create the backup"
exit 5
fi

echo "The creation of the backup was successful"
