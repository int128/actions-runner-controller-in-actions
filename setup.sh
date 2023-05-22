#!/bin/bash
set -o pipefail
set -eux

export KUBECONFIG=kubeconfig.yaml
kind create cluster --name arc-cluster
kubectl version

helmfile sync
helm list -A
kubectl get pods -n arc-systems
kubectl rollout status deployment -n arc-systems arc-gha-runner-scale-set-controller

sleep 300
