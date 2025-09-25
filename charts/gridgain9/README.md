# gridgain9

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 9.1.1](https://img.shields.io/badge/AppVersion-9.1.1-informational?style=flat-square)

A Helm chart to deploy GridGain 9

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| GridGain Systems, Inc. All Rights Reserved |  | <https://www.gridgain.com/> |

## Source Code

* <https://github.com/gridgain/helm-charts/tree/main/charts>

## TL;DR

```console
helm repo add gridgain https://gridgain.github.io/helm-charts/
helm repo update 
helm install my-release gridgain/gridgain9
```

## Prerequisites

- Kubernetes 1.26+
- Helm 3.11.3+
- PV provisioner support in the persistence configuration

## Limitations and Considerations

When running GridGain 9 in a Kubernetes environment, the node configuration becomes **read-only** and cannot be modified by using the `gridgain9 node config update` CLI command. This is by design, as node configuration is managed via Kubernetes resources.

> **Warning**
>
> While it is technically possible to make the node configuration writable by using an init container that copies the mounted configuration from one location to another (and pointing GridGain 9 to this new location), we **strongly discourage** this approach. It is not native to the Kubernetes model, and any changes made to the configuration will be lost during pod restarts or re-deployments.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) for GridGain  pods assignment |
| annotations | object | `{}` | Annotations for GridGain resources |
| args | list | `[]` | Override default container args (useful when using custom images) |
| command | list | `[]` | Override default container command (useful when using custom images) |
| commonAnnotations | object | `{}` | Add annotations to all the deployed resources |
| configMaps | object | Check default values.yaml to view default config | GridGain  main configuration to be injected as ConfigMap.  |
| configMapsFromFile | object | `{"gridgain-config":{"filename":"gridgain-config.conf","path":"/opt/gridgain/etc/gridgain-config.conf"},"logging-conf":{"filename":"logging.conf","path":"/opt/gridgain/etc/gridgain.java.util.logging.properties"}}` | GridGain  main configuration to be injected as ConfigMap from files (files/configmaps) |
| containerPorts | list | check default container ports in values.yaml | GridGain container ports |
| containerSecurityContext | object | `{}` | [Container Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for GridGain container |
| customLabels | object | `{}` | Add labels to all the deployed resources. May be templated |
| existingConfigmap | object | `{}` | Existing configmap with GridGain configuration to be mounted to StatefulSet |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release (evaluated as a template) |
| extraEnvVars | list | `[]` | Array with extra environment variables to add to GridGain  nodes |
| extraEnvVarsCM | string | `""` | Name of existing ConfigMap containing extra env vars for GridGain  nodes |
| extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for GridGain  nodes |
| extraPodSpec | object | `{}` | Optionally specify extra PodSpec for the GridGain  pod(s) |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the GridGain  container(s) |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the GridGain  pod(s) |
| fullnameOverride | string | `""` | String to fully override common.names.fullname template |
| gridgainWorkDir | string | `"/persistence"` | GridGain [persistent storage directory](https://www.gridgain.com/docs/latest/developers-guide/persistence/native-persistence#configuring-persistent-storage-directory) |
| image.pullPolicy | string | `"IfNotPresent"` | Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' |
| image.registry | string | `"docker.io"` | GridGain image registry |
| image.repository | string | `"gridgain/gridgain9"` | GridGain image repository |
| image.tag | string | `nil` | if not set appVersion field from Chart.yaml is used |
| initContainers | list | `[]` | Add additional init containers to the GridGain  pod(s) |
| labels | object | `{}` | Map of labels |
| license | object | `{}` | [GridGain license](https://www.gridgain.com/docs/latest/installation-guide/licenses) to be created or mounted as a secret. Needed to use GridGain Enterprise Edition (EE) or Ultimate Edition (UE) |
| lifecycleHooks | object | `{}` | Lifecycle hooks for GridGain  container |
| livenessProbe | object | Check defaults below | Configures (liveness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| livenessProbe.enabled | bool | `true` | Enables livenessProbe on GridGain container |
| livenessProbe.failureThreshold | int | `3` | Failure threshold for livenessProbe |
| livenessProbe.httpGet | object | `{"path":"/management/v1/node/state","port":10300}` | Path and port for probe |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `30` | Period seconds for livenessProbe |
| livenessProbe.successThreshold | int | `1` | Success threshold for livenessProbe |
| livenessProbe.timeoutSeconds | int | `10` | Timeout seconds for livenessProbe |
| nameOverride | string | `""` | String to partially override common.names.fullname template (will maintain the release name) |
| networkPolicy | object | `{}` | [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) |
| nodeSelector | object | `{}` | [Node labels](https://kubernetes.io/docs/user-guide/node-selection/) for GridGain  pods assignment |
| persistence | object | By default only one volume will be created. Check default values.yaml to view more details | GridGain  persistence configuration |
| persistence.persistentVolumeClaimRetentionPolicy.enabled | bool | `false` | Enable Persistent volume retention policy |
| persistence.persistentVolumeClaimRetentionPolicy.whenDeleted | string | `"Retain"` | Volume retention behavior that applies when the StatefulSet is deleted |
| persistence.persistentVolumeClaimRetentionPolicy.whenScaled | string | `"Retain"` | Volume retention behavior when the replica count of the StatefulSet is reduced |
| persistence.volumePermissions.containerSecurityContext | object | disabled | Init container [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) Note: the chown of the data folder is done to containerSecurityContext.runAsUser and not the below volumePermissions.containerSecurityContext.runAsUser |
| persistence.volumePermissions.containerSecurityContext.runAsGroup | int | `0` | Group ID for the init container |
| persistence.volumePermissions.containerSecurityContext.runAsNonRoot | bool | `false` | runAsNonRoot for the init container |
| persistence.volumePermissions.containerSecurityContext.runAsUser | int | `0` | User ID for the init container |
| persistence.volumePermissions.containerSecurityContext.seLinuxOptions | object | `{}` | Set SELinux options in container |
| persistence.volumePermissions.containerSecurityContext.seccompProfile | object | `{"type":"RuntimeDefault"}` | seccompProfile.type for the init container |
| persistence.volumePermissions.enabled | bool | `false` | Enable init container that changes the owner and group of the persistent volume |
| persistence.volumePermissions.image.pullPolicy | string | `"IfNotPresent"` | Init container volume-permissions image pull policy |
| persistence.volumePermissions.image.registry | string | `"docker.io"` | Init container volume-permissions image registry |
| persistence.volumePermissions.image.repository | string | `"debian"` | Init container volume-permissions image repository |
| persistence.volumePermissions.image.tag | string | `"12.12-slim"` | Init container volume-permissions image tag (immutable tags are recommended) |
| persistence.volumePermissions.resources | object | `{}` | Init container resource [requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) |
| persistence.volumes.persistence.accessModes | list | `["ReadWriteOnce"]` | PVC Access Mode for GridGain volume |
| persistence.volumes.persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.volumes.persistence.enabled | bool | `true` | Enable GridGain  data persistence using PVC |
| persistence.volumes.persistence.existingClaim | string | `""` | Name of an existing PVC to use |
| persistence.volumes.persistence.labels | object | `{}` | Labels for the PVC |
| persistence.volumes.persistence.mountPath | string | `"/persistence"` | The path the volume will be mounted at |
| persistence.volumes.persistence.selector | object | `{}` | Selector to match an existing Persistent Volume (this value is evaluated as a template) |
| persistence.volumes.persistence.size | string | `"8Gi"` | PVC Storage Request for GridGain volume |
| persistence.volumes.persistence.subPath | string | `""` | The subdirectory of the volume to mount to. Useful in dev environments and one PV for multiple services |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| podLabels | object | `{}` | Map of labels to add to the pods |
| podManagementPolicy | string | `"Parallel"` | Optionally specify GridGain statefulset [podManagementPolicy](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies) |
| podSecurityContext | object | `{"fsGroup":2000,"runAsNonRoot":true,"runAsUser":1000}` | [Pod Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for GridGain  pods |
| priorityClassName | string | `""` | Name of the [PriorityClass](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority) for GridGain  pods |
| rbac | object | `{"create":true,"rules":[]}` | [RBAC configuration](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) for ServiceAccount.  |
| rbac.create | bool | `true` | Creates default Role and RoleBinding |
| rbac.rules | list | `[]` | Custom RBAC rules to be added |
| readinessProbe | object | Check defaults below | Configures (readiness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| readinessProbe.enabled | bool | `true` | Enables readinessProbe on GridGain container |
| readinessProbe.failureThreshold | int | `3` | Failure threshold for readinessProbe |
| readinessProbe.httpGet | object | `{"path":"/management/v1/node/state","port":10300}` | Path and port for probe |
| readinessProbe.initialDelaySeconds | int | `30` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `10` | Period seconds for readinessProbe |
| readinessProbe.successThreshold | int | `1` | Success threshold for readinessProbe |
| readinessProbe.timeoutSeconds | int | `10` | Timeout seconds for readinessProbe |
| replicaCount | int | `3` | Number of GridGain cluster replicas |
| resources | object | Check defaults below | GridGain  [resource](https://kubernetes.io/docs/user-guide/compute-resources/) requests and limits |
| resources.limits.cpu | string | `"1"` | The cpu limit for the GridGain  containers |
| resources.limits.memory | string | `"2Gi"` | The memory limit for the GridGain  containers |
| resources.requests.cpu | string | `"1"` | The requested cpu for the GridGain  containers |
| resources.requests.memory | string | `"2Gi"` | The requested memory for the GridGain  containers |
| revisionHistoryLimit | int | `10` | The maximum number of revisions that will be maintained in the StatefulSet's [revision history](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#revision-history-limit) |
| serviceAccount | object | Check defaults below | [Service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) for GridGain to use.  |
| serviceAccount.annotations | object | `{}` | Additional custom annotations for the ServiceAccount |
| serviceAccount.automountServiceAccountToken | bool | `true` | Allows auto mount of ServiceAccountToken on the serviceAccount created. Can be set to false if pods using this serviceAccount do not need to use K8s API |
| serviceAccount.create | bool | `false` | Enable creation of ServiceAccount for GridGain pod |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| services | object | check default services configuration in values.yaml | Default GridGain  service configuration. By default all the existing ports are exposed using headless service. REST and thin-client port are exposed via ClusterIP.  |
| sidecars | list | `[]` | Add additional sidecar containers to the GridGain  pod(s) |
| startupProbe | object | Check defaults below | Configures (startup probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| startupProbe.enabled | bool | `false` | Enables startupProbe on GridGain container |
| startupProbe.failureThreshold | int | `15` | Failure threshold for startupProbe |
| startupProbe.initialDelaySeconds | int | `30` | Initial delay seconds for startupProbe |
| startupProbe.periodSeconds | int | `10` | Period seconds for startupProbe |
| startupProbe.successThreshold | int | `1` | Success threshold for startupProbe |
| startupProbe.timeoutSeconds | int | `1` | Timeout seconds for startupProbe |
| terminationGracePeriodSeconds | int | `30` | Seconds GridGain  pod needs to [terminate gracefully](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods) |
| tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) for GridGain  pods assignment |
| topologySpreadConstraints | list | `[]` | [Topology Spread Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods) for pod assignment spread across your cluster among failure-domains. Evaluated as a template |
| updateStrategy | object | Check default below | GridGain  statefulset [rolling update configuration](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies) parameters |
| updateStrategy.rollingUpdate | object | `{"partition":0}` | GridGain  statefulset rolling update configuration parameters |
| updateStrategy.type | string | `"RollingUpdate"` | GridGain  statefulset strategy type |
