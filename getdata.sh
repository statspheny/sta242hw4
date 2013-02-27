#!/bin/sh

# Copied this script from
# http://alvinalexander.com/linux-unix/wget-command-shell-script-example-download-url

# wget log file
LOGFILE=wget.log

URL=http://eeyore.ucdavis.edu/stat242/data/1987.csv.bz2

wget $URL -o $LOGFILE