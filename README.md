
# Loggregator Kubernetes Deployment

This repo contains the objects required to run loggregator on kubernetes.

### Prerequisites

- A k8s cluster up and running.
- `kubectl` installed locally and configured to target your k8s cluster
- `docker` installed locally and configured target a `dockerd` for running a
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

the following script will delete all the objects from your cluster:

```bash
./destroy.sh
```
