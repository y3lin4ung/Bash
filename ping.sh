#!/bin/bash
i=1
while [ $i -le 10000000 ]
do
	ping -c 1 google.com
	if [ $? == '0' ]
	then
		clear
		figlet Internet!
		exit 0
	fi
	clear
	figlet NoInternet!
	echo "$i Second!						by  y3l!n4ung"
	sleep 1
	i=$((i + 1))
done
