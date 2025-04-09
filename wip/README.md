# CRD Resource Deployemnet

## Pre-requisites:
1. GKE Cluster to run the crossplane controlplane.
2. Service account key with access to deploy resource in Google cloud platform
3. Helm and Kubectl package to install the crossplane controlplane.

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

#### providerconfig: Authentication to GCP enviornment using service account json key as kubernetes secret/ impersonating service account
##### Imporsenation
```
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default
spec:
  credentials:
    impersonateServiceAccount:
      name: my-service-account@my-project.iam.gserviceaccount.com    //replace with service account
    source: ImpersonateServiceAccount
  projectID: my-project         //replace with project id
```
##### Service account key as kuberenets secret
```
kubectl create secret generic gcp-creds-01 --from-file=creds=gcp-credentials.json -n upbound-system
```
```
apiVersion: gcp.upbound.io/v1beta1
kind: ProviderConfig
metadata:
  name: default-gcp
spec:
  projectID: "my-project"  //replace with project id
  credentials:
    source: Secret
    secretRef:
      namespace: upbound-system
      name: gcp-json-creds
      key: creds
```

The above provider supports, multple managed resource creations, please follow the link to explore the supported managed resources.


kubectl get crd subnetworks.compute.gcp.upbound.io -o yaml

kg crd project.cloudplatform.gcp.upbound.io -o yml

kg crd folder.cloudplatform.gcp.upbound.io -o yml

kg crd orgpolicy.gcp.upbound.io -o yaml


