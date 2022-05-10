#!/bin/bash 

echo "build.sh start"
echo $1 
echo "ekstest - nginx v$1" > index.html
echo "build.sh end"

echo "dockerfile start"
docker build -t nginx-test:$1 .
docker images |grep nginx-test
echo "dockerfile end"



echo "ecr_upload start"
sh ecr_upload.sh $1
echo "ecr_upload end"
