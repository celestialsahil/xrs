---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    controller-gen.kubebuilder.io/version: v0.14.0
  name: subnetworks.compute.gcp.upbound.io
spec:
  group: compute.gcp.upbound.io
  names:
    categories:
    - crossplane
    - managed
    - gcp
    kind: Subnetwork
    listKind: SubnetworkList
    plural: subnetworks
    singular: subnetwork
  scope: Cluster
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=='Synced')].status
      name: SYNCED
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: READY
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
        description: Subnetwork is the Schema for the Subnetworks API. A VPC network
          is a virtual version of the traditional physical networks that exist within
          and between physical data centers.
        properties:
          apiVersion:
            description: |-
              APIVersion defines the versioned schema of this representation of an object.
              Servers should convert recognized schemas to the latest internal value, and
              may reject unrecognized values.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
            type: string
          kind:
            description: |-
              Kind is a string value representing the REST resource this object represents.
              Servers may infer this from the endpoint the client submits requests to.
              Cannot be updated.
              In CamelCase.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
            type: string
          metadata:
            type: object
          spec:
            description: SubnetworkSpec defines the desired state of Subnetwork
            properties:
              deletionPolicy:
                default: Delete
                description: |-
                  DeletionPolicy specifies what will happen to the underlying external
                  when this managed resource is deleted - either "Delete" or "Orphan" the
                  external resource.
                  This field is planned to be deprecated in favor of the ManagementPolicies
                  field in a future release. Currently, both could be set independently and
                  non-default values would be honored if the feature flag is enabled.
                  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
                enum:
                - Orphan
                - Delete
                type: string
              forProvider:
                properties:
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    items:
                      properties:
                        aggregationInterval:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Toggles the aggregation interval for collecting flow logs. Increasing the
                            interval time will reduce the amount of generated flow logs for long
                            lasting connections. Default is an interval of 5 seconds per connection.
                            Default value is INTERVAL_5_SEC.
                            Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                          type: string
                        filterExpr:
                          description: |-
                            Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                            https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                            The default value is 'true', which evaluates to include everything.
                          type: string
                        flowSampling:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            The value of the field must be in [0, 1]. Set the sampling rate of VPC
                            flow logs within the subnetwork where 1.0 means all collected logs are
                            reported and 0.0 means no logs are reported. Default is 0.5 which means
                            half of all collected logs are reported.
                          type: number
                        metadata:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Configures whether metadata fields should be added to the reported VPC
                            flow logs.
                            Default value is INCLUDE_ALL_METADATA.
                            Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                          type: string
                        metadataFields:
                          description: |-
                            List of metadata fields that should be added to reported logs.
                            Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                          items:
                            type: string
                          type: array
                          x-kubernetes-list-type: set
                      type: object
                    type: array
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  networkRef:
                    description: Reference to a Network in compute to populate network.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  networkSelector:
                    description: Selector for a Network in compute to populate network.
                    properties:
                      matchControllerRef:
                        description: |-
                          MatchControllerRef ensures an object with the same controller reference
                          as the selecting object is selected.
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
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    type: object
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  region:
                    description: The GCP region for this subnetwork.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list
                      of zero objects you must use the following syntax:
                      example=[]
                      For more details about this behavior, see this section.
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                required:
                - region
                type: object
              initProvider:
                description: |-
                  THIS IS A BETA FIELD. It will be honored
                  unless the Management Policies feature flag is disabled.
                  InitProvider holds the same fields as ForProvider, with the exception
                  of Identifier and other resource reference fields. The fields that are
                  in InitProvider are merged into ForProvider when the resource is created.
                  The same fields are also added to the terraform ignore_changes hook, to
                  avoid updating them after creation. This is useful for fields that are
                  required on creation, but we do not desire to update them after creation,
                  for example because of an external controller is managing them, like an
                  autoscaler.
                properties:
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    items:
                      properties:
                        aggregationInterval:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Toggles the aggregation interval for collecting flow logs. Increasing the
                            interval time will reduce the amount of generated flow logs for long
                            lasting connections. Default is an interval of 5 seconds per connection.
                            Default value is INTERVAL_5_SEC.
                            Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                          type: string
                        filterExpr:
                          description: |-
                            Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                            https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                            The default value is 'true', which evaluates to include everything.
                          type: string
                        flowSampling:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            The value of the field must be in [0, 1]. Set the sampling rate of VPC
                            flow logs within the subnetwork where 1.0 means all collected logs are
                            reported and 0.0 means no logs are reported. Default is 0.5 which means
                            half of all collected logs are reported.
                          type: number
                        metadata:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Configures whether metadata fields should be added to the reported VPC
                            flow logs.
                            Default value is INCLUDE_ALL_METADATA.
                            Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                          type: string
                        metadataFields:
                          description: |-
                            List of metadata fields that should be added to reported logs.
                            Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                          items:
                            type: string
                          type: array
                          x-kubernetes-list-type: set
                      type: object
                    type: array
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  networkRef:
                    description: Reference to a Network in compute to populate network.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  networkSelector:
                    description: Selector for a Network in compute to populate network.
                    properties:
                      matchControllerRef:
                        description: |-
                          MatchControllerRef ensures an object with the same controller reference
                          as the selecting object is selected.
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
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    type: object
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list
                      of zero objects you must use the following syntax:
                      example=[]
                      For more details about this behavior, see this section.
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                type: object
              managementPolicies:
                default:
                - '*'
                description: |-
                  THIS IS A BETA FIELD. It is on by default but can be opted out
                  through a Crossplane feature flag.
                  ManagementPolicies specify the array of actions Crossplane is allowed to
                  take on the managed and external resources.
                  This field is planned to replace the DeletionPolicy field in a future
                  release. Currently, both could be set independently and non-default
                  values would be honored if the feature flag is enabled. If both are
                  custom, the DeletionPolicy field will be ignored.
                  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
                  and this one: https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md
                items:
                  description: |-
                    A ManagementAction represents an action that the Crossplane controllers
                    can take on an external resource.
                  enum:
                  - Observe
                  - Create
                  - Update
                  - Delete
                  - LateInitialize
                  - '*'
                  type: string
                type: array
              providerConfigRef:
                default:
                  name: default
                description: |-
                  ProviderConfigReference specifies how the provider that will be used to
                  create, observe, update, and delete this managed resource should be
                  configured.
                properties:
                  name:
                    description: Name of the referenced object.
                    type: string
                  policy:
                    description: Policies for referencing.
                    properties:
                      resolution:
                        default: Required
                        description: |-
                          Resolution specifies whether resolution of this reference is required.
                          The default is 'Required', which means the reconcile will fail if the
                          reference cannot be resolved. 'Optional' means this reference will be
                          a no-op if it cannot be resolved.
                        enum:
                        - Required
                        - Optional
                        type: string
                      resolve:
                        description: |-
                          Resolve specifies when this reference should be resolved. The default
                          is 'IfNotPresent', which will attempt to resolve the reference only when
                          the corresponding field is not present. Use 'Always' to resolve the
                          reference on every reconcile.
                        enum:
                        - Always
                        - IfNotPresent
                        type: string
                    type: object
                required:
                - name
                type: object
              publishConnectionDetailsTo:
                description: |-
                  PublishConnectionDetailsTo specifies the connection secret config which
                  contains a name, metadata and a reference to secret store config to
                  which any connection details for this managed resource should be written.
                  Connection details frequently include the endpoint, username,
                  and password required to connect to the managed resource.
                properties:
                  configRef:
                    default:
                      name: default
                    description: |-
                      SecretStoreConfigRef specifies which secret store config should be used
                      for this ConnectionSecret.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
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
                        description: |-
                          Annotations are the annotations to be added to connection secret.
                          - For Kubernetes secrets, this will be used as "metadata.annotations".
                          - It is up to Secret Store implementation for others store types.
                        type: object
                      labels:
                        additionalProperties:
                          type: string
                        description: |-
                          Labels are the labels/tags to be added to connection secret.
                          - For Kubernetes secrets, this will be used as "metadata.labels".
                          - It is up to Secret Store implementation for others store types.
                        type: object
                      type:
                        description: |-
                          Type is the SecretType for the connection secret.
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
                description: |-
                  WriteConnectionSecretToReference specifies the namespace and name of a
                  Secret to which any connection details for this managed resource should
                  be written. Connection details frequently include the endpoint, username,
                  and password required to connect to the managed resource.
                  This field is planned to be replaced in a future release in favor of
                  PublishConnectionDetailsTo. Currently, both could be set independently
                  and connection details would be published to both without affecting
                  each other.
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
            x-kubernetes-validations:
            - message: spec.forProvider.ipCidrRange is a required parameter
              rule: '!(''*'' in self.managementPolicies || ''Create'' in self.managementPolicies
                || ''Update'' in self.managementPolicies) || has(self.forProvider.ipCidrRange)
                || (has(self.initProvider) && has(self.initProvider.ipCidrRange))'
          status:
            description: SubnetworkStatus defines the observed state of Subnetwork.
            properties:
              atProvider:
                properties:
                  creationTimestamp:
                    description: Creation timestamp in RFC3339 text format.
                    type: string
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  fingerprint:
                    type: string
                  gatewayAddress:
                    description: |-
                      The gateway address for default routes to reach destination addresses
                      outside this subnetwork.
                    type: string
                  id:
                    description: an identifier for the resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}}
                    type: string
                  internalIpv6Prefix:
                    description: The internal IPv6 address range that is assigned
                      to this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  ipv6CidrRange:
                    description: The range of internal IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    items:
                      properties:
                        aggregationInterval:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Toggles the aggregation interval for collecting flow logs. Increasing the
                            interval time will reduce the amount of generated flow logs for long
                            lasting connections. Default is an interval of 5 seconds per connection.
                            Default value is INTERVAL_5_SEC.
                            Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                          type: string
                        filterExpr:
                          description: |-
                            Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                            https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                            The default value is 'true', which evaluates to include everything.
                          type: string
                        flowSampling:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            The value of the field must be in [0, 1]. Set the sampling rate of VPC
                            flow logs within the subnetwork where 1.0 means all collected logs are
                            reported and 0.0 means no logs are reported. Default is 0.5 which means
                            half of all collected logs are reported.
                          type: number
                        metadata:
                          description: |-
                            Can only be specified if VPC flow logging for this subnetwork is enabled.
                            Configures whether metadata fields should be added to the reported VPC
                            flow logs.
                            Default value is INCLUDE_ALL_METADATA.
                            Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                          type: string
                        metadataFields:
                          description: |-
                            List of metadata fields that should be added to reported logs.
                            Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                          items:
                            type: string
                          type: array
                          x-kubernetes-list-type: set
                      type: object
                    type: array
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  region:
                    description: The GCP region for this subnetwork.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list
                      of zero objects you must use the following syntax:
                      example=[]
                      For more details about this behavior, see this section.
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  selfLink:
                    description: The URI of the created resource.
                    type: string
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                type: object
              conditions:
                description: Conditions of the resource.
                items:
                  description: A Condition that may apply to a resource.
                  properties:
                    lastTransitionTime:
                      description: |-
                        LastTransitionTime is the last time this condition transitioned from one
                        status to another.
                      format: date-time
                      type: string
                    message:
                      description: |-
                        A Message containing details about this condition's last transition from
                        one status to another, if any.
                      type: string
                    observedGeneration:
                      description: |-
                        ObservedGeneration represents the .metadata.generation that the condition was set based upon.
                        For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
                        with respect to the current state of the instance.
                      format: int64
                      type: integer
                    reason:
                      description: A Reason for this condition's last transition from
                        one status to another.
                      type: string
                    status:
                      description: Status of this condition; is it currently True,
                        False, or Unknown?
                      type: string
                    type:
                      description: |-
                        Type of this condition. At most one of each condition type may apply to
                        a resource at any point in time.
                      type: string
                  required:
                  - lastTransitionTime
                  - reason
                  - status
                  - type
                  type: object
                type: array
                x-kubernetes-list-map-keys:
                - type
                x-kubernetes-list-type: map
              observedGeneration:
                description: |-
                  ObservedGeneration is the latest metadata.generation
                  which resulted in either a ready state, or stalled due to error
                  it can not recover from without human intervention.
                format: int64
                type: integer
            type: object
        required:
        - spec
        type: object
    served: true
    storage: true
    subresources:
      status: {}
  - additionalPrinterColumns:
    - jsonPath: .status.conditions[?(@.type=='Synced')].status
      name: SYNCED
      type: string
    - jsonPath: .status.conditions[?(@.type=='Ready')].status
      name: READY
      type: string
    - jsonPath: .metadata.annotations.crossplane\.io/external-name
      name: EXTERNAL-NAME
      type: string
    - jsonPath: .metadata.creationTimestamp
      name: AGE
      type: date
    name: v1beta2
    schema:
      openAPIV3Schema:
        description: Subnetwork is the Schema for the Subnetworks API. A VPC network
          is a virtual version of the traditional physical networks that exist within
          and between physical data centers.
        properties:
          apiVersion:
            description: |-
              APIVersion defines the versioned schema of this representation of an object.
              Servers should convert recognized schemas to the latest internal value, and
              may reject unrecognized values.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
            type: string
          kind:
            description: |-
              Kind is a string value representing the REST resource this object represents.
              Servers may infer this from the endpoint the client submits requests to.
              Cannot be updated.
              In CamelCase.
              More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
            type: string
          metadata:
            type: object
          spec:
            description: SubnetworkSpec defines the desired state of Subnetwork
            properties:
              deletionPolicy:
                default: Delete
                description: |-
                  DeletionPolicy specifies what will happen to the underlying external
                  when this managed resource is deleted - either "Delete" or "Orphan" the
                  external resource.
                  This field is planned to be deprecated in favor of the ManagementPolicies
                  field in a future release. Currently, both could be set independently and
                  non-default values would be honored if the feature flag is enabled.
                  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
                enum:
                - Orphan
                - Delete
                type: string
              forProvider:
                properties:
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    properties:
                      aggregationInterval:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Toggles the aggregation interval for collecting flow logs. Increasing the
                          interval time will reduce the amount of generated flow logs for long
                          lasting connections. Default is an interval of 5 seconds per connection.
                          Default value is INTERVAL_5_SEC.
                          Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                        type: string
                      filterExpr:
                        description: |-
                          Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                          https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                          The default value is 'true', which evaluates to include everything.
                        type: string
                      flowSampling:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          The value of the field must be in [0, 1]. Set the sampling rate of VPC
                          flow logs within the subnetwork where 1.0 means all collected logs are
                          reported and 0.0 means no logs are reported. Default is 0.5 which means
                          half of all collected logs are reported.
                        type: number
                      metadata:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Configures whether metadata fields should be added to the reported VPC
                          flow logs.
                          Default value is INCLUDE_ALL_METADATA.
                          Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                        type: string
                      metadataFields:
                        description: |-
                          List of metadata fields that should be added to reported logs.
                          Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                        items:
                          type: string
                        type: array
                        x-kubernetes-list-type: set
                    type: object
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  networkRef:
                    description: Reference to a Network in compute to populate network.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  networkSelector:
                    description: Selector for a Network in compute to populate network.
                    properties:
                      matchControllerRef:
                        description: |-
                          MatchControllerRef ensures an object with the same controller reference
                          as the selecting object is selected.
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
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    type: object
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  region:
                    description: The GCP region for this subnetwork.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list of zero objects,
                      set send_secondary_ip_range_if_empty = true
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                required:
                - region
                type: object
              initProvider:
                description: |-
                  THIS IS A BETA FIELD. It will be honored
                  unless the Management Policies feature flag is disabled.
                  InitProvider holds the same fields as ForProvider, with the exception
                  of Identifier and other resource reference fields. The fields that are
                  in InitProvider are merged into ForProvider when the resource is created.
                  The same fields are also added to the terraform ignore_changes hook, to
                  avoid updating them after creation. This is useful for fields that are
                  required on creation, but we do not desire to update them after creation,
                  for example because of an external controller is managing them, like an
                  autoscaler.
                properties:
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    properties:
                      aggregationInterval:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Toggles the aggregation interval for collecting flow logs. Increasing the
                          interval time will reduce the amount of generated flow logs for long
                          lasting connections. Default is an interval of 5 seconds per connection.
                          Default value is INTERVAL_5_SEC.
                          Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                        type: string
                      filterExpr:
                        description: |-
                          Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                          https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                          The default value is 'true', which evaluates to include everything.
                        type: string
                      flowSampling:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          The value of the field must be in [0, 1]. Set the sampling rate of VPC
                          flow logs within the subnetwork where 1.0 means all collected logs are
                          reported and 0.0 means no logs are reported. Default is 0.5 which means
                          half of all collected logs are reported.
                        type: number
                      metadata:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Configures whether metadata fields should be added to the reported VPC
                          flow logs.
                          Default value is INCLUDE_ALL_METADATA.
                          Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                        type: string
                      metadataFields:
                        description: |-
                          List of metadata fields that should be added to reported logs.
                          Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                        items:
                          type: string
                        type: array
                        x-kubernetes-list-type: set
                    type: object
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  networkRef:
                    description: Reference to a Network in compute to populate network.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    required:
                    - name
                    type: object
                  networkSelector:
                    description: Selector for a Network in compute to populate network.
                    properties:
                      matchControllerRef:
                        description: |-
                          MatchControllerRef ensures an object with the same controller reference
                          as the selecting object is selected.
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
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
                            enum:
                            - Always
                            - IfNotPresent
                            type: string
                        type: object
                    type: object
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list of zero objects,
                      set send_secondary_ip_range_if_empty = true
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                type: object
              managementPolicies:
                default:
                - '*'
                description: |-
                  THIS IS A BETA FIELD. It is on by default but can be opted out
                  through a Crossplane feature flag.
                  ManagementPolicies specify the array of actions Crossplane is allowed to
                  take on the managed and external resources.
                  This field is planned to replace the DeletionPolicy field in a future
                  release. Currently, both could be set independently and non-default
                  values would be honored if the feature flag is enabled. If both are
                  custom, the DeletionPolicy field will be ignored.
                  See the design doc for more information: https://github.com/crossplane/crossplane/blob/499895a25d1a1a0ba1604944ef98ac7a1a71f197/design/design-doc-observe-only-resources.md?plain=1#L223
                  and this one: https://github.com/crossplane/crossplane/blob/444267e84783136daa93568b364a5f01228cacbe/design/one-pager-ignore-changes.md
                items:
                  description: |-
                    A ManagementAction represents an action that the Crossplane controllers
                    can take on an external resource.
                  enum:
                  - Observe
                  - Create
                  - Update
                  - Delete
                  - LateInitialize
                  - '*'
                  type: string
                type: array
              providerConfigRef:
                default:
                  name: default
                description: |-
                  ProviderConfigReference specifies how the provider that will be used to
                  create, observe, update, and delete this managed resource should be
                  configured.
                properties:
                  name:
                    description: Name of the referenced object.
                    type: string
                  policy:
                    description: Policies for referencing.
                    properties:
                      resolution:
                        default: Required
                        description: |-
                          Resolution specifies whether resolution of this reference is required.
                          The default is 'Required', which means the reconcile will fail if the
                          reference cannot be resolved. 'Optional' means this reference will be
                          a no-op if it cannot be resolved.
                        enum:
                        - Required
                        - Optional
                        type: string
                      resolve:
                        description: |-
                          Resolve specifies when this reference should be resolved. The default
                          is 'IfNotPresent', which will attempt to resolve the reference only when
                          the corresponding field is not present. Use 'Always' to resolve the
                          reference on every reconcile.
                        enum:
                        - Always
                        - IfNotPresent
                        type: string
                    type: object
                required:
                - name
                type: object
              publishConnectionDetailsTo:
                description: |-
                  PublishConnectionDetailsTo specifies the connection secret config which
                  contains a name, metadata and a reference to secret store config to
                  which any connection details for this managed resource should be written.
                  Connection details frequently include the endpoint, username,
                  and password required to connect to the managed resource.
                properties:
                  configRef:
                    default:
                      name: default
                    description: |-
                      SecretStoreConfigRef specifies which secret store config should be used
                      for this ConnectionSecret.
                    properties:
                      name:
                        description: Name of the referenced object.
                        type: string
                      policy:
                        description: Policies for referencing.
                        properties:
                          resolution:
                            default: Required
                            description: |-
                              Resolution specifies whether resolution of this reference is required.
                              The default is 'Required', which means the reconcile will fail if the
                              reference cannot be resolved. 'Optional' means this reference will be
                              a no-op if it cannot be resolved.
                            enum:
                            - Required
                            - Optional
                            type: string
                          resolve:
                            description: |-
                              Resolve specifies when this reference should be resolved. The default
                              is 'IfNotPresent', which will attempt to resolve the reference only when
                              the corresponding field is not present. Use 'Always' to resolve the
                              reference on every reconcile.
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
                        description: |-
                          Annotations are the annotations to be added to connection secret.
                          - For Kubernetes secrets, this will be used as "metadata.annotations".
                          - It is up to Secret Store implementation for others store types.
                        type: object
                      labels:
                        additionalProperties:
                          type: string
                        description: |-
                          Labels are the labels/tags to be added to connection secret.
                          - For Kubernetes secrets, this will be used as "metadata.labels".
                          - It is up to Secret Store implementation for others store types.
                        type: object
                      type:
                        description: |-
                          Type is the SecretType for the connection secret.
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
                description: |-
                  WriteConnectionSecretToReference specifies the namespace and name of a
                  Secret to which any connection details for this managed resource should
                  be written. Connection details frequently include the endpoint, username,
                  and password required to connect to the managed resource.
                  This field is planned to be replaced in a future release in favor of
                  PublishConnectionDetailsTo. Currently, both could be set independently
                  and connection details would be published to both without affecting
                  each other.
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
            x-kubernetes-validations:
            - message: spec.forProvider.ipCidrRange is a required parameter
              rule: '!(''*'' in self.managementPolicies || ''Create'' in self.managementPolicies
                || ''Update'' in self.managementPolicies) || has(self.forProvider.ipCidrRange)
                || (has(self.initProvider) && has(self.initProvider.ipCidrRange))'
          status:
            description: SubnetworkStatus defines the observed state of Subnetwork.
            properties:
              atProvider:
                properties:
                  creationTimestamp:
                    description: Creation timestamp in RFC3339 text format.
                    type: string
                  description:
                    description: |-
                      An optional description of this resource. Provide this property when
                      you create the resource. This field can be set only at resource
                      creation time.
                    type: string
                  externalIpv6Prefix:
                    description: The range of external IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  fingerprint:
                    type: string
                  gatewayAddress:
                    description: |-
                      The gateway address for default routes to reach destination addresses
                      outside this subnetwork.
                    type: string
                  id:
                    description: an identifier for the resource with format projects/{{project}}/regions/{{region}}/subnetworks/{{name}}
                    type: string
                  internalIpv6Prefix:
                    description: The internal IPv6 address range that is assigned
                      to this subnetwork.
                    type: string
                  ipCidrRange:
                    description: |-
                      The range of internal addresses that are owned by this subnetwork.
                      Provide this property when you create the subnetwork. For example,
                      10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and
                      non-overlapping within a network. Only IPv4 is supported.
                    type: string
                  ipv6AccessType:
                    description: |-
                      The access type of IPv6 address this subnet holds. It's immutable and can only be specified during creation
                      or the first time the subnet is updated into IPV4_IPV6 dual stack. If the ipv6_type is EXTERNAL then this subnet
                      cannot enable direct path.
                      Possible values are: EXTERNAL, INTERNAL.
                    type: string
                  ipv6CidrRange:
                    description: The range of internal IPv6 addresses that are owned
                      by this subnetwork.
                    type: string
                  logConfig:
                    description: |-
                      This field denotes the VPC flow logging options for this subnetwork. If
                      logging is enabled, logs are exported to Cloud Logging. Flow logging
                      isn't supported if the subnet purpose field is set to subnetwork is
                      REGIONAL_MANAGED_PROXY or GLOBAL_MANAGED_PROXY.
                      Structure is documented below.
                    properties:
                      aggregationInterval:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Toggles the aggregation interval for collecting flow logs. Increasing the
                          interval time will reduce the amount of generated flow logs for long
                          lasting connections. Default is an interval of 5 seconds per connection.
                          Default value is INTERVAL_5_SEC.
                          Possible values are: INTERVAL_5_SEC, INTERVAL_30_SEC, INTERVAL_1_MIN, INTERVAL_5_MIN, INTERVAL_10_MIN, INTERVAL_15_MIN.
                        type: string
                      filterExpr:
                        description: |-
                          Export filter used to define which VPC flow logs should be logged, as as CEL expression. See
                          https://cloud.google.com/vpc/docs/flow-logs#filtering for details on how to format this field.
                          The default value is 'true', which evaluates to include everything.
                        type: string
                      flowSampling:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          The value of the field must be in [0, 1]. Set the sampling rate of VPC
                          flow logs within the subnetwork where 1.0 means all collected logs are
                          reported and 0.0 means no logs are reported. Default is 0.5 which means
                          half of all collected logs are reported.
                        type: number
                      metadata:
                        description: |-
                          Can only be specified if VPC flow logging for this subnetwork is enabled.
                          Configures whether metadata fields should be added to the reported VPC
                          flow logs.
                          Default value is INCLUDE_ALL_METADATA.
                          Possible values are: EXCLUDE_ALL_METADATA, INCLUDE_ALL_METADATA, CUSTOM_METADATA.
                        type: string
                      metadataFields:
                        description: |-
                          List of metadata fields that should be added to reported logs.
                          Can only be specified if VPC flow logs for this subnetwork is enabled and "metadata" is set to CUSTOM_METADATA.
                        items:
                          type: string
                        type: array
                        x-kubernetes-list-type: set
                    type: object
                  network:
                    description: |-
                      The network this subnet belongs to.
                      Only networks that are in the distributed mode can have subnetworks.
                    type: string
                  privateIpGoogleAccess:
                    description: |-
                      When enabled, VMs in this subnetwork without external IP addresses can
                      access Google APIs and services by using Private Google Access.
                    type: boolean
                  privateIpv6GoogleAccess:
                    description: The private IPv6 google access type for the VMs in
                      this subnet.
                    type: string
                  project:
                    description: |-
                      The ID of the project in which the resource belongs.
                      If it is not provided, the provider project is used.
                    type: string
                  purpose:
                    description: |-
                      The purpose of the resource. This field can be either PRIVATE_RFC_1918, REGIONAL_MANAGED_PROXY, GLOBAL_MANAGED_PROXY, PRIVATE_SERVICE_CONNECT or PRIVATE_NAT(Beta).
                      A subnet with purpose set to REGIONAL_MANAGED_PROXY is a user-created subnetwork that is reserved for regional Envoy-based load balancers.
                      A subnetwork in a given region with purpose set to GLOBAL_MANAGED_PROXY is a proxy-only subnet and is shared between all the cross-regional Envoy-based load balancers.
                      A subnetwork with purpose set to PRIVATE_SERVICE_CONNECT reserves the subnet for hosting a Private Service Connect published service.
                      A subnetwork with purpose set to PRIVATE_NAT is used as source range for Private NAT gateways.
                      Note that REGIONAL_MANAGED_PROXY is the preferred setting for all regional Envoy load balancers.
                      If unspecified, the purpose defaults to PRIVATE_RFC_1918.
                    type: string
                  region:
                    description: The GCP region for this subnetwork.
                    type: string
                  role:
                    description: |-
                      The role of subnetwork.
                      Currently, this field is only used when purpose is REGIONAL_MANAGED_PROXY.
                      The value can be set to ACTIVE or BACKUP.
                      An ACTIVE subnetwork is one that is currently being used for Envoy-based load balancers in a region.
                      A BACKUP subnetwork is one that is ready to be promoted to ACTIVE or is currently draining.
                      Possible values are: ACTIVE, BACKUP.
                    type: string
                  secondaryIpRange:
                    description: |-
                      An array of configurations for secondary IP ranges for VM instances
                      contained in this subnetwork. The primary IP of such VM must belong
                      to the primary ipCidrRange of the subnetwork. The alias IPs may belong
                      to either primary or secondary ranges.
                      Note: This field uses attr-as-block mode to avoid
                      breaking users during the 0.12 upgrade. To explicitly send a list of zero objects,
                      set send_secondary_ip_range_if_empty = true
                      Structure is documented below.
                    items:
                      properties:
                        ipCidrRange:
                          description: |-
                            The range of IP addresses belonging to this subnetwork secondary
                            range. Provide this property when you create the subnetwork.
                            Ranges must be unique and non-overlapping with all primary and
                            secondary IP ranges within a network. Only IPv4 is supported.
                          type: string
                        rangeName:
                          description: |-
                            The name associated with this subnetwork secondary range, used
                            when adding an alias IP range to a VM instance. The name must
                            be 1-63 characters long, and comply with RFC1035. The name
                            must be unique within the subnetwork.
                          type: string
                      type: object
                    type: array
                  selfLink:
                    description: The URI of the created resource.
                    type: string
                  sendSecondaryIpRangeIfEmpty:
                    description: |-
                      Controls the removal behavior of secondary_ip_range.
                      When false, removing secondary_ip_range from config will not produce a diff as
                      the provider will default to the API's value.
                      When true, the provider will treat removing secondary_ip_range as sending an
                      empty list of secondary IP ranges to the API.
                      Defaults to false.
                    type: boolean
                  stackType:
                    description: |-
                      The stack type for this subnet to identify whether the IPv6 feature is enabled or not.
                      If not specified IPV4_ONLY will be used.
                      Possible values are: IPV4_ONLY, IPV4_IPV6.
                    type: string
                type: object
              conditions:
                description: Conditions of the resource.
                items:
                  description: A Condition that may apply to a resource.
                  properties:
                    lastTransitionTime:
                      description: |-
                        LastTransitionTime is the last time this condition transitioned from one
                        status to another.
                      format: date-time
                      type: string
                    message:
                      description: |-
                        A Message containing details about this condition's last transition from
                        one status to another, if any.
                      type: string
                    observedGeneration:
                      description: |-
                        ObservedGeneration represents the .metadata.generation that the condition was set based upon.
                        For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date
                        with respect to the current state of the instance.
                      format: int64
                      type: integer
                    reason:
                      description: A Reason for this condition's last transition from
                        one status to another.
                      type: string
                    status:
                      description: Status of this condition; is it currently True,
                        False, or Unknown?
                      type: string
                    type:
                      description: |-
                        Type of this condition. At most one of each condition type may apply to
                        a resource at any point in time.
                      type: string
                  required:
                  - lastTransitionTime
                  - reason
                  - status
                  - type
                  type: object
                type: array
                x-kubernetes-list-map-keys:
                - type
                x-kubernetes-list-type: map
              observedGeneration:
                description: |-
                  ObservedGeneration is the latest metadata.generation
                  which resulted in either a ready state, or stalled due to error
                  it can not recover from without human intervention.
                format: int64
                type: integer
            type: object
        required:
        - spec
        type: object
    served: true
    storage: false
    subresources:
      status: {}