# GridGain9 with KEDA Autoscaling Example

This example demonstrates how to deploy GridGain9 with KEDA-based autoscaling and Prometheus metrics scraping.

## Prerequisites

- A running Kubernetes cluster (v1.21 or newer)
- `kubectl` installed and configured
- Helm v3 installed
- KEDA installed in your cluster
- Prometheus Operator installed (for ServiceMonitor support)

## Installation

1. **Add Helm repositories:**
   ```bash
   helm repo add kedacore https://kedacore.github.io/charts
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

2. **Install KEDA:**
   ```bash
   helm install keda kedacore/keda --namespace keda --create-namespace
   ```

3. **Install Prometheus (if not already installed):**
   ```bash
   helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
   ```

4. **Deploy GridGain9 with KEDA autoscaling:**
   ```bash
   helm install gridgain9 ./charts/gridgain9 -f examples/keda-autoscaling/values.yaml --namespace gridgain --create-namespace
   ```

## Customization

### Adding Custom Metrics

To add custom metrics for scaling, modify the `keda.triggers` section in the values file:

```yaml
keda:
  triggers:
    - type: prometheus
      metadata:
        serverAddress: http://prometheus-server.monitoring.svc.cluster.local:9090
        metricName: gridgain_custom_metric
        query: gridgain_custom_metric
        threshold: "5"
```

### Multiple Scaling Triggers

You can configure multiple triggers for different scaling conditions:

```yaml
keda:
  triggers:
    - type: prometheus
      metadata:
        serverAddress: http://prometheus-server.monitoring.svc.cluster.local:9090
        metricName: gridgain_cpu_usage
        query: gridgain_cpu_usage
        threshold: "80"
    - type: prometheus
      metadata:
        serverAddress: http://prometheus-server.monitoring.svc.cluster.local:9090
        metricName: gridgain_memory_usage
        query: gridgain_memory_usage
        threshold: "85"
```

## Monitoring

### Check KEDA ScaledObject Status

```bash
kubectl get scaledobject -n gridgain
kubectl describe scaledobject gridgain9 -n gridgain
```

### Check KEDA Recovery ScaledJob Status

```bash
kubectl get scaledjob -n gridgain
kubectl describe scaledjob gridgain9-recovery -n gridgain
```

### Check ServiceMonitor Status

```bash
kubectl get servicemonitor -n monitoring
kubectl describe servicemonitor gridgain9 -n monitoring
```

### View Metrics

Access Prometheus UI to view GridGain9 metrics:
```bash
kubectl port-forward svc/prometheus-server 9090:9090 -n monitoring
```

Then open http://localhost:9090 in your browser.
