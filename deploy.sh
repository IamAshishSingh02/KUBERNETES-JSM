#!/bin/bash
set -e

NAME="kubernetes-jsm-api"
USERNAME="songoku02"
IMAGE="$USERNAME/$NAME:latest"

echo "✅ Building Docker image..."
docker build -t $IMAGE .

echo "✅ Pushing image to Docker Hub..."
docker push $IMAGE

echo "✅ Applying Kubernetes manifests..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "✅ Waiting for Deployment to become READY..."
kubectl rollout status deployment/$NAME

echo "✅ Waiting for Pods to be Running..."
kubectl wait --for=condition=Ready pod -l app=$NAME --timeout=120s

echo "✅ Listing Pods..."
kubectl get pods -o wide

echo "✅ Listing Services..."
kubectl get services

echo "✅ Fetching your service..."
kubectl get service $NAME

echo "✅ Opening service in browser..."
minikube service $NAME
