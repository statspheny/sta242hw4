#!/bin/sh

DATAFILE=data/*.csv

cut -d, -f17 $DATAFILE | egrep '(LAX|OAK|SFO|SMF)' | sort | uniq -c

wc -l testcases/testcase.csv
