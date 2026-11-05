
#!/usr/bin/env bash

# DevOps Laboratory - Experiment 10
# Prometheus and Grafana Setup

set -euo pipefail

echo "========================================"
echo "EXPERIMENT 10: MONITORING INTEGRATION"
echo "========================================"

for tool in kubectl helm; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Error: $tool is required."
        exit 1
    fi
done

echo ""
echo "STEP 1: Verify Kubernetes cluster"
kubectl cluster-info

echo ""
echo "STEP 2: Verify application deployment"
kubectl rollout status \
    deployment/devops-go-app \
    -n devops-lab \
    --timeout=180s

echo ""
echo "STEP 3: Add Prometheus Helm repository"

helm repo add prometheus-community \
    https://prometheus-community.github.io/helm-charts

helm repo update

echo ""
echo "STEP 4: Install monitoring stack"

helm upgrade --install monitoring \
    prometheus-community/kube-prometheus-stack \
    --namespace monitoring \
    --create-namespace \
    -f monitoring/helm-values.yaml \
    --wait \
    --timeout 10m

echo ""
echo "STEP 5: Apply ServiceMonitor"

kubectl apply -f k8s/servicemonitor.yaml

echo ""
echo "STEP 6: Verify ServiceMonitor"

kubectl get servicemonitor \
    -n devops-lab

echo ""
echo "STEP 7: Verify monitoring Pods"

kubectl get pods \
    -n monitoring

echo ""
echo "STEP 8: Verify application Pods"

kubectl get pods \
    -n devops-lab

echo ""
echo "========================================"
echo "MONITORING INSTALLATION COMPLETED"
echo "========================================"

echo "Grafana:"
echo "kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80"

echo ""
echo "Prometheus:"
echo "kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090"
