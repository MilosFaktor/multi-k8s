#!/usr/bin/env bash

set -e

docker buildx build \
  --cache-from type=gha,scope=client \
  --cache-to type=gha,mode=max,scope=client \
  -t milosfaktor/multi-client:$GITHUB_SHA \
  -t milosfaktor/multi-client:latest \
  --push \
  ./client

docker buildx build \
  --cache-from type=gha,scope=server \
  --cache-to type=gha,mode=max,scope=server \
  -t milosfaktor/multi-server:$GITHUB_SHA \
  -t milosfaktor/multi-server:latest \
  --push \
  ./server

docker buildx build \
  --cache-from type=gha,scope=worker \
  --cache-to type=gha,mode=max,scope=worker \
  -t milosfaktor/multi-worker:$GITHUB_SHA \
  -t milosfaktor/multi-worker:latest \
  --push \
  ./worker