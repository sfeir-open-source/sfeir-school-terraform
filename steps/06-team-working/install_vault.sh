#!/usr/bin/env bash

echo "install helm"
# installs helm with bash commands for easier command line integration
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 | bash

# updates the repos for Helm repo integration
helm repo update

# add helm repo
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo update

# Wait 20s for tiller
sleep 20

# Install consul
helm install consul-cluster stable/consul

# Install vault
helm install vault-cluster incubator/vault  --set vault.dev=true --set vault.config.storage.consul.address="consul-cluster:8500",vault.config.storage.consul.path="vault" --set service.type="LoadBalancer" --set replicaCount=1
