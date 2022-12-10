#! /bin/bash

command="tar -rvf /temp/backupFile $PWD"
cronJob="* 23 * * 0 $command"

(crontab -l | grep -v -F "$command" ; echo "$cronJob" ) | crontab -

at now +6 months <<ENDMARKER
( crontab -l | grep -v -F "$croncmd )" | crontab -
ENDMARKER
