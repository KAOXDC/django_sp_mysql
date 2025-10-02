-- Crear base y tabla
CREATE DATABASE IF NOT EXISTS tienda CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE tienda;

CREATE TABLE IF NOT EXISTS producto (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock INT NOT NULL DEFAULT 0,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

-- CREATE
DROP PROCEDURE IF EXISTS sp_producto_create $$
CREATE PROCEDURE sp_producto_create(
  IN p_nombre VARCHAR(120),
  IN p_precio DECIMAL(10,2),
  IN p_stock INT
)
BEGIN
  INSERT INTO producto(nombre, precio, stock)
  VALUES (p_nombre, p_precio, p_stock);
  SELECT LAST_INSERT_ID() AS id;
END $$

-- READ (uno)
DROP PROCEDURE IF EXISTS sp_producto_get $$
CREATE PROCEDURE sp_producto_get(IN p_id INT)
BEGIN
  SELECT id, nombre, precio, stock, creado_en
  FROM producto
  WHERE id = p_id;
END $$

-- LIST (todos)
DROP PROCEDURE IF EXISTS sp_producto_list $$
CREATE PROCEDURE sp_producto_list()
BEGIN
  SELECT id, nombre, precio, stock, creado_en
  FROM producto
  ORDER BY id DESC;
END $$

-- UPDATE
DROP PROCEDURE IF EXISTS sp_producto_update $$
CREATE PROCEDURE sp_producto_update(
  IN p_id INT,
  IN p_nombre VARCHAR(120),
  IN p_precio DECIMAL(10,2),
  IN p_stock INT
)
BEGIN
  UPDATE producto
  SET nombre = p_nombre,
      precio = p_precio,
      stock = p_stock
  WHERE id = p_id;
  SELECT ROW_COUNT() AS filas;
END $$

-- DELETE
DROP PROCEDURE IF EXISTS sp_producto_delete $$
CREATE PROCEDURE sp_producto_delete(IN p_id INT)
BEGIN
  DELETE FROM producto WHERE id = p_id;
  SELECT ROW_COUNT() AS filas;
END $$

DELIMITER ;
