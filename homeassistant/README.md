<!-- markdownlint-disable-next-line -->
# Helm chart for Homeassistant on UHM

Running Homeassistant on Kubernetes in parallel with United Manufacturing Hub

# Installation
helm install my-release https://runeroven.github.io/helmcharts/homeassistant

### Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- local path provisioner
- traefik

# Info
Since volumes is handled by the local path provisioner, new volumes will be auto-created in the cluster and is persistent by default using PVC in the chart.
The persistence enable section however is creating a new persistent storage type and patches the volumes to retain.
This will force the volumes to persist even after uninstallation of the release. This way your local data will never get lost.
If you install the release again using the same names a pre-job will find the old volumes and auto-mount them.