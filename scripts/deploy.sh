#!/bin/bash

# Script para desplegar la aplicación Calculator en Kubernetes
# Uso: ./deploy.sh [environment] [image-tag]

set -e

ENVIRONMENT=${1:-development}
IMAGE_TAG=${2:-calculator-dev-latest}

echo "🚀 Desplegando Calculator App..."
echo "Environment: $ENVIRONMENT"
echo "Image Tag: $IMAGE_TAG"

# Verificar que kubectl esté configurado
if ! kubectl cluster-info &> /dev/null; then
    echo "❌ Error: kubectl no está configurado o no puede conectarse al cluster"
    exit 1
fi

# Actualizar el tag de la imagen
echo "📝 Actualizando tag de imagen..."
sed -i.bak "s/newTag: .*/newTag: $IMAGE_TAG/" kustomization.yaml

# Aplicar los manifiestos
echo "🔧 Aplicando manifiestos Kubernetes..."
kubectl apply -k .

# Esperar a que el deployment esté listo
echo "⏳ Esperando a que el deployment esté listo..."
kubectl rollout status deployment/calculator-app -n calculator --timeout=300s

# Verificar el estado
echo "✅ Verificando estado del despliegue..."
kubectl get pods -n calculator
kubectl get svc -n calculator

echo "🎉 ¡Despliegue completado exitosamente!"
echo "🌐 La aplicación estará disponible en: https://calculator.yourdomain.com" 