#! /bin/bash

continueInput=1
let nOne=0
let nTwo=0
let nThree=0
let nFour=0
let nFive=0
let nSix=0

if [ $# -ne 2 ]; then
	echo "there need to be at least two parameters for this to run"
	exit 1
else
	octal=$1
fi

while [ $continueInput -ne 0 ]
do

read -p "Insert a directory name: " directory

#1.1
echo "The files with permissions $octal are: "
command=($(find $directory -type f -perm $octal))
echo $command
nOne=$(($nOne+${#command[@]}))

#1.2
echo ""
echo "The files that have been modified in the last $2 days are: "
command=($(find $directory -type f -mtime -$2))
echo $command
nTwo=$(($nTwo+${#command[@]}))

#1.3
echo ""
echo "The directories that have been accessed in the last $2 days are: "
command=($(find $directory -mindepth 1 -type d -atime -$2))
echo $command
nThree=$(($nThree+${#command[@]}))

#1.4
echo ""
echo "The files in the selected directory which all users can read are: "
ls -l $directory | grep "^.r..r..r"
nFour=$(ls -l $directory | grep "^.r..r..r" | wc -l)

#1.5
echo ""
echo "The subdirectories of the selected directory which all users can edit are: "
ls -l $directory | grep "^d.w..w..w."
nFive=$(ls -l $directory | grep "^d.w..w..w." | wc -l)

read -p "Do you want to repeat this process with another directory? (Type 0 to exit) " continueInput
done
echo "The amount of files found by the first command is $nOne"
echo "The amount of files found by the second command is $nTwo"
echo "The amount of directories found by the third command is $nThree"
echo "The amount of files found by the fourth command is $nFour"
echo "The amount of directories found by the fifth command is $nFive"
