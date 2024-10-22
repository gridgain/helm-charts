# gridgain

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![AppVersion: 8.9.11](https://img.shields.io/badge/AppVersion-8.9.11-informational?style=flat-square)

GridGain is a Unified Real-Time Data Platform by the original creators of Apache Ignite. It enables a simplified and optimized data architecture for enterprises that require extreme speed, massive scale, and high availability from their data ecosystem.

**Homepage:** <https://www.gridgain.com/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| GridGain Systems, Inc. All Rights Reserved |  | <https://www.gridgain.com/> |

## Source Code

* <https://github.com/gridgain/helm-charts/tree/main/charts/gridgain>

## TL;DR

```console
helm repo add gridgain https://gridgain.github.io/helm-charts/ 
helm install my-release gridgain/gridgain
```

## Prerequisites

- Kubernetes 1.26+
- Helm 3.11.3+
- PV provisioner support in the persistence configuration

Older version of Kubernetes and Helm vere not tested so use it at your peril.  

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) for GridGain DB  pods assignment |
| annotations | object | `{}` | Annotations for GridGain DB resources |
| args | list | `[]` | Override default container args (useful when using custom images) |
| auth.enabled | bool | `false` | GridGain DB [authentication configuration](https://www.gridgain.com/docs/latest/administrators-guide/security/authentication) |
| auth.users | object | Check defaults below | Users section. License required to use it.  |
| auth.users.server | object | `{"name":"server1","password":"password1","permissions":"{defaultAllow:true}"}` | Key. Only server key is required to run server nodes using this user, all the others are optional.  |
| auth.users.server.name | string | `"server1"` | Name of the user to be created.  |
| auth.users.server.password | string | `"password1"` | Password of the user to be created.  |
| auth.users.server.permissions | string | `"{defaultAllow:true}"` | Permissions of the user to be created.  |
| command | list | `[]` | Override default container command (useful when using custom images) |
| commonAnnotations | object | `{}` | Add annotations to all the deployed resources |
| configMaps | object | Check default values.yaml to view default config | GridGain DB  main configuration to be injected as ConfigMap.  |
| configMapsFromFile | object | `{"default-config":{"filename":"default-config.xml","path":"/opt/gridgain/config/default-config.xml"}}` | GridGain DB  main configuration to be injected as ConfigMap from files (files/configmaps) |
| containerPorts | list | check default container ports in values.yaml | GridGain DB container ports |
| containerSecurityContext | object | `{}` | [Container Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for GridGain DB container |
| controlCenterUrl | string | `""` | URL of [Control Center](https://www.gridgain.com/docs/control-center/latest/getting-started/connect/connect-gridgain-cluster). Just regular url required. Disabled by default |
| customLabels | object | `{}` | Add labels to all the deployed resources. May be templated |
| existingConfigmap | object | `{}` | Existing configmap with GridGain DB configuration to be mounted to StatefulSet |
| extraDeploy | list | `[]` | Array of extra objects to deploy with the release (evaluated as a template) |
| extraEnvVars | list | `[]` | Array with extra environment variables to add to GridGain DB  nodes |
| extraEnvVarsCM | string | `""` | Name of existing ConfigMap containing extra env vars for GridGain DB  nodes |
| extraEnvVarsSecret | string | `""` | Name of existing Secret containing extra env vars for GridGain DB  nodes |
| extraPodSpec | object | `{}` | Optionally specify extra PodSpec for the GridGain DB  pod(s) |
| extraPostHooks | list | `[]` | Array of extra post install/upgrade hooks to deploy with the release (partially evaluated as a template) |
| extraVolumeMounts | list | `[]` | Optionally specify extra list of additional volumeMounts for the GridGain DB  container(s) |
| extraVolumes | list | `[]` | Optionally specify extra list of additional volumes for the GridGain DB  pod(s) |
| fullnameOverride | string | `""` | String to fully override common.names.fullname template |
| igniteWorkDir | string | `"/persistence"` | GridGain [persistent storage directory](https://www.gridgain.com/docs/latest/developers-guide/persistence/native-persistence#configuring-persistent-storage-directory) |
| image.pullPolicy | string | `"IfNotPresent"` | Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' |
| image.registry | string | `"docker.io"` | GridGain DB image registry |
| image.repository | string | `"gridgain/community"` | GridGain DB image repository |
| image.tag | string | `nil` | if not set appVersion field from Chart.yaml is used |
| initContainers | list | `[]` | Add additional init containers to the GridGain DB  pod(s) |
| jvmOpts | string | `"-Xlog:gc*:file=$(IGNITE_WORK_DIR)/grid-gclog.txt:time:filecount=10,filesize=100m \n-Djava.net.preferIPv4Stack=true -Xmx2G -Xms1G -XX:MaxMetaspaceSize=250m -XX:MaxDirectMemorySize=1g\n-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=$(IGNITE_WORK_DIR) -ea\n-XX:StartFlightRecording=dumponexit=true,filename=$(IGNITE_WORK_DIR)/gridgain.jfr,maxsize=1g,maxage=6h,settings=profile\n"` | JVM options for GridGain DB  nodes |
| labels | object | `{}` | Map of labels |
| license | object | `{}` | [GridGain DB license](https://www.gridgain.com/docs/latest/installation-guide/licenses) to be created or mounted as a secret. Needed to use GridGain Enterprise Edition (EE) or Ultimate Edition (UE) |
| lifecycleHooks | object | `{}` | Lifecycle hooks for GridGain DB  container |
| livenessProbe | object | Check defaults below | Configures (liveness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| livenessProbe.enabled | bool | `true` | Enables livenessProbe on GridGain container |
| livenessProbe.failureThreshold | int | `3` | Failure threshold for livenessProbe |
| livenessProbe.httpGet | object | `{"path":"/ignite?cmd=version","port":8080}` | Path and port for probe |
| livenessProbe.initialDelaySeconds | int | `5` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `30` | Period seconds for livenessProbe |
| livenessProbe.successThreshold | int | `1` | Success threshold for livenessProbe |
| livenessProbe.timeoutSeconds | int | `10` | Timeout seconds for livenessProbe |
| metrics.enabled | bool | `false` | Enables prometheus metrics exposing via port 9000. Available since GridGain DB version 8.9.9 |
| nameOverride | string | `""` | String to partially override common.names.fullname template (will maintain the release name) |
| networkPolicy | object | `{}` | [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/) |
| nodeSelector | object | `{}` | [Node labels](https://kubernetes.io/docs/user-guide/node-selection/) for GridGain DB  pods assignment |
| optionLibs | string | `"ignite-kubernetes,ignite-rest-http,ignite-log4j2,control-center-agent,ignite-schedule"` | GridGain [modules](https://www.gridgain.com/docs/latest/developers-guide/setup#enabling-modules) to be enabled |
| persistence | object | By default only one volume will be created. Check default values.yaml to view more details | GridGain DB  persistence configuration |
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
| persistence.volumePermissions.image.repository | string | `"bitnami/os-shell"` | Init container volume-permissions image repository |
| persistence.volumePermissions.image.tag | string | `"12-debian-12-r21"` | Init container volume-permissions image tag (immutable tags are recommended) |
| persistence.volumePermissions.resources | object | `{}` | Init container resource [requests and limits](https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/) |
| persistence.volumes.persistence.accessModes | list | `["ReadWriteOnce"]` | PVC Access Mode for GridGain DB volume |
| persistence.volumes.persistence.annotations | object | `{}` | Annotations for the PVC |
| persistence.volumes.persistence.enabled | bool | `true` | Enable GridGain DB  data persistence using PVC |
| persistence.volumes.persistence.existingClaim | string | `""` | Name of an existing PVC to use |
| persistence.volumes.persistence.labels | object | `{}` | Labels for the PVC |
| persistence.volumes.persistence.mountPath | string | `"/persistence"` | The path the volume will be mounted at |
| persistence.volumes.persistence.selector | object | `{}` | Selector to match an existing Persistent Volume (this value is evaluated as a template) |
| persistence.volumes.persistence.size | string | `"8Gi"` | PVC Storage Request for GridGain DB volume |
| persistence.volumes.persistence.subPath | string | `""` | The subdirectory of the volume to mount to. Useful in dev environments and one PV for multiple services |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| podLabels | object | `{}` | Map of labels to add to the pods |
| podManagementPolicy | string | `"OrderedReady"` | Optionally specify GridGain statefulset [podManagementPolicy](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-management-policies) |
| podSecurityContext | object | `{"fsGroup":2000,"runAsNonRoot":true,"runAsUser":1000}` | [Pod Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for GridGain DB  pods |
| priorityClassName | string | `""` | Name of the [PriorityClass](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority) for GridGain DB  pods |
| rbac | object | `{"create":true,"rules":[]}` | [RBAC configuration](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) for ServiceAccount. Required to run GridGain DB in multiple replicas. |
| rbac.create | bool | `true` | Creates default Role and RoleBinding |
| rbac.rules | list | `[]` | Custom RBAC rules to be added |
| readinessProbe | object | Check defaults below | Configures (readiness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| readinessProbe.enabled | bool | `true` | Enables readinessProbe on GridGain container |
| readinessProbe.failureThreshold | int | `3` | Failure threshold for readinessProbe |
| readinessProbe.httpGet | object | `{"path":"/ignite?cmd=version","port":8080}` | Path and port for probe |
| readinessProbe.initialDelaySeconds | int | `30` | Initial delay seconds for readinessProbe |
| readinessProbe.periodSeconds | int | `10` | Period seconds for readinessProbe |
| readinessProbe.successThreshold | int | `1` | Success threshold for readinessProbe |
| readinessProbe.timeoutSeconds | int | `10` | Timeout seconds for readinessProbe |
| replicaCount | int | `1` | Number of GridGain cluster replicas |
| resources | object | Check defaults below | GridGain DB  [resource](https://kubernetes.io/docs/user-guide/compute-resources/) requests and limits |
| resources.limits.cpu | string | `"1"` | The cpu limit for the GridGain DB  containers |
| resources.limits.memory | string | `"2Gi"` | The memory limit for the GridGain DB  containers |
| resources.requests.cpu | string | `"1"` | The requested cpu for the GridGain DB  containers |
| resources.requests.memory | string | `"2Gi"` | The requested memory for the GridGain DB  containers |
| revisionHistoryLimit | int | `10` | The maximum number of revisions that will be maintained in the StatefulSet's [revision history](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#revision-history-limit) |
| serviceAccount | object | Check defaults below | [Service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) for GridGain DB to use. . Required to run GridGain DB in multiple replicas. |
| serviceAccount.annotations | object | `{}` | Additional custom annotations for the ServiceAccount |
| serviceAccount.automountServiceAccountToken | bool | `true` | Allows auto mount of ServiceAccountToken on the serviceAccount created. Can be set to false if pods using this serviceAccount do not need to use K8s API |
| serviceAccount.create | bool | `true` | Enable creation of ServiceAccount for GridGain DB pod |
| serviceAccount.name | string | `""` | The name of the ServiceAccount to use. If not set and create is true, a name is generated using the common.names.fullname template |
| services | object | check default services configuration in values.yaml | Default GridGain DB  service configuration. By default all the existing ports are exposed using headless service. REST and thin-client port are exposed via ClusterIP.  |
| sidecars | list | `[]` | Add additional sidecar containers to the GridGain DB  pod(s) |
| startupProbe | object | Check defaults below | Configures (startup probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for GridGain container |
| startupProbe.enabled | bool | `false` | Enables startupProbe on GridGain container |
| startupProbe.failureThreshold | int | `15` | Failure threshold for startupProbe |
| startupProbe.initialDelaySeconds | int | `30` | Initial delay seconds for startupProbe |
| startupProbe.periodSeconds | int | `10` | Period seconds for startupProbe |
| startupProbe.successThreshold | int | `1` | Success threshold for startupProbe |
| startupProbe.timeoutSeconds | int | `1` | Timeout seconds for startupProbe |
| terminationGracePeriodSeconds | int | `30` | Seconds GridGain DB  pod needs to [terminate gracefully](https://kubernetes.io/docs/concepts/workloads/pods/pod/#termination-of-pods) |
| tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) for GridGain DB  pods assignment |
| topologySpreadConstraints | list | `[]` | [Topology Spread Constraints](https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/#spread-constraints-for-pods) for pod assignment spread across your cluster among failure-domains. Evaluated as a template |
| updateStrategy | object | Check default below | GridGain DB  statefulset [rolling update configuration](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies) parameters |
| updateStrategy.rollingUpdate | object | `{"partition":0}` | GridGain DB  statefulset rolling update configuration parameters |
| updateStrategy.type | string | `"RollingUpdate"` | GridGain DB  statefulset strategy type |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
