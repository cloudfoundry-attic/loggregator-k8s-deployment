#!/bin/bash
function shell_exit() {
    errcode=$?
    if [ $errcode -eq 0 ]; then
        echo "Status check is fine"
    else
        echo "ERROR: some status check has failed"
    fi
    exit $errcode
}

trap shell_exit SIGHUP SIGINT SIGTERM 0

set -e

# TODO: better way
sleep 5

echo "Confirm confimap has been created correctly"
kubectl get configmap -n oratos
kubectl get configmap -n oratos | grep fluent-bit-config 1>/dev/null 2>&1

echo "Confirm daemonset is created correctly"
kubectl get daemonset -n oratos
kubectl get daemonset -n oratos | grep fluent-bit 1>/dev/null 2>&1

# TODO: better way
echo "Confirm one fluent-bit running pod for each k8s node"
[ $(kubectl get nodes | grep -v NAME | wc -l) -eq $(kubectl get pods -n oratos | grep fluent-bit | grep Running | wc -l) ]
