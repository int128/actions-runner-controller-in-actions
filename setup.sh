#!/bin/bash
set -o pipefail
set -eux

export KUBECONFIG=kubeconfig.yaml
kind create cluster --name arc-cluster
kubectl version

helmfile sync
