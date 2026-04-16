========== local =============
kind create cluster

========= !!! secret must be created before applying !!! ============
========== k8s ===============
# from complex root
kubectl apply -f k8s/
kubectl get deployments

========== storage ============
kubectl get storageclass
kubectl describe storageclass
kubectl get pv
kubectl get pvc

======== creating secret =========
# creatig manually using imperative command
kubectl create secret generic <secret_name> --from-literal key=value
kubectl create secret generic pgpassword --from-literal PGPASSWORD=password123
kubectl get secrets

======== ingress controller local testing ============
https://kubernetes.github.io/ingress-nginx/deploy/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.15.1/deploy/static/provider/cloud/deploy.yaml

kubectl get pods --namespace=ingress-nginx

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s


kubectl port-forward -n ingress-nginx service/ingress-nginx-controller 8080:80

=========== restart if needed ===========
kubectl rollout restart deployment server-deployment
kubectl rollout restart deployment worker-deployment
kubectl rollout restart deployment postgres-deployment