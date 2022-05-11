#!/bin/bash

echo "helm package"
rm -rf *.tgz
helm package ./dongwook8706/docker/nginx/

list=`ls |grep nginx|grep tgz`
name=`ls |grep nginx|grep tgz |awk -F - '{print $1}'`
version=`ls |grep nginx|grep tgz |awk -F - '{print $2}' |sed 's/.tgz//g'`
echo $list
echo $name
echo $version


echo ""
echo "start - chartmuseum upload"
helm repo update
curl -X DELETE http://localhost:8081/api/charts/$name/$version
curl --data-binary "@$list" http://localhost:8081/api/charts
helm repo update
echo "end - chartmuseum upload"
echo ""


echo ""
echo "start - image ecr upload"
cd ./dongwook8706/build
sh build.sh $version
echo "end - image ecr upload"
echo ""
