apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.11.1
  creationTimestamp: "2025-03-31T19:05:20Z"
  generation: 1
  name: projects.cloudplatform.gcp.upbound.io
  ownerReferences:
  - apiVersion: pkg.crossplane.io/v1
    blockOwnerDeletion: true
    controller: true
    kind: ProviderRevision
    name: provider-gcp-f06684e30695
    uid: cd1cf991-e897-4f90-a05d-0f1fdc3d2b8c
  - apiVersion: pkg.crossplane.io/v1
    blockOwnerDeletion: true
    controller: false
    kind: Provider
    name: provider-gcp
    uid: 1584dc85-d19e-4180-8a20-4887b0684066
  resourceVersion: "3096879"
  uid: 8547aaef-43b8-4c3d-8dc6-82af8e012839
spec:
  conversion:
    strategy: None
  group: cloudplatform.gcp.upbound.io
  names:
    categories:
    - crossplane
    - managed
    - gcp
    kind: Project
    listKind: ProjectList
    plural: projects
    singular: project
  scope: Cluster
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: READY
      type: string
    - jsonPath: .status.conditions[?(@.type=='Synced')].status
      name: SYNCED
      type: string
    - jsonPath: .metadata.annotations.crossplane\.io/external-name
      name: EXTERNAL-NAME
      type: string
    - jsonPath: .metadata.creationTimestamp
      name: AGE
      type: date
    name: v1beta1
    schema:
      openAPIV3Schema:
        description: Project is the Schema for the Projects API. Allows management
          of a Google Cloud Platform project.
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation
              of an object. Servers should convert recognized schemas to the latest
              internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this
              object represents. Servers may infer this from the endpoint the client
              submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: ProjectSpec defines the desired state of Project
            properties:
              deletionPolicy:
                default: Delete
                description: DeletionPolicy specifies what will happen to the underlying
                  external when this managed resource is deleted - either "Delete"
                  or "Orphan" the external resource.
                enum:
                - Orphan
                - Delete
                type: string
              forProvider:
                properties:
                  autoCreateNetwork:
                    description: Controls whether the 'default' network exists on
                      the project. Defaults to true, where it is created. Therefore,
                      for quota purposes, you will still need to have 1 network slot
                      available to create the project successfully, even if you set
                      auto_create_network to false.googleapis.com on the project to
                      interact with the GCE API and currently leaves it enabled.
                    type: boolean
                  billingAccount:
                    description: The alphanumeric ID of the billing account this project
                      belongs to.user) on the billing account. See Google Cloud Billing
                      API Access Control for more details.
                    type: string
                  folderId:
                    description: The numeric ID of the folder this project should
                      be created under. Only one of org_id or folder_id may be specified.
                      If the folder_id is specified, then the project is created under
                      the specified folder. Changing this forces the project to be
                      migrated to the newly specified folder.
                    type: string
                  folderIdRef:
                    description: Reference to a Folder in cloudplatform to populate
                      folderId.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: Resolution specifies whether resolution of
                              this reference is required. The default is 'Required',
                              which means the reconcile will fail if the reference
                              cannot be resolved. 'Optional' means this reference
                              will be a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: Resolve specifies when this reference should
                              be resolved. The default is 'IfNotPresent', which will
                              attempt to resolve the reference only when the corresponding
                              field is not present. Use 'Always' to resolve the reference
                              on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  folderIdSelector:
                    description: Selector for a Folder in cloudplatform to populate
                      folderId.
                    properties:
                      matchControllerRef:
                        description: MatchControllerRef ensures an object with the
                          same controller reference as the selecting object is selected.
                        type: boolean
                      matchLabels:
                        additionalProperties:
                          type: string
                        description: MatchLabels ensures an object with matching labels
                          is selected.
                        type: object
                      policy:
                        description: Policies for selection.
                        properties:
                          resolution:
                            default: Required
                            description: Resolution specifies whether resolution of
                              this reference is required. The default is 'Required',
                              which means the reconcile will fail if the reference
                              cannot be resolved. 'Optional' means this reference
                              will be a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: Resolve specifies when this reference should
                              be resolved. The default is 'IfNotPresent', which will
                              attempt to resolve the reference only when the corresponding
                              field is not present. Use 'Always' to resolve the reference
                              on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    type: object
                  labels:
                    additionalProperties:
                      type: string
                    description: A set of key/value label pairs to assign to the project.
                    type: object
                  name:
                    description: The display name of the project.
                    type: string
                  orgId:
                    description: The numeric ID of the organization this project belongs
                      to. Changing this forces a new project to be created.  Only
                      one of org_id or folder_id may be specified. If the org_id is
                      specified then the project is created at the top level. Changing
                      this forces the project to be migrated to the newly specified
                      organization. The numeric ID of the organization this project
                      belongs to.
                    type: string
                  projectId:
                    description: The project ID. Changing this forces a new project
                      to be created.
                    type: string
                  skipDelete:
                    type: boolean
                required:
                - name
                - projectId
                type: object
              providerConfigRef:
                default:
                  name: default
                description: ProviderConfigReference specifies how the provider that
                  will be used to create, observe, update, and delete this managed
                  resource should be configured.
                properties:
                  name:
                    description: Name of the referenced object.
                    type: string
                  policy:
                    description: Policies for referencing.
                    properties:
                      resolution:
                        default: Required
                        description: Resolution specifies whether resolution of this
                          reference is required. The default is 'Required', which
                          means the reconcile will fail if the reference cannot be
                          resolved. 'Optional' means this reference will be a no-op
                          if it cannot be resolved.
                        enum:
                        - Required
                        - Optional
                        type: string
                      resolve:
                        description: Resolve specifies when this reference should
                          be resolved. The default is 'IfNotPresent', which will attempt
                          to resolve the reference only when the corresponding field
                          is not present. Use 'Always' to resolve the reference on
                          every reconcile.
                        enum:
                        - Always
                        - IfNotPresent
                        type: string
                    type: object
                required:
                - name
                type: object
              providerRef:
                description: 'ProviderReference specifies the provider that will be
                  used to create, observe, update, and delete this managed resource.
                  Deprecated: Please use ProviderConfigReference, i.e. `providerConfigRef`'
                properties:
                  name:
                    description: Name of the referenced object.
                    type: string
                  policy:
                    description: Policies for referencing.
                    properties:
                      resolution:
                        default: Required
                        description: Resolution specifies whether resolution of this
                          reference is required. The default is 'Required', which
                          means the reconcile will fail if the reference cannot be
                          resolved. 'Optional' means this reference will be a no-op
                          if it cannot be resolved.
                        enum:
                        - Required
                        - Optional
                        type: string
                      resolve:
                        description: Resolve specifies when this reference should
                          be resolved. The default is 'IfNotPresent', which will attempt
                          to resolve the reference only when the corresponding field
                          is not present. Use 'Always' to resolve the reference on
                          every reconcile.
                        enum:
                        - Always
                        - IfNotPresent
                        type: string
                    type: object
                required:
                - name
                type: object
              publishConnectionDetailsTo:
                description: PublishConnectionDetailsTo specifies the connection secret
                  config which contains a name, metadata and a reference to secret
                  store config to which any connection details for this managed resource
                  should be written. Connection details frequently include the endpoint,
                  username, and password required to connect to the managed resource.
                properties:
                  configRef:
                    default:
                      name: default
                    description: SecretStoreConfigRef specifies which secret store
                      config should be used for this ConnectionSecret.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: Resolution specifies whether resolution of
                              this reference is required. The default is 'Required',
                              which means the reconcile will fail if the reference
                              cannot be resolved. 'Optional' means this reference
                              will be a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: Resolve specifies when this reference should
                              be resolved. The default is 'IfNotPresent', which will
                              attempt to resolve the reference only when the corresponding
                              field is not present. Use 'Always' to resolve the reference
                              on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  metadata:
                    description: Metadata is the metadata for connection secret.
                    properties:
                      annotations:
                        additionalProperties:
                          type: string
                        description: Annotations are the annotations to be added to
                          connection secret. - For Kubernetes secrets, this will be
                          used as "metadata.annotations". - It is up to Secret Store
                          implementation for others store types.
                        type: object
                      labels:
                        additionalProperties:
                          type: string
                        description: Labels are the labels/tags to be added to connection
                          secret. - For Kubernetes secrets, this will be used as "metadata.labels".
                          - It is up to Secret Store implementation for others store
                          types.
                        type: object
                      type:
                        description: Type is the SecretType for the connection secret.
                          - Only valid for Kubernetes Secret Stores.
                        type: string
                    type: object
                  name:
                    description: Name is the name of the connection secret.
                    type: string
                required:
                - name
                type: object
              writeConnectionSecretToRef:
                description: WriteConnectionSecretToReference specifies the namespace
                  and name of a Secret to which any connection details for this managed
                  resource should be written. Connection details frequently include
                  the endpoint, username, and password required to connect to the
                  managed resource. This field is planned to be replaced in a future
                  release in favor of PublishConnectionDetailsTo. Currently, both
                  could be set independently and connection details would be published
                  to both without affecting each other.
                properties:
                  name:
                    description: Name of the secret.
                    type: string
                  namespace:
                    description: Namespace of the secret.
                    type: string
                required:
                - name
                - namespace
                type: object
            required:
            - forProvider
            type: object
          status:
            description: ProjectStatus defines the observed state of Project.
            properties:
              atProvider:
                properties:
                  id:
                    description: an identifier for the resource with format projects/{{project}}
                    type: string
                  number:
                    description: The numeric identifier of the project.
                    type: string
                type: object
              conditions:
                description: Conditions of the resource.
                items:
                  description: A Condition that may apply to a resource.
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the last time this condition
                        transitioned from one status to another.
                      format: date-time
                      type: string
                    message:
                      description: A Message containing details about this condition's
                        last transition from one status to another, if any.
                      type: string
                    reason:
                      description: A Reason for this condition's last transition from
                        one status to another.
                      type: string
                    status:
                      description: Status of this condition; is it currently True,
                        False, or Unknown?
                      type: string
                    type:
                      description: Type of this condition. At most one of each condition
                        type may apply to a resource at any point in time.
                      type: string
                  required:
                  - lastTransitionTime
                  - reason
                  - status
                  - type
                  type: object
                type: array
            type: object
        required:
        - spec
        type: object
    served: true
    storage: true
    subresources:
      status: {}
status:
  acceptedNames:
    categories:
    - crossplane
    - managed
    - gcp
    kind: Project
    listKind: ProjectList
    plural: projects
    singular: project
  conditions:
  - lastTransitionTime: "2025-03-31T19:05:26Z"
    message: no conflicts found
    reason: NoConflicts
    status: "True"
    type: NamesAccepted
  - lastTransitionTime: "2025-03-31T19:05:26Z"
    message: the initial names have been accepted
    reason: InitialNamesAccepted
    status: "True"
    type: Established
  storedVersions:
  - v1beta1