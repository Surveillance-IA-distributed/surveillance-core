#!/bin/bash

# 1. Levantar el registro privado
sudo docker run -d -p 5000:5000 --name registry --restart=always registry:2

# 2. Construir imágenes desde cada contexto apropiado
cd surveillance-frontend
sudo docker build -t frontend:latest .
cd ../surveillance-backend
sudo docker build -t backend:latest .
cd ../surveillance-db/api
sudo docker build -t video-api:latest .
cd ../data
sudo docker build -t data-loader:latest .
cd ../../

# 3. Etiquetar las imágenes para apuntar al registro privado
sudo docker tag frontend:latest maestro:5000/frontend:latest
sudo docker tag backend:latest maestro:5000/backend:latest
sudo docker tag video-api:latest maestro:5000/video-api:latest
sudo docker tag data-loader:latest maestro:5000/data-loader:latest

# 4. Subir las imágenes al registro
sudo docker push maestro:5000/frontend:latest
sudo docker push maestro:5000/backend:latest
sudo docker push maestro:5000/video-api:latest
sudo docker push maestro:5000/data-loader:latest

# 5. Aplicar manifiestos de Kubernetes en orden
kubectl apply -f postgres-pv-pvc.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml

kubectl apply -f backend-deployment.yaml
kubectl apply -f backend-service.yaml

kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml

kubectl apply -f api-deployment.yaml
kubectl apply -f api-service.yaml

kubectl apply -f data-loader-deployment.yaml
kubectl apply -f data-loader-service.yaml

# 6. Verificar que las imágenes estén correctamente subidas al registro
curl http://maestro:5000/v2/frontend/tags/list
curl http://maestro:5000/v2/backend/tags/list
curl http://maestro:5000/v2/video-api/tags/list
curl http://maestro:5000/v2/data-loader/tags/list
