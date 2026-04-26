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


====== google cloud console shell ======
0. set up gcloud
gcloud config set project <project_ID>
gcloud config set project k8s-project-494218

gcloud config set compute/region europe-west10

gcloud container clusters get-credentials <cluster_name>
gcloud container clusters get-credentials multi-k8s


1. create secret
kubectl create secret generic pgpassword --from-literal PGPASSWORD=password123


2. install helm and install ingress
# https://helm.sh/docs/intro/install/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-4
chmod 700 get_helm.sh
./get_helm.sh

# https://kubernetes.github.io/ingress-nginx/deploy/
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace



