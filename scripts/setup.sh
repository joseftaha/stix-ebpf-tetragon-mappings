# setup kind honeycluster
kind create cluster --image kindest/node:v1.25.0

# install nginx
kubectl label node kind-control-plane kubernetes.io/os=linux --overwrite
kubectl label node kind-control-plane ingress-ready=true
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/kind/deploy.yaml

# install tetragon
helm repo add cilium https://helm.cilium.io
helm repo update
helm install tetragon ${EXTRA_HELM_FLAGS[@]} cilium/tetragon -n kube-system
kubectl rollout status -n kube-system ds/tetragon -w

# kubectl create -f https://raw.githubusercontent.com/cilium/cilium/v1.15.3/examples/minikube/http-sw-app.yaml
# kubectl port-forward --namespace ingress-nginx service/ingress-nginx-controller 8080:80