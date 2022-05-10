#!/bin/bash


echo "ecr login"
aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin 388272709061.dkr.ecr.ap-northeast-2.amazonaws.com

echo "docker tag"
docker tag nginx-test:$1 388272709061.dkr.ecr.ap-northeast-2.amazonaws.com/ekstest1:$1
docker push 388272709061.dkr.ecr.ap-northeast-2.amazonaws.com/ekstest1:$1

