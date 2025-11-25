-- =========================================================
-- creación de base y tabla "clientes"
-- Compatible con MySQL 8.x y MariaDB
-- =========================================================

-- 1) Crear base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS `La_jicara`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

-- 2) Usar la base
USE `La_jicara`;

-- 3) Crear tabla clientes (si no existe)
CREATE TABLE IF NOT EXISTS `clientes` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(120) NOT NULL,
  `email` VARCHAR(160) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_clientes_email` (`email`),
  KEY `idx_clientes_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


INSERT INTO `clientes` (nombre, email, password_hash, activo)
VALUES (
  'Cliente Demo',
  'demo@example.com',
  '$2b$10$uxN3uzuoAwWGEGjcDyR4h..JaW0iopIO2FZ19G8CtSzoqh2NmWUYW',
  1
);
CREATE TABLE IF NOT EXISTS `carrito` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cliente_id` BIGINT UNSIGNED NOT NULL,
  `estado` ENUM('activo','pagado','abandonado') NOT NULL DEFAULT 'activo',
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_carrito_cliente` (`cliente_id`),
  CONSTRAINT `fk_carrito_cliente`
    FOREIGN KEY (`cliente_id`) REFERENCES `clientes`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `categoria_productos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(40) NOT NULL,
  `descripcion` VARCHAR(120) DEFAULT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `productos` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `categoria_id` BIGINT UNSIGNED NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `descripcion` VARCHAR(150) DEFAULT NULL,
  `precio` DECIMAL(8,2) NOT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `imagen_url` VARCHAR(120) DEFAULT NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_productos_categoria` (`categoria_id`),
  CONSTRAINT `fk_productos_categoria`
    FOREIGN KEY (`categoria_id`) REFERENCES `categoria_productos`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `carrito_detalle` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `carrito_id` BIGINT UNSIGNED NOT NULL,
  `producto_id` BIGINT UNSIGNED NOT NULL,
  `cantidad` INT NOT NULL DEFAULT 1,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  CONSTRAINT `fk_detalle_carrito`
    FOREIGN KEY (`carrito_id`) REFERENCES `carrito`(`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT `fk_detalle_producto`
    FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SHOW TABLES;