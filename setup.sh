#!/bin/bash

echo "Clonando todos los repositorios..."

echo echo "Clonando surveillance-backend..."
git clone git@github.com:Surveillance-IA-distributed/surveillance-backend.git

echo "Clonando surveillance-frontend..."
git clone git@github.com:Surveillance-IA-distributed/surveillance-frontend.git

echo "Clonando surveillance-db..."
git clone git@github.com:Surveillance-IA-distributed/surveillance-db.git

echo "Clonando surveillance-k8..."
git clone git@github.com:Surveillance-IA-distributed/surveillance-k8.git

echo "Repositorios clonados."
