#!/bin/bash

set -e

ls deployments/*.yml | while read line; do
    kubectl delete -f "$line"
done

ls daemonsets/*.yml | while read line; do
    kubectl delete -f "$line"
done

ls services/*.yml | while read line; do
    kubectl delete -f "$line"
done

ls secrets/*.yml | while read line; do
    kubectl delete -f "$line"
done
