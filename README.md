
# Oratos Kubernetes Deployment

Oratos is a Greek based name positioned to be part of the Kubernetes community,
like other names such as Istio and Prometheus.

ορατός • (oratós) m (_feminine_ ορατή, _neuter_ ορατό)
	visible, in sight, seen


This repo contains the objects required to run loggregator on kubernetes.

**Note**: This project is currently experimental and may change in breaking
ways.

### Prerequisites

- A k8s cluster up and running.
- `kubectl` installed locally and configured to target your k8s cluster
  (minimum supported version of kubernetes API and CLI: `1.10`).
- `docker` installed locally and configured to target a `dockerd` for running a
  certificate generation container.

### Generate TLS Certs and Keys

To generate TLS certs and keys for your loggregator deployment you need to run
a container. To make this easy you can simply:

```bash
pushd secrets
./generate-tls-certs.sh
popd
```

### Deploying

The following script will apply all the objects to your cluster:

```bash
./deploy.sh
```

### Destroying

The following script will delete all the objects from your cluster:

```bash
./destroy.sh
```

### Configuring the syslog drains for the Syslog Nozzle.

The kubernetes deployment manifest for syslog nozzle can be found under
`optional/deployments/syslog-nozzle.yml`.

Configure the syslog nozzle with the `DRAINS` environment variable.
- In order to forward logs for a specific namespace, specify the `namespace`
property.
- In order to forward all logs of the kubernetes cluster, set `all: true`.

This is an example,

```yaml
- name: DRAINS
  value: |
    [
      {
        "namespace": "kube-system",
        "url": "example.com:1234"
      },
      {
        "all": true,
        "url": "example.com:4567"
      }
    ]
```

Apply the config,
```
kubectl apply -f optional/deployments/syslog-nozzle.yml
```

### Accessing logs via LogCache

1. Target Log Cache via the loadbalancer service:
   ```
   export LOG_CACHE_ADDR="http://$(kubectl get service log-cache-reads -o jsonpath='{$.status.loadBalancer.ingress[0].ip}' -n oratos):8081"
   ```

   or via Minikube:
   ```
   export LOG_CACHE_ADDR="$(minikube service -n oratos log-cache-reads --url)"
   ```
1. [Install the stand alone log-cache-cli][log-cache-cli].

[log-cache-cli]: https://github.com/cloudfoundry/log-cache-cli#stand-alone-cli
