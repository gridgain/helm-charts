# GridGain with KEDA Scaling Example

This repository contains a set of Kubernetes manifests to deploy a GridGain cluster with KEDA-based autoscaling.

## Prerequisites

- A running Kubernetes cluster (v1.20 or newer).
- `kubectl` installed and configured to connect to your cluster.
- Helm v3 installed.

## Deployment

The deployment is broken down into the following steps:

1. **Create Namespace for GridGain:**
   ```sh
   kubectl create namespace gridgain
   ```

2. **Deploy KEDA and Prometheus:**
   Add the necessary Helm repositories and install KEDA and Prometheus. The `helm install keda` command will create the `keda` namespace automatically.
   ```sh
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update

   helm install keda kedacore/keda --namespace keda --create-namespace
   helm install prometheus prometheus-community/prometheus --namespace keda -f prom-values.yaml
   ```

3. **Create GridGain Configuration:**
   Create the `ConfigMap` and `Secret` for the GridGain cluster.
   - `gridgain-config.conf`: Main GridGain configuration.
   - `gridgain-license.conf`: GridGain license file.
   - `gridgain-recovery-configmap.yaml`: Configuration for rebalancing.
   - `jmx-configmap.yaml`: JMX configuration for Prometheus.
   ```sh
   kubectl create configmap gridgain-config --from-file=gridgain-config.conf -n gridgain
   kubectl create configmap gridgain-license --from-file=gridgain-license.conf -n gridgain
   kubectl apply -n gridgain -f jmx-configmap.yaml
   kubectl apply -n gridgain -f gridgain-recovery-configmap.yaml
   ```

4. **Deploy the GridGain Cluster:**
   Deploy the GridGain StatefulSet and its headless service.
   - `headless-svc.yaml`: Headless service for the GridGain cluster.
   - `gridgain-sts.yaml`: StatefulSet for the GridGain cluster.
   ```sh
   kubectl apply -n gridgain -f headless-svc.yaml
   kubectl apply -n gridgain -f gridgain-sts.yaml
   ```

5. **Deploy KEDA Scaling Components:**
   Deploy the KEDA `ScaledObject` and `ScaledJob` to enable autoscaling.
   - `keda-scaled-object.yaml`: Defines the scaling rules for the GridGain cluster.
   - `keda-recovery-scaled-job.yaml`: A KEDA-managed job for re-building CMG nodes in the GridGain cluster.
   ```sh
   kubectl apply -n gridgain -f keda-scaled-object.yaml
   kubectl apply -n gridgain -f keda-recovery-scaled-job.yaml
   ```

## Important: Memory Configuration for Autoscaling

For KEDA autoscaling to function correctly based on JVM metrics, you **must** define the maximum heap and non-heap (Metaspace) memory for the GridGain Java process. If these are not set, threshold values will be calculated incorrectly.

You can set these limits by modifying the `gridgain-sts.yaml` file. Add the `-Xmx` (max heap size) and `-XX:MaxMetaspaceSize` (max non-heap/metaspace size) flags to the `GRIDGAIN9_EXTRA_JVM_ARGS` environment variable.

The total memory for these flags should be less than the container's memory limit (e.g., `memory: 4Gi` in the StatefulSet).

**Example:**

In `gridgain-sts.yaml`, update the `env` section for the `gridgain-node` container as follows:

```yaml
        env:
          # Must be specified to ensure that GridGain 9 cluster replicas are visible to each other.
          - name: GRIDGAIN_NODE_NAME
            valueFrom:
              fieldRef:
                fieldPath: metadata.name
          # GridGain 9 working directory.
          - name: GRIDGAIN_WORK_DIR
            value: /gg9-work
          # Set JVM args for JMX agent and memory limits
          - name: GRIDGAIN9_EXTRA_JVM_ARGS
            value: "-javaagent:/agent/jmx.jar=9404:/opt/jmx/jmx.yaml -Xmx3g -XX:MaxMetaspaceSize=512m"
```

## Recovery

The `gridgain-recovery.sh` script is provided for manual recovery. To use it, you will need to execute it within the context of one of the GridGain pods.

## Cleanup

To remove all the resources created in this example, run the following commands:
```sh
kubectl delete namespace gridgain
kubectl delete namespace keda
```
