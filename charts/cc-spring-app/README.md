# cc-spring-app

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![AppVersion: 2025-02-14](https://img.shields.io/badge/AppVersion-2025--02--14-informational?style=flat-square)

Helm chart to deploy Control Center Spring applications

**Homepage:** <https://www.gridgain.com/products/control-center>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| GridGain Systems, Inc. All Rights Reserved |  | <https://www.gridgain.com/> |

## Source Code

* <https://github.com/gridgain/helm-charts/tree/main/charts/cc-spring-app>

## TL;DR

1. Add GridGain Helm repository
```console
helm repo add gridgain https://gridgain.github.io/helm-charts/ 
helm repo update
```
2. Prepare `values.yaml` relevant for your release, make sure you defined all the placeholders, check examples for more details
3. Install release
```console
helm install my-release gridgain/cc-spring-app -f values.yaml
```

## Prerequisites

- Kubernetes 1.26+
- Helm 3.11.3+
- PV provisioner support in the persistence configuration

Older version of Kubernetes and Helm were not tested so use it at your peril.  

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) for Control Center Spring application  pods assignment |
| annotations | object | `{}` | Annotations for Control Center Spring application resources |
| commonAnnotations | object | `{}` | Add annotations to all the deployed resources |
| configMaps | object | `{}` | Additional configuration to be injected as ConfigMap |
| containerPort | int | `3000` | Control Center Spring application container ports |
| customLabels | object | `{}` | Add labels to all the deployed resources. May be templated |
| extraEnv | object | `{"JVM_OPTS":"-Xms256m -Xmx480m"}` | Array with extra environment variables to add to Control Center Spring application  nodes |
| fullnameOverride | string | `""` | String to fully override common.names.fullname template |
| image.pullPolicy | string | `"IfNotPresent"` | Defaults to 'Always' if image tag is 'latest', else set to 'IfNotPresent' |
| image.repository | string | `"gridgain/control-center-cloud-connector"` | Control Center Spring application image repository, cloud-connector will be used by default |
| image.tag | string | `nil` | if not set appVersion field from Chart.yaml is used |
| imagePullSecrets | list | `[]` | Name of the secret to pull a docker image from [private registry](https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/) |
| ingress | object | check example of configuration in values.yaml | [Kubernetes Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) configuration |
| ingress.enabled | bool | `false` | If true, Control Center Spring application Ingress will be created |
| ingress.tls | list | `[{"hosts":["connector.example.io"],"secretName":"connector.example.io-tls"}]` | Ingress TLS configuration secrets, secret must be manually created in the namespace |
| labels | object | `{}` | Map of labels |
| livenessProbe | object | Use default values.yaml to check defaults | Configures (liveness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for Control Center Spring application container |
| livenessProbe.httpGet | object | `{"path":"/actuator/health/liveness","port":"http"}` | Path and port for probe |
| livenessProbe.initialDelaySeconds | int | `300` | Initial delay seconds for livenessProbe |
| livenessProbe.periodSeconds | int | `10` | Period seconds for livenessProbe |
| nameOverride | string | `""` | String to partially override common.names.fullname template (will maintain the release name) |
| nodeSelector | object | `{}` | [Node labels](https://kubernetes.io/docs/user-guide/node-selection/) for Control Center Spring application  pods assignment |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| podDisruptionBudget | object | `{"enabled":false,"minAvailable":1}` | [Disruption Budget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/) configuration |
| podLabels | object | `{}` | Map of labels to add to the pods |
| priorityClassName | string | `""` | Name of the [PriorityClass](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority) for Control Center Spring application  pods |
| rbac | object | `{"create":true,"rules":[{"apiGroups":[""],"resources":["services","pods","endpoints","configmaps"],"verbs":["get","list"]}]}` | [RBAC configuration](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) for ServiceAccount |
| rbac.create | bool | `true` | Creates default Role and RoleBinding |
| rbac.rules | list | `[{"apiGroups":[""],"resources":["services","pods","endpoints","configmaps"],"verbs":["get","list"]}]` | Custom RBAC rules to be added |
| readinessProbe | object | Use default values.yaml to check defaults | Configures (readiness probe)[https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#configure-probes] for Control Center Spring application container |
| readinessProbe.httpGet | object | `{"path":"/actuator/health/readiness","port":"http"}` | Path and port for probe |
| readinessProbe.initialDelaySeconds | int | `60` | Initial delay seconds for livenessProbe |
| readinessProbe.periodSeconds | int | `10` | Period seconds for livenessProbe |
| replicaCount | int | `1` | Number of Control Center Spring application replicas |
| resources | object | Use default values.yaml to check defaults | Control Center Spring application  [resource](https://kubernetes.io/docs/user-guide/compute-resources/) requests and limits |
| resources.limits.cpu | string | `"300m"` | The cpu limit for the Control Center Spring application  containers |
| resources.limits.memory | string | `"512Mi"` | The memory limit for the Control Center Spring application  containers |
| resources.requests.cpu | string | `"300m"` | The requested cpu for the Control Center Spring application  containers |
| resources.requests.memory | string | `"512Mi"` | The requested memory for the Control Center Spring application  containers |
| securityContext | object | `{"fsGroup":10001,"runAsUser":10001}` | [Pod Security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/) for Control Center Spring application  pods |
| service | object | check default services configuration in values.yaml | Default Control Center Spring application  service configuration |
| serviceAccount | object | Use default values.yaml to check defaults | [Service account](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/) for Control Center Spring application to use |
| serviceAccount.create | bool | `true` | Enable creation of ServiceAccount for Control Center Spring application pod |
| spring | object | Use default values.yaml to check defaults | Spring configuration for Control Center Spring application |
| spring.config | object | Use default values.yaml to check defaults | Customized config for Control Center Spring application. by default will be rendered to `/opt/app/config/application.yml` |
| spring.config.content | string | Use default values.yaml to check defaults | Contents of config in YAML |
| spring.config.name | string | `"application.yaml"` | Name of the config |
| spring.config.path | string | `"/opt/app/config"` | Path of the config |
| spring.config.type | string | `"file"` | Currently supports only file |
| spring.trustKubernetesCertificates | bool | `true` | Ensures that Spring trusts Kubernetes certificate for use with service discovery, configuration, etc. |
| tolerations | list | `[]` | [Tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) for Control Center Spring application  pods assignment |
