# La Jícara – API de e-commerce 

Este proyecto es el backend de **La Jícara**, una tienda en línea de pozol, cacao, entradas a eventos culturales y suvenires típicos de Chiapas.

La API está construida con **Node.js + Express**, organizada por capas (rutas, controladores, servicios y repositorios) y expone endpoints para:

- Registrar y autenticar **clientes**.
- Administrar **categorías** y **productos** desde un panel de administración.
- Gestionar **carritos de compra**, **pedidos** y **pagos** (a nivel de base de datos).
- Proteger recursos mediante **JWT** y sistema de **roles** (`ADMIN`, `CLIENTE`).

---

## 1. Tecnologías utilizadas

- Node.js (módulos ES)
- Express 5
- `mysql2/promise` (pool de conexiones y queries parametrizadas)
- Zod (validación de datos de entrada)
- bcrypt / bcryptjs (hash de contraseñas)
- JSON Web Token (`jsonwebtoken`)
- Nodemon (recarga en desarrollo)

Base de datos:

- MySQL 8.x / MariaDB compatible

---

## 2. Arquitectura del proyecto

Estructura general de carpetas:

```text
src/
  app.js
  server.js

  routes/
    index.js
    auth.routes.js
    clientes.routes.js
    categorias.routes.js
    productos.routes.js

  controllers/
    auth.controller.js
    cliente.controller.js
    categoria.controller.js
    producto.controller.js

  services/
    auth.service.js
    cliente.service.js
    categoria.service.js
    producto.service.js

  repositories/
    cliente.repository.js
    categoria.repository.js
    producto.repository.js

  models/
    auth.model.js
    cliente.model.js
    categoria.model.js
    producto.model.js

  middlewares/
    auth.js
    errorHandler.js
    notFound.js

  utils/
    db.js                # pool de conexión a MySQL

  bd/
    la_jicara.sql        # script completo de la base de datos

public/
  index.html             # login / registro contra la API
  styles.css
  app.js

  admin.html             # panel admin (clientes / categorías / productos)
  admin.css
  admin.js

  img/
    la-jicara-logo.png

.env                      # variables de entorno (no se versiona)
3. Base de datos la_jicara
El script SQL principal está en:

text
Copiar código
src/bd/la_jicara.sql
Al ejecutarlo se crea la base de datos la_jicara y las tablas necesarias:

clientes

roles

cliente_roles

direcciones

categorias

productos

carritos

carrito_items

pedidos

pedido_items

pagos

Algunos puntos importantes:

Se generan dos roles básicos: ADMIN y CLIENTE.

Se inserta un usuario administrador:

txt
Copiar código
email: admin@lajicara.com
password: 12345678        # (la contraseña real está hasheada en la BD)
Se deja lista la estructura para:

guardar múltiples direcciones por cliente,

manejar carritos activos,

convertir un carrito en pedido,

registrar pagos asociados a un pedido.

Cómo ejecutar el script
Opción 1 – CLI de MySQL

bash
Copiar código
mysql -u <USUARIO> -p < ./src/bd/la_jicara.sql
Opción 2 – Workbench / HeidiSQL

Abrir la conexión a tu servidor MySQL.

Cargar el archivo src/bd/la_jicara.sql.

Ejecutar todo el script.

Al terminar deberías ver la BD la_jicara con todas las tablas anteriores y el admin creado.

4. Archivo .env
En la raíz del proyecto crea un archivo llamado .env con algo como:

env
Copiar código
# Servidor HTTP
PORT=3000

# Conexión MySQL
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=TU_PASSWORD
MYSQL_DB=la_jicara
MYSQL_CONN_LIMIT=10

# JWT
JWT_SECRET=ALGO_LARGO_Y_ALEATORIO_AQUI
JWT_EXPIRES_IN=1h
No subas este archivo al repositorio remoto.

5. Instalación y ejecución
5.1. Instalar dependencias
bash
Copiar código
npm install
5.2. Ejecutar en modo desarrollo
bash
Copiar código
npm run dev
Por defecto la API queda escuchando en:

text
Copiar código
http://localhost:3000
5.3. Ejecutar sin nodemon
bash
Copiar código
npm start
# o
node src/server.js
6. Rutas principales de la API
Todas las rutas de la API están colgadas bajo /api.

6.1. Salud del servicio
GET /

GET /api/health

Devuelven un JSON simple para saber que el backend está vivo.

6.2. Autenticación
POST /api/auth/login
Recibe email + contraseña y devuelve un JWT junto con los datos básicos del usuario.

Ejemplo de body:

json
Copiar código
{
  "email": "admin@lajicara.com",
  "password": "12345678"
}
Respuesta típica:

json
Copiar código
{
  "token": "JWT_AQUI",
  "user": {
    "id": 1,
    "nombre": "Admin jicara",
    "email": "admin@lajicara.com",
    "roles": ["ADMIN"]
  }
}
En las rutas protegidas se envía el token así:

http
Copiar código
Authorization: Bearer JWT_AQUI
6.3. Clientes
Endpoints para administrar clientes (crear, listar, actualizar, borrar).
Las rutas están bajo /api/clientes y protegidas con JWT.

Ejemplos:

GET /api/clientes – lista de clientes.

GET /api/clientes/:id – detalle de un cliente.

POST /api/clientes – alta de cliente.

PATCH /api/clientes/:id – actualización parcial.

DELETE /api/clientes/:id – eliminación / baja.

6.4. Categorías
Catálogo de categorías (categorias) usado para agrupar productos
(solubles, eventos, suvenires, etc.).
Rutas bajo /api/categorias.

GET /api/categorias

GET /api/categorias/:id

POST /api/categorias

PATCH /api/categorias/:id

DELETE /api/categorias/:id

6.5. Productos
CRUD de productos (productos) asociados a una categoría.

Rutas bajo /api/productos:

GET /api/productos

GET /api/productos/:id

POST /api/productos

PATCH /api/productos/:id

DELETE /api/productos/:id

La tabla tiene campos como:

categoria_id

nombre

descripcion

precio

stock

url_imagen

flags opcionales (es_vegano, es_sin_gluten, etc.)

7. Panel de administración (/admin)
El proyecto incluye un pequeño frontend estático dentro de public/:

GET / → public/index.html
Pantalla de login / registro para clientes y admins.

GET /admin → public/admin.html
Panel donde un usuario con rol ADMIN puede:

ver y administrar clientes,

manejar categorías,

crear / editar / eliminar productos.

El frontend usa localStorage para almacenar el token y los datos del usuario y se comunica con la API vía fetch sobre /api/....

8. Notas finales
El proyecto está pensado como base para seguir creciendo (ej. terminar los endpoints de carrito, pedidos y pagos).

El código y la base de datos están orientados a un contexto real de e-commerce local (La Jícara), pero sirven también como plantilla para otros proyectos similares.

Proyecto desarrollado como parte de prácticas de backend por
Gael Estrada Velasco.