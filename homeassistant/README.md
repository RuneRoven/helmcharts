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

# Smarter devices manager
https://gitlab.com/arm-research/smarter/smarter-device-manager
Uses a pod to handle devices and how many can access and use the devices simultaneously. 
This way there is no need to exclusively lock a device to a specific pod. 
Each pod can request the use of a device in the resources.
containers:
    - name: myPod
      image: myImage
      resources:
        limits:
          cpu: 500m
          memory: 512Mi
          smarter-devices/ttyUSB1: '1'
        requests:
          cpu: 100m
          memory: 256Mi
          smarter-devices/ttyUSB1: '1'
The device will be found as ttyUSB1 in the pod.

# Zigbee2mqtt
https://www.zigbee2mqtt.io/
Requires some initial data to start up, like working usb-device and mqtt server.
Use the configmap in the values for initial setup. This will load the configmap into 
the disk on every restart of the pod and overwrite any changes made in the UI.
To enable changing of settings in the UI first load the configmap to get the pod running,
then set zigbee2mqttuseConfigMap: false. This will disable the loading of the configMap and 
let you use the UI for settings

# Zwavejs2mqtt
https://zwave-js.github.io/zwave-js-ui/#/
Connect and administrate your z-wave devices direct from the UI or use websockets to configure from Homeassistant
