
#!/usr/bin/env bash

# DevOps Laboratory - Experiment 8
# Kubernetes Deployment and Scaling

set -euo pipefail

DEPLOYMENT="nginx-deployment"
SERVICE="nginx-service"

echo "========================================"
echo "EXPERIMENT 8: KUBERNETES"
echo "========================================"

if ! command -v kubectl >/dev/null 2>&1; then
    echo "Error: kubectl is not installed."
    exit 1
fi

echo ""
echo "STEP 1: Checking Kubernetes context"
kubectl config current-context

# Protect against accidentally modifying another cluster
if [ "$(kubectl config current-context)" != "docker-desktop" ]; then
    echo "Error: Expected docker-desktop context."
    echo "Select Docker Desktop Kubernetes first."
    exit 1
fi

echo ""
echo "STEP 2: Checking cluster nodes"
kubectl get nodes

echo ""
echo "STEP 3: Checking for existing deployment"

if kubectl get deployment "$DEPLOYMENT" \
    >/dev/null 2>&1; then
    echo "Error: $DEPLOYMENT already exists."
    echo "Use a clean demo cluster or remove it manually."
    exit 1
fi

echo ""
echo "STEP 4: Applying Kubernetes manifests"
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo ""
echo "STEP 5: Waiting for deployment"
kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

echo ""
echo "STEP 6: Listing Pods"
kubectl get pods -l app=nginx-lab

echo ""
echo "STEP 7: Listing Services"
kubectl get service "$SERVICE"

echo ""
echo "STEP 8: Scaling to five replicas"
kubectl scale deployment "$DEPLOYMENT" --replicas=5
kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

kubectl get deployment "$DEPLOYMENT"

echo ""
echo "STEP 9: Scaling down to two replicas"
kubectl scale deployment "$DEPLOYMENT" --replicas=2
kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

kubectl get deployment "$DEPLOYMENT"

echo ""
echo "STEP 10: Testing self-healing"

POD_NAME=$(kubectl get pods \
    -l app=nginx-lab \
    -o jsonpath='{.items[0].metadata.name}')

if [ -z "$POD_NAME" ]; then
    echo "Error: No Nginx Pod found."
    exit 1
fi

echo "Deleting Pod: $POD_NAME"
kubectl delete pod "$POD_NAME"

kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

echo "Self-healing verification:"
kubectl get pods -l app=nginx-lab

echo ""
echo "STEP 11: Rolling update"

kubectl set image deployment/"$DEPLOYMENT" \
    nginx=nginx:1.28

kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

echo ""
echo "STEP 12: Rollout history"
kubectl rollout history deployment/"$DEPLOYMENT"

echo ""
echo "STEP 13: Rolling back"
kubectl rollout undo deployment/"$DEPLOYMENT"

kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

echo ""
echo "STEP 14: Restoring three replicas"
kubectl scale deployment "$DEPLOYMENT" --replicas=3
kubectl rollout status deployment/"$DEPLOYMENT" \
    --timeout=180s

echo ""
echo "STEP 15: Final status"
kubectl get deployment "$DEPLOYMENT"
kubectl get pods -l app=nginx-lab
kubectl get service "$SERVICE"

echo ""
echo "========================================"
echo "KUBERNETES EXPERIMENT COMPLETED"
echo "========================================"

echo "Try: http://localhost:30080"
echo "Resources remain deployed for inspection."
