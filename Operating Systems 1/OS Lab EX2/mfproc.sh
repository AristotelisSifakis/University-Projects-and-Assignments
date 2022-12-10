#! /bin/bash

usernameSet=false
stateSet=false

validUsername=false
validProcessState=()

while getopts :u:s: opt; do
case ${opt} in
u)
if [ ! -z "$OPTARG" ]; then
username=$OPTARG
usernameSet=true
fi
;;
s)
if [ ! -z "$OPTARG" ]; then
state=$OPTARG
stateSet=true
fi
;;
esac
done

if [ "$usernameSet" = true ]; then
userExists=`cat /etc/passwd | grep $username | wc -l`
if [ $userExists -ne 0 ]; then
validUsername=true
tasks=($(ps --no-headers -u $username | tr -s ' ' | cut -d ' ' -f 2))
else
tasks=($(ps --no-headers -eaf))
fi
else
tasks=($(ps --no-headers -eaf))
validUsername=true
fi

if [ ${#tasks[@]} -ne 0 ]; then
echo "Name PID PPID UID GID State"
fi
for i in "${tasks[@]}"
do
if [ -d "/proc/$i" ]; then
processState=$(sed -n '3 p' < /proc/$i/status | tr -s ' ' | cut -d $'\t' -f 2 | cut -d ' ' -f 1)
processName=$(sed -n '1 p' < /proc/$i/status | tr -s ' ' | cut -d $'\t' -f 2)
processPPID=$(sed -n '7 p' < /proc/$i/status | tr -s ' ' | cut -d $'\t' -f 2)
processUID=$(sed -n '9 p' < /proc/$i/status | tr -s ' ' | cut -d $'\t' -f 2)
processGID=$(sed -n '10 p' < /proc/$i/status | tr -s ' ' | cut -d $'\t' -f 2)

if [ "$stateSet" = true ]; then
if [ "$state" == "$processState" ]; then
echo "$processName $i $processPPID $processUID $processGID $processState"
validProcessState+=($i)
fi
else
echo "$processName $i $processPPID $processUID $processGID $processState"
fi
fi
done

if [ "$validUsername" = false ]; then
exit 1
fi

if [ "$stateSet" = true ] && [ ${#validProcessState[@]} -eq 0 ]; then
exit 2
fi

exit 0
