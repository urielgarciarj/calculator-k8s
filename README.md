# Kubernetes Manifests - Calculator App

This repository contains all the Kubernetes manifests necessary to deploy the Calculator application in an EKS cluster.

## Structure

```
k8s-manifests/
├── .github/workflows/          # CI/CD workflows
├── base/                      # Common base configuration
│   ├── deployment.yaml        # Application deployment
│   ├── service.yaml          # Service to expose the app
│   ├── ingress.yaml          # Ingress for external access
│   ├── namespace.yaml        # Namespace to isolate resources
│   ├── configmap.yaml        # Application configurations
│   └── kustomization.yaml    # Kustomize base
├── overlays/                  # Environment-specific configurations
│   ├── development/          # Development configuration
│   └── production/           # Production configuration
└── scripts/                  # Utility scripts
```

## Manual Deployment

```bash
# Deploy to development
kubectl apply -k overlays/development/

# Deploy to production
kubectl apply -k overlays/production/

# Check status
kubectl get all -n calculator-dev  # for development
kubectl get all -n calculator-prod # for production

# View logs
kubectl logs -f deployment/calculator-app -n calculator-dev
```

## Deployment by Environment

### Development
```bash
kubectl apply -k overlays/development/
```

### Production
```bash
kubectl apply -k overlays/production/
```

## Required Environment Variables

### GitHub Secrets (in Kubernetes repository)
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key
- `REPO_ACCESS_TOKEN`: GitHub token for triggers

### GitHub Secrets (in application repository)
- `DOCKERHUB_USERNAME`: Docker Hub username
- `DOCKERHUB_TOKEN`: Docker Hub token
- `REPO_ACCESS_TOKEN`: GitHub token for triggers

## CI/CD Flow

1. **Push to development** in the application repository
2. **Build and push** Docker image
3. **Trigger** to Kubernetes repository
4. **Automatic deployment** in EKS cluster

## Domain Configuration

Update the `ingress.yaml` file with:
- Your real domain
- SSL certificate ARN in AWS Certificate Manager
- AWS Account ID 