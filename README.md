# Autenticación de Clientes – Proyecto Node.js + MySQL para eBusiness "La Jícara"

Sistema de autenticación completo para el eCommerce "La Jícara". Incluye registro, inicio de sesión, encriptación de contraseñas, validaciones con Zod, generación de tokens JWT y una interfaz frontend básica para interacción del usuario.

El objetivo es proporcionar una base sólida, portable y funcional para integrarla dentro de un entorno de eBusiness real.

## 1. Tecnologías utilizadas

- Node.js (ES Modules)
- Express.js
- MySQL
- JSON Web Tokens (jsonwebtoken)
- bcryptjs
- Zod (validación)
- HTML, CSS y JavaScript
- Patrón Repository para acceso a datos

## 2. Estructura del proyecto

src/
├─ app.js
├─ bd/
│ └─ mysql.js
├─ controllers/
│ ├─ auth.controller.js
│ └─ cliente.controller.js
├─ services/
│ ├─ auth.service.js
│ └─ cliente.service.js
├─ repositories/
│ └─ cliente.repository.js
├─ models/
│ └─ auth.model.js
├─ routes/
│ ├─ auth.routes.js
│ ├─ clientes.routes.js
│ └─ index.js
├─ middlewares/
│ ├─ errorHandler.js
│ └─ notFound.js
└─ public/
├─ index.html
└─ js/
└─ auth.js

## 3. Requisitos del sistema

- Node.js 16+
- MySQL
- npm
- Archivo `.env` configurado correctamente


## 4. Variables de entorno (.env)

Crear un archivo `.env` en la raíz:

JWT_SECRET=tu_secreto_seguro
JWT_EXPIRES_IN=1h

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=
DB_NAME=la_jicara
DB_PORT=3306

## 5. Instalación del proyecto

### 5.1 Clonar el repositorio
git clone https://github.com/Gaeletor/La-jicara-auth

cd la-jicara

### 5.2 Instalar dependencias
npm install


### 5.3 Crear la tabla `clientes` en MySQL

```sql
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  activo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

6. Ejecutar servidor
npm start

Acceso desde navegador:

http://localhost:3000/

7. Frontend (Registro y Login)

El frontend se encuentra en:

src/public/index.html
src/public/js/auth.js


Características:

Registro de cliente

Inicio de sesión

Mensajes de confirmación y error

Acceso en navegador:

http://localhost:3000/

8. Endpoints principales
8.1 Registro

POST /api/auth/register

Ejemplo de cuerpo:

{
  "nombre": "Fernando Gael Estrada Velasco",
  "email": "correo@ejemplo.com",
  "password": "123456"
}

Respuesta:

{
  "message": "Cuenta creada",
  "cliente": {
    "id": 1,
    "nombre": "Fernando Gael Estrada Velasco",
    "email": "correo@ejemplo.com"
  }
}

8.2 Inicio de sesión

POST /api/auth/login

Cuerpo:

{
  "email": "correo@ejemplo.com",
  "password": "123456"
}

Respuesta:

{
  "token": "token_jwt_generado",
  "user": {
    "id": 1,
    "nombre": "Fernando Gael Estrada Velasco",
    "email": "correo@ejemplo.com"
  }
}

9. Seguridad

Contraseñas encriptadas con bcryptjs.

Tokens JWT para manejo de sesiones.

Validaciones estrictas con Zod.

No se expone password_hash.

Separación clara: Controller → Service → Repository.

10. Autor

Fernando Gael Estrada Velasco
Proyecto eBusiness "La Jícara"
Instituto Tecnológico de Tuxtla Gutiérrez

11. Notas finales

Este proyecto es completamente portable.
En cualquier máquina:

Clonar repositorio

Configurar .env

Instalar dependencias

Crear tabla clientes

Ejecutar npm start

El sistema funcionará sin modificaciones adicionales.