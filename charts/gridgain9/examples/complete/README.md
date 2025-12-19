# GridGain 9 Complete Example

This example demonstrates a complete production-ready configuration for GridGain 9 with performance optimizations, custom storage volumes, and external service access.

## Usage

To deploy this configuration:

```bash
helm upgrade --install gridgain9-complete gridgain/gridgain9 -f values.yaml --timeout 10m
```

This command will:
- Install or upgrade the GridGain 9 release named `gridgain9-complete`
- Use the configuration from `values.yaml` in this directory
- Set a 10-minute timeout for the deployment

## Java Parameters Requirements

**REQUIRED**: You must explicitly set both `-Xmx` and `-Xms` JVM parameters. Using percentage-based heap sizing (e.g., `-XX:MaxRAMPercentage`) is not recommended for Kubernetes workloads.

When configuring JVM heap size, follow these guidelines:

- **`-Xmx` (Maximum Heap Size)**: **REQUIRED** - Should be set to **50-60%** of the container memory limit
  - Example: For a 16Gi container limit, set `-Xmx` to 8-9.6Gi (50-60% of 16Gi)
  - This leaves memory for off-heap storage, metaspace, code cache, and OS overhead

- **`-Xms` (Initial Heap Size)**: **REQUIRED** - Should be set to **30-60%** of the container memory limit
  - Example: For a 16Gi container limit, set `-Xms` to 4.8-9.6Gi (30-60% of 16Gi)
  - Setting `-Xms` equal to `-Xmx` (using `-XX:+AlwaysPreTouch`) is recommended for production to avoid heap resizing

In this example, with a 16Gi memory limit:
- `-Xmx10g` (62.5% of 16Gi) - slightly above recommended range
- `-Xms10g` (62.5% of 16Gi) - matches `-Xmx` for optimal performance

The JVM parameters are configured via the `extraEnvVars` section:

```yaml
extraEnvVars:
  - name: GRIDGAIN9_EXTRA_JVM_ARGS
    value: "-Xms10g -Xmx10g ..."
```

## License Configuration

GridGain Enterprise Edition (EE) or Ultimate Edition (UE) requires a valid license. The license can be configured in three ways:

### 1. Create Secret from Raw Content

```yaml
license:
  mountPath: /opt/gridgain/etc/license.conf
  createSecret:
    mountPath: /opt/gridgain/etc
    content: |
      {"edition":"ULTIMATE",...}
```

### 2. Create Secret from File

```yaml
license:
  mountPath: /opt/gridgain/etc/license.conf
  fromFile:
    filepath: files/secrets/license.conf
```

### 3. Use Existing Secret

```yaml
license:
  mountPath: /opt/gridgain/etc/license.conf
  useExisting:
    secretname: my-license-secret
    secretkey: license.conf
```

**Note**: Replace the placeholder content in `values.yaml` with your actual license content.

## Services Configuration

By default, GridGain exposes services via a headless ClusterIP service. This example demonstrates how to configure external access using NodePort or LoadBalancer services.

### NodePort Service

Exposes services on a static port on each node's IP:

```yaml
services:
  rest:
    type: NodePort
    ports:
      rest: 10800
      management: 10300
    sessionAffinity: None
  cluster:
    type: NodePort
    ports:
      cluster: 3344
    sessionAffinity: None
```

### LoadBalancer Service

Exposes services via a cloud provider's load balancer:

```yaml
services:
  rest:
    type: LoadBalancer
    externalTrafficPolicy: Cluster  # Preserve client source IP
    ports:
      rest: 10800
      management: 10300
    sessionAffinity: None
```

**Available Service Types**:
- `ClusterIP` (default) - Internal cluster access only
- `NodePort` - External access via node IP and static port
- `LoadBalancer` - External access via cloud load balancer

**Service Ports**:
- `rest`: REST API port (default: 10800)
- `management`: Management API port (default: 10300)
- `cluster`: Cluster communication port (default: 3344)

## SecurityContext Configuration

The `securityContext` configuration controls container security settings. This is particularly important for init containers that need privileged access.

### Init Container SecurityContext

This example shows an init container with privileged access to modify kernel parameters:

```yaml
initContainers:
  - name: sysctl-setup
    # ... container configuration ...
    securityContext:
      privileged: true
      runAsUser: 0
      runAsGroup: 0
      runAsNonRoot: false
      capabilities:
        add:
          - SYS_ADMIN
          - SYS_RESOURCE
```

**Key Settings**:
- `privileged: true` - Grants full access to host devices and kernel features
- `runAsUser: 0` - Runs as root user (required for sysctl modifications)
- `runAsNonRoot: false` - Allows running as root
- `capabilities.add` - Adds specific Linux capabilities (SYS_ADMIN, SYS_RESOURCE for sysctl)

### Main Container SecurityContext

The main GridGain container uses a more restrictive security context (configured in default `values.yaml`):

```yaml
containerSecurityContext:
  runAsUser: 1001
  runAsGroup: 1001
  runAsNonRoot: true
  privileged: false
  capabilities:
    drop: ["ALL"]
```

**Note**: If you need to modify the main container's security context, override `containerSecurityContext` in your `values.yaml`. However, running the main container as root is not recommended for security reasons.

## Additional Configuration

This example includes several production-ready configurations:

- **Storage Volumes**: Custom volumes for raft logs, persistence, and application logs
- **JMX Metrics**: Enabled for Prometheus scraping
- **ServiceMonitor**: Configured for Prometheus metrics collection
- **Init Containers**: Performance tuning with sysctl modifications
- **Probes**: Configured liveness, readiness, and startup probes
- **Resources**: Guaranteed QoS with explicit CPU and memory limits

## References

- For more configuration examples, see other examples in `charts/gridgain9/examples/`
- For all available configuration parameters, see the default `values.yaml` at `charts/gridgain9/values.yaml`
- For this example's specific overrides, see `values.yaml` in this directory

