#!/bin/bash

set -e

function single_yml_config {
    for f in \
        namespaces/*.yml \
        secrets/*.yml \
        services/*.yml \
        daemonsets/*.yml \
        deployments/*.yml \
        statefulsets/*.yml \
    ; do
        echo ---
        cat "$f";
    done
}

single_yml_config | kubectl apply -f -
