# CRD Resource Deployemnet

## Pre-requisites:
1. GKE Cluster to run the crossplane controlplane.
2. Service account key with access to deploy resource in Google cloud platform
3. Helm package to install the crossplane controlplane.

### Installation:
```
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane crossplane-stable/crossplane --namespace upbound-system --create-namespace
```

#### provider: Based on the resource compatability, different providers are required to deploy the resources.
```
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-gcp-compute
spec:
  package: xpkg.upbound.io/upbound/provider-gcp-compute:v1
```
The above provider supports, multple managed resource creations, please follow the link to explore the supported managed resources.


kubectl get crd subnetworks.compute.gcp.upbound.io -o yaml

kg crd project.cloudplatform.gcp.upbound.io -o yml

kg crd folder.cloudplatform.gcp.upbound.io -o yml

kg crd orgpolicy.gcp.upbound.io -o yaml


