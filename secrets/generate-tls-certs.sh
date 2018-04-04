#!/bin/bash

set -e

tls_certs_header='
apiVersion: v1
kind: Secret
metadata:
  name: loggregator-tls-certs
  namespace: kube-system
type: Opaque
data:
'

docker run -v "$PWD/loggregator-tls-certs:/output" loggregator/certs
sudo chown -R "$(whoami):$(whoami)" loggregator-tls-certs
echo "$tls_certs_header" > loggregator-tls-certs.yml
ls loggregator-tls-certs |
    while read line
        do echo "  $line: $(cat loggregator-tls-certs/$line | base64 -w 0)"
    done >> loggregator-tls-certs.yml
