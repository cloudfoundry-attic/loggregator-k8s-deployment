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

b64cmd=base64
if [ "$(uname | tr A-Z a-z)" = "linux" ]; then
  b64cmd="base64 -w 0"
fi

docker run -v "$PWD/loggregator-tls-certs:/output" loggregator/certs
sudo chown -R "$(whoami)" loggregator-tls-certs
echo "$tls_certs_header" > loggregator-tls-certs.yml
ls loggregator-tls-certs |
    while read line
        do echo "  $line: $(cat loggregator-tls-certs/$line | $b64cmd)"
    done >> loggregator-tls-certs.yml
