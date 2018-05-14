#!/bin/bash

set -e

function single_yml_config {
    for f in \
        statefulsets/*.yml \
        deployments/*.yml \
        daemonsets/*.yml \
        services/*.yml \
        secrets/*.yml \
        configmaps/*.yml \
        namespaces/*.yml \
    ; do
        echo ---
        cat "$f";
    done
}

single_yml_config | kubectl delete --now --cascade=false --ignore-not-found -f -
