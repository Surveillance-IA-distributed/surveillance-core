#!/bin/bash

# 1. Levantar el registro privado
sudo docker run -d -p 5000:5000 --name registry --restart=always registry:2

# 2. Construir imágenes desde cada contexto apropiado
cd postgres
sudo docker build -t postgres:latest .
cd ..
cd surveillance-frontend
sudo docker build -t frontend:latest .
cd ../surveillance-backend
sudo docker build -t backend:latest .
cd ../surveillance-db
sudo docker build -t video-api:latest -f api/Dockerfile . 
sudo docker build -t data-loader:latest -f data/Dockerfile .
cd ../

# 3. Etiquetar las imágenes para apuntar al registro privado
sudo docker tag frontend:latest maestro:5000/frontend:latest
sudo docker tag backend:latest maestro:5000/backend:latest
sudo docker tag video-api:latest maestro:5000/video-api:latest
sudo docker tag data-loader:latest maestro:5000/data-loader:latest
sudo docker tag postgres:latest maestro:5000/postgres:latest

# 4. Subir las imágenes al registro
sudo docker push maestro:5000/frontend:latest
sudo docker push maestro:5000/backend:latest
sudo docker push maestro:5000/video-api:latest
sudo docker push maestro:5000/data-loader:latest
sudo docker push maestro:5000/postgres:latest


kubectl delete job --all
kubectl delete deployment postgres
kubectl delete pvc postgres-pvc
kubectl delete pv postgres-pv

sudo rm -rf /mnt/data/postgres
sudo ls -la /mnt/data/postgres


# 5. Aplicar manifiestos de Kubernetes en orden
kubectl apply -f postgres-pv-pvc.yaml
kubectl apply -f postgres.yaml

kubectl apply -f data-loader-job.yaml

kubectl create configmap video-api-env --from-file=.env=./surveillance-db/.env
kubectl apply -f api.yaml

kubectl create configmap backend-config --from-file=.env=./surveillance-backend/.env
kubectl apply -f backend.yaml

kubectl apply -f frontend.yaml



# 6. Verificar que las imágenes estén correctamente subidas al registro
curl http://maestro:5000/v2/frontend/tags/list
curl http://maestro:5000/v2/backend/tags/list
curl http://maestro:5000/v2/video-api/tags/list
curl http://maestro:5000/v2/data-loader/tags/list





sudo docker rmi -f $(sudo docker images -q)

kubectl exec -it $(kubectl get pod -l app=angular-frontend -o jsonpath="{.items[0].metadata.name}") -- sh
