#!/bin/bash

set -e

function single_yml_config {
    for f in \
        namespaces/*.yml \
        configmaps/*.yml \
        secrets/*.yml \
        services/*.yml \
        daemonsets/*.yml \
        deployments/*.yml \
        statefulsets/*.yml \
        roles/*.yml \
    ; do
        echo ---
        cat "$f";
    done
}

function patch_objects {
    # this is done in order to force rolling of components on update
    # for instance if a configmap or secret value is changed and needs to be
    # reloaded from disk or env
    patch='{"spec": {"template": {"metadata": {"labels": {"randomversion": "'$RANDOM'"}}}}}'
    kubectl patch statefulset log-cache --namespace oratos --patch "$patch"
    kubectl patch deployment log-cache-nozzle --namespace oratos --patch "$patch"
    kubectl patch deployment syslog-nozzle --namespace oratos --patch "$patch"
    kubectl patch deployment log-cache-scheduler --namespace oratos --patch "$patch"
    kubectl patch deployment loggregator-emitter --namespace oratos --patch "$patch"
    kubectl patch deployment loggregator-rlp --namespace oratos --patch "$patch"
    kubectl patch deployment loggregator-router --namespace oratos --patch "$patch"
    kubectl patch daemonset loggregator-fluentd --namespace oratos --patch "$patch"
}

single_yml_config | kubectl apply -f -
patch_objects
