#!/bin/bash
# Author: Madhu Akula
# This program has been created as part of Kubernetes Goat
# Teardown Kubernetes Goat setup

# Removing the superadmin cluster role/binding
k8s kubectl delete clusterrolebindings superadmin
k8s kubectl delete serviceaccount -n kube-system superadmin

# Removing the helm-tiller cluster role/binding
k8s kubectl delete clusterrole all-your-base
k8s kubectl delete clusterrolebindings belong-to-us

# Removing metadata db chart
k8s helm delete metadata-db --no-hooks
# helm2 delete pwnchart --purge

# Remove tiller deployment
k8s kubectl delete deployments -n kube-system tiller-deploy


# Delete the scenarios
k8s kubectl delete -f scenarios/batch-check/job.yaml
k8s kubectl delete -f scenarios/build-code/deployment.yaml
k8s kubectl delete -f scenarios/cache-store/deployment.yaml
k8s kubectl delete -f scenarios/health-check/deployment.yaml
k8s kubectl delete -f scenarios/hunger-check/deployment.yaml
k8s kubectl delete -f scenarios/internal-proxy/deployment.yaml
k8s kubectl delete -f scenarios/kubernetes-goat-home/deployment.yaml
k8s kubectl delete -f scenarios/poor-registry/deployment.yaml
k8s kubectl delete -f scenarios/system-monitor/deployment.yaml
k8s kubectl delete -f scenarios/hidden-in-layers/deployment.yaml


echo "The Kubernetes Goat scenarios has been removed. Ensure clean up what you installed and used, It's better to delete the cluster."
