#!/bin/bash

set -e

ls secrets/*.yml | while read line; do
    kubectl apply -f "$line"
done

ls services/*.yml | while read line; do
    kubectl apply -f "$line"
done

ls daemonsets/*.yml | while read line; do
    kubectl apply -f "$line"
done

ls deployments/*.yml | while read line; do
    kubectl apply -f "$line"
done
