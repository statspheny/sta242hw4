#!/bin/bash

# wget log file
LOGFILE=wget.log

URL1=http://eeyore.ucdavis.edu/stat242/data/
URL2=.csv.bz2

START = 1987

for ((i = $1; i<=2007; i++))
do
	FULLURL=$URL1$i$URL2
	echo $FULLURL
	wget $FULLURL -o $LOGFILE
done
