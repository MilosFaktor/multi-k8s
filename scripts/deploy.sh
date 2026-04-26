#!/usr/bin/env bash

set -e

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=milosfaktor/multi-server:$GITHUB_SHA
kubectl set image deployments/client-deployment client=milosfaktor/multi-client:$GITHUB_SHA
kubectl set image deployments/worker-deployment worker=milosfaktor/multi-worker:$GITHUB_SHA

kubectl rollout status deployment/client-deployment
kubectl rollout status deployment/server-deployment
kubectl rollout status deployment/worker-deployment