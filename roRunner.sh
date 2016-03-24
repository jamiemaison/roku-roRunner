#!/bin/bash

# USAGE : sh roRunner.sh -t <IP_ADDRESS> -s <SLEEP_TIME> -r optional: Replay text file in same folder"

while getopts t:s:r option
do
	case "${option}"
		in
		t) IP=${OPTARG};;
		s) SLEEP=${OPTARG};;
		r) REPLAY=1;;
		\?) echo "Usage: sh roRunner.sh -t <IP_ADDRESS> -s <SLEEP_TIME> -r optional: Replay text file in same folder" >&2 exit 1;;
    	:) echo "Usage: sh roRunner.sh -t <IP_ADDRESS> -s <SLEEP_TIME> -r optional: Replay text file in same folder" >&2 exit 1;;
	esac
done

curlPrefix="http://"$IP":8060/keypress/"

if [ "$REPLAY" == 1 ]
	then
	for line in $(cat *.txt) 
	do
		loop=$((loop+1))

		echo $loop":" $curlPrefix$line
	   	curl -d "" $curlPrefix$line
	   	sleep $SLEEP
	done
elif [ "$IP" != "" ] && [ "$SLEEP" != "" ]
	then
	echo "" > output.txt 2>&1

	for i in `seq 1 8888`;
	do
		randomNumber=$[ RANDOM % 4 ]
		if [ $randomNumber == 0 ]
		then
			echo "Left" >> output.txt
			echo $i":" $curlPrefix"Left"
			curl -d "" $curlPrefix"Left"
		elif [ $randomNumber == 1 ]
		then
			echo "Right" >> output.txt
			echo $i":" $curlPrefix"Right"
			curl -d "" $curlPrefix"Right"
		elif [ $randomNumber == 2 ]
		then
			echo "Up" >> output.txt
			echo $i":" $curlPrefix"Up"
			curl -d "" $curlPrefix"Up"
		elif [ $randomNumber == 3 ]
		then
			echo "Down" >> output.txt
			echo $i":" $curlPrefix"Down"
			curl -d "" $curlPrefix"Down"
		fi
		sleep $SLEEP
	done
fi

exit 0
