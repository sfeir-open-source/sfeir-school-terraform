#!/usr/bin/env bash

echo "install helm"
# installs helm with bash commands for easier command line integration
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
# add a service account within a namespace to segregate tiller
kubectl --namespace kube-system create sa tiller
# create a cluster role binding for tiller
kubectl create clusterrolebinding tiller \
    --clusterrole cluster-admin \
    --serviceaccount=kube-system:tiller

echo "initialize helm"
# initialized helm within the tiller service account
helm init --service-account tiller
# updates the repos for Helm repo integration
helm repo update

# add incubator
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
helm repo update

# Wait 20s for tiller
sleep 20

# Install consul
helm install --name consul-cluster stable/consul

# Install vault
helm install incubator/vault --name vault-cluster --set vault.dev=true --set vault.config.storage.consul.address="consul-cluster:8500",vault.config.storage.consul.path="vault" --set service.type="LoadBalancer" --set replicaCount=1
