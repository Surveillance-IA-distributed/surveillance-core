<!-- # 🐳 Surveillance-IA-distributed 2.0

## ⚙️ Cómo correr el proyecto

1. Clona el repositorio:

```bash
git clone https://github.com/angel452/Surveillance-IA-distributed2.0
cd <nombre_del_repositorio>
```
2. Crea los archivos .env respectivos para cada proyecto (puedes copiar los ejemplos de .env.example):
- **Raíz**: `/.env`
```env
MYSQL_DATABASE=mydb
MYSQL_USER=myuser
MYSQL_PASSWORD=mypass
MYSQL_ROOT_PASSWORD=rootpass
```

- **Backend**: `backend/.env`
```env
DATABASE_URL="mysql://root:rootpass@mysql:3306/mydb"
```

- **Frontend**: `frontend/src/environments/environment.ts` y `frontend/src/environments/environment.prod.ts`
```typescript
// frontend/src/environments/environment.ts
export const environment = {
    production: false,
    apiUrl: 'http://localhost:3000',
};

// frontend/src/environments/environment.prod.ts
export const environment = {
    production: true,
    //apiUrl: 'https://api.miapp.com',
    apiUrl: 'http://localhost:3000',
};
```

3. Ejecuta los contenedores:
```bash
docker compose build
docker compose up -d
```

---

## 🧪 Tecnologías Usadas

- Angular 18
- NestJS
- Docker / Docker Compose

--- 
## 🧑‍💻 Autor
Desarrollado por:
- Brigham Caceres: [Brigham-CG](https://github.com/Brigham-CG)
- Angel Loayza [angel452](https://github.com/angel452)
- Hugo Manchego [Gabriel-Manchego](https://github.com/Gabriel-Manchego)
- Harold Villanueva [HarryLexvb](https://github.com/HarryLexvb) -->



# Proyecto Surveillance-IA-distributed 2.0

Este proyecto es una versión mejorada de Surveillance-IA-distributed, que incluye varios microservicios para la gestión de datos e integracion con docker y kubernets. El objetivo principal es proporcionar un sistema escalable para la administracion de videos de camaras de seguridad basado en el escaneo por IA


```bash
    chmod +x setup.sh
```

```bash
    ./setup.sh
```


## Clonación de Repositorios

Para clonar todos los repositorios necesarios, sigue estos pasos:

1. **Descargar el script de clonación**: Crea un archivo llamado `setup.sh` en el directorio donde deseas clonar los repositorios y copia el siguiente contenido en el archivo.

```bash
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
```