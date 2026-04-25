#!/usr/bin/env bash

set -e

docker build -t milosfaktor/multi-client:$GITHUB_SHA -t milosfaktor/multi-client:latest ./client
docker build -t milosfaktor/multi-server:$GITHUB_SHA -t milosfaktor/multi-server:latest ./server
docker build -t milosfaktor/multi-worker:$GITHUB_SHA -t milosfaktor/multi-worker:latest ./worker

docker push milosfaktor/multi-client:$GITHUB_SHA
docker push milosfaktor/multi-client:latest
docker push milosfaktor/multi-server:$GITHUB_SHA
docker push milosfaktor/multi-server:latest
docker push milosfaktor/multi-worker:$GITHUB_SHA
docker push milosfaktor/multi-worker:latest

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=milosfaktor/multi-server:$GITHUB_SHA
kubectl set image deployments/client-deployment client=milosfaktor/multi-client:$GITHUB_SHA
kubectl set image deployments/worker-deployment worker=milosfaktor/multi-worker:$GITHUB_SHA

kubectl rollout status deployment/client-deployment
kubectl rollout status deployment/server-deployment
kubectl rollout status deployment/worker-deployment