#!/bin/bash
while true
do 
	sleep 2
       	ssh yla@redhat && if [ $? == '0' ]
		          then exit 0
			  fi	
done
