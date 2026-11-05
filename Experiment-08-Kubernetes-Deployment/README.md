
# Experiment 8: Deployment and Scaling of Applications Using Kubernetes

## Aim

To deploy a containerized Nginx web application on a local Kubernetes cluster, expose it through a NodePort Service, perform horizontal scaling, verify self-healing, execute rolling updates, and demonstrate deployment rollback.

## Objectives

1. Understand Kubernetes architecture.
2. Enable Kubernetes in Docker Desktop.
3. Verify the Kubernetes cluster using kubectl.
4. Create a Deployment YAML manifest.
5. Deploy Nginx containers as Pods.
6. Expose Pods using a NodePort Service.
7. Scale replicas from 3 to 5 and then to 2.
8. Modify replica counts declaratively.
9. Verify self-healing by deleting a Pod.
10. Perform a rolling image update.
11. Inspect rollout history.
12. Roll back to a previous deployment revision.

## Requirements

- Docker Desktop with Kubernetes enabled
- kubectl CLI
- Nginx container image
- VS Code or another text editor
- Terminal or PowerShell
- Web browser
- Internet connection

## Theory

### What is Kubernetes?

Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, networking, and management of containerized applications.

### What is a Cluster?

A Kubernetes cluster consists of a control plane and one or more worker nodes.

The control plane manages the desired state of applications, while worker nodes execute containers.

### What is a Pod?

A Pod is the smallest deployable unit in Kubernetes.

A Pod contains one or more containers that share networking and storage resources.

### What is a Deployment?

A Deployment defines the desired state of an application, including the container image, number of replicas, and update strategy.

It manages ReplicaSets, which maintain the required Pods.

### What is a Service?

A Service provides a stable networking endpoint for accessing a group of Pods.

### What is NodePort?

A NodePort Service exposes an application through a specified port on Kubernetes nodes.

### What is Horizontal Scaling?

Horizontal scaling increases or decreases the number of application replicas.

For example:

```text
3 Pods -> 5 Pods -> 2 Pods
```

### What is Self-Healing?

Kubernetes continuously compares actual cluster state with desired state.

If a Pod is deleted or fails, the controller creates a replacement Pod to restore the desired replica count.

### What is a Rolling Update?

A rolling update gradually replaces old Pods with new Pods when the application configuration changes.

### What is Rollback?

Rollback restores a Deployment to an earlier revision.

## Kubernetes Architecture

```text
                  Developer
                      |
                      v
                 kubectl CLI
                      |
                      v
              Kubernetes API Server
                      |
                      v
                 Control Plane
                      |
                      v
                  Deployment
                      |
                      v
                   ReplicaSet
                      |
          +-----------+-----------+
          |           |           |
          v           v           v
        Pod 1       Pod 2       Pod 3
        Nginx       Nginx       Nginx
          |           |           |
          +-----------+-----------+
                      |
                      v
                NodePort Service
                      |
                      v
                 Web Browser
```

## Algorithm

1. Start Docker Desktop.
2. Enable the local Kubernetes cluster.
3. Verify cluster connectivity.
4. Create the Deployment manifest.
5. Create the Service manifest.
6. Deploy Nginx with three replicas.
7. Verify Pods and Deployment status.
8. Expose the application through NodePort.
9. Open the application in a browser.
10. Scale the Deployment to five replicas.
11. Scale the Deployment down to two replicas.
12. Modify YAML to demonstrate declarative scaling.
13. Delete one Pod to test self-healing.
14. Update the Nginx image.
15. Verify rollout status and history.
16. Roll back to the previous revision.
17. Verify restored deployment status.

## Procedure

### Step 1: Start Docker Desktop

Launch Docker Desktop.

Verify Docker:

```bash
docker --version
```

### Step 2: Enable Kubernetes

In Docker Desktop:

1. Open Settings.
2. Locate Kubernetes.
3. Enable the local Kubernetes cluster.
4. Apply the changes.
5. Wait until Kubernetes is running.

The settings location may differ between Docker Desktop versions.

### Step 3: Verify Kubernetes

```bash
kubectl version --client
kubectl config current-context
kubectl get nodes
```

For Docker Desktop, the expected context is generally:

```text
docker-desktop
```

If necessary, select it:

```bash
kubectl config use-context docker-desktop
```

### Step 4: Create Deployment YAML

Create `deployment.yaml` with:

- Deployment name: nginx-deployment
- Image: nginx:1.27
- Replicas: 3
- Container port: 80

Use the complete manifest supplied with this experiment.

### Step 5: Create Service YAML

Create `service.yaml` with:

- Service name: nginx-service
- Type: NodePort
- Port: 80
- Target port: 80
- NodePort: 30080

### Step 6: Deploy the Application

```bash
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### Step 7: Verify Deployment

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

Wait for the Deployment:

```bash
kubectl rollout status deployment/nginx-deployment
```

### Step 8: Access Application

For Docker Desktop Kubernetes, try:

```text
http://localhost:30080
```

If your cluster does not forward NodePort traffic to localhost, use the node's reachable IP or use port forwarding:

```bash
kubectl port-forward service/nginx-service 8080:80
```

Then open:

```text
http://localhost:8080
```

### Step 9: Scale to Five Replicas

```bash
kubectl scale deployment nginx-deployment --replicas=5
```

Verify:

```bash
kubectl get pods
kubectl get deployment nginx-deployment
```

### Step 10: Scale Down to Two Replicas

```bash
kubectl scale deployment nginx-deployment --replicas=2
```

Verify:

```bash
kubectl get pods
```

### Step 11: Declarative Scaling

Open `deployment.yaml`.

Change:

```yaml
replicas: 3
```

to:

```yaml
replicas: 4
```

Apply:

```bash
kubectl apply -f deployment.yaml
```

Verify:

```bash
kubectl get deployment nginx-deployment
```

Restore `replicas: 3` in the YAML file and apply it again to return to the initial desired state.

### Step 12: Test Self-Healing

List Pods:

```bash
kubectl get pods
```

Select one Pod belonging to the Deployment and delete it:

```bash
kubectl delete pod POD_NAME
```

Replace `POD_NAME` with an actual Pod name.

Observe replacement:

```bash
kubectl get pods -w
```

Press Ctrl+C after the replacement becomes Ready.

### Step 13: Perform Rolling Update

Update the Nginx image to another valid release tag:

```bash
kubectl set image deployment/nginx-deployment \
  nginx=nginx:1.28
```

Verify:

```bash
kubectl rollout status deployment/nginx-deployment
```

Check image:

```bash
kubectl get deployment nginx-deployment \
  -o jsonpath='{.spec.template.spec.containers[0].image}'
```

### Step 14: View Rollout History

```bash
kubectl rollout history deployment/nginx-deployment
```

### Step 15: Roll Back Deployment

```bash
kubectl rollout undo deployment/nginx-deployment
```

Verify:

```bash
kubectl rollout status deployment/nginx-deployment
kubectl get deployment nginx-deployment
```

### Step 16: Inspect Deployment

```bash
kubectl describe deployment nginx-deployment
kubectl describe service nginx-service
```

### Step 17: Clean Up

When the experiment is finished:

```bash
kubectl delete -f service.yaml
kubectl delete -f deployment.yaml
kubectl delete -f configmap.yaml
```

## Important Kubernetes Commands

| Command | Purpose |
|---------|---------|
| kubectl get nodes | List nodes |
| kubectl get pods | List Pods |
| kubectl get deployments | List Deployments |
| kubectl get services | List Services |
| kubectl apply -f | Create or update resources |
| kubectl scale | Change replica count |
| kubectl delete pod | Delete a Pod |
| kubectl describe | Inspect resources |
| kubectl rollout status | Verify rollout |
| kubectl rollout history | View revisions |
| kubectl rollout undo | Restore previous revision |
| kubectl port-forward | Forward local traffic |

## Expected Output

1. Kubernetes cluster running.
2. Nginx Deployment created.
3. Three Pods running.
4. NodePort Service created.
5. Nginx application accessible.
6. Deployment scaled to five Pods.
7. Deployment scaled down to two Pods.
8. Declarative scaling demonstrated.
9. Deleted Pod automatically replaced.
10. Rolling update completed.
11. Deployment history displayed.
12. Rollback completed successfully.

## Applications

- Microservices orchestration
- Cloud-native application deployment
- Container scaling
- Self-healing systems
- Rolling software releases
- High-availability application management
- DevOps automation

## Result

Kubernetes Deployment, NodePort exposure, horizontal scaling, self-healing, rolling updates, and rollback operations are demonstrated.

## Conclusion

This experiment demonstrates how Kubernetes automates the management of containerized applications.

It provides scalable deployment, recovery from Pod failures, controlled updates, and rollback capabilities.
