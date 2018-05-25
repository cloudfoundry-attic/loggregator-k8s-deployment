
# Loggregator Kubernetes Deployment

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

### Accessing logs via LogCache

1. Target the log-cache-reads service:  
      
   ```
   export LOG_CACHE_ADDR="$(kubectl get service log-cache-reads -o jsonpath='{$.status.loadBalancer.ingress[0].ip}')"
   ```
1. [Install the stand alone log-cache-cli][log-cache-cli].

[log-cache-cli]: https://github.com/cloudfoundry/log-cache-cli#stand-alone-cli
