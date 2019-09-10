#!/bin/bash#input file
INPUT=$1while true; 
do
 file=$(zipinfo $INPUT | grep "\--" | awk '{print $9}')
 echo "file :" $file
 pass=$(echo $file | awk -F"." '{print $1}')
 echo "pass: " $pass
 unzip  -P $pass $INPUT
 INPUT=$file
done
