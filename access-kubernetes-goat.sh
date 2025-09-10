#!/bin/bash
# Author: Madhu Akula
# This program has been created as part of Kubernetes Goat
# Kubernetes Goat Access vulnerable infrastructure

# Checking kubectl setup
k8s kubectl version > /dev/null 2>&1
if [ $? -eq 0 ];
then
    echo "kubectl setup looks good."
else
    echo "Please check kubectl setup."
    exit;
fi

echo 'Creating port forward for all the Kubernetes Goat resources to locally. We will be using 1230 to 1236 ports locally!'

# Exposing Sensitive keys in code bases Scenario
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=build-code" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1230:3000 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing DIND (docker-in-docker) exploitation Scenario
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=health-check" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1231:80 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing SSRF in K8S world Scenario
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=internal-proxy" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1232:3000 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing Container escape to access host system Scenario
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=system-monitor" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1233:8080 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing Kubernetes Goat Home
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=kubernetes-goat-home" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1234:80 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing Attacking private registry Scenario
export POD_NAME=$(k8s kubectl get pods --namespace default -l "app=poor-registry" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl port-forward $POD_NAME --address 0.0.0.0 1235:5000 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

# Exposing DoS resources Scenario
export POD_NAME=$(k8s kubectl get pods --namespace big-monolith -l "app=hunger-check" -o jsonpath="{.items[0].metadata.name}")
while true; do
    POD_STATUS=$(k8s kubectl get pod "$POD_NAME" --namespace big-monolith -o jsonpath='{.status.phase}')
    if [ "$POD_STATUS" == "Running" ]; then
        READY=$(k8s kubectl get pod "$POD_NAME" --namespace big-monolith -o jsonpath='{.status.containerStatuses[*].ready}')
        if [[ "$READY" == *"true"* ]]; then
            k8s kubectl --namespace big-monolith port-forward $POD_NAME --address 0.0.0.0 1236:8080 > /dev/null 2>&1 &
            break
        else
            echo "Pod $POD_NAME is running but not all containers are ready."
        fi
    else
        echo "Pod $POD_NAME is not in Running state. Current state: $POD_STATUS"
    fi
    echo "Retrying $POD_NAME in 10s"
    sleep 10
done

echo "Visit http://127.0.0.1:1234 to get started with your Kubernetes Goat hacking!"
