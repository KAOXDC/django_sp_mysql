CREATE TABLE IF NOT EXISTS producto (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(120) NOT NULL,
  precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
  stock INT NOT NULL DEFAULT 0,
  creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Crear producto (INSERT)
CREATE OR REPLACE FUNCTION sp_producto_create(
  p_nombre VARCHAR(120),
  p_precio DECIMAL(10,2),
  p_stock INT
)
RETURNS INTEGER AS $$
DECLARE
  new_id INTEGER;
BEGIN
  INSERT INTO producto(nombre, precio, stock)
  VALUES (p_nombre, p_precio, p_stock)
  RETURNING id INTO new_id;
  RETURN new_id;
END;
$$ LANGUAGE plpgsql;


-- Obtener un producto por ID (SELECT)
CREATE OR REPLACE FUNCTION sp_producto_get(
  p_id INT
)
RETURNS TABLE(id INT, nombre VARCHAR, precio DECIMAL, stock INT, creado_en TIMESTAMP) AS $$
BEGIN
  RETURN QUERY
  SELECT id, nombre, precio, stock, creado_en
  FROM producto
  WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;


-- Listar todos los productos (SELECT)
CREATE OR REPLACE FUNCTION sp_producto_list()
RETURNS TABLE(id INT, nombre VARCHAR, precio DECIMAL, stock INT, creado_en TIMESTAMP) AS $$
BEGIN
  RETURN QUERY
  SELECT id, nombre, precio, stock, creado_en
  FROM producto
  ORDER BY id DESC;
END;
$$ LANGUAGE plpgsql;


-- Actualizar producto (UPDATE)
CREATE OR REPLACE FUNCTION sp_producto_update(
  p_id INT,
  p_nombre VARCHAR(120),
  p_precio DECIMAL(10,2),
  p_stock INT
)
RETURNS INTEGER AS $$
DECLARE
  rows_updated INTEGER;
BEGIN
  UPDATE producto
  SET nombre = p_nombre,
      precio = p_precio,
      stock = p_stock
  WHERE id = p_id
  RETURNING COUNT(*) INTO rows_updated;
  RETURN rows_updated;
END;
$$ LANGUAGE plpgsql;


-- Eliminar producto (DELETE)
CREATE OR REPLACE FUNCTION sp_producto_delete(
  p_id INT
)
RETURNS INTEGER AS $$
DECLARE
  rows_deleted INTEGER;
BEGIN
  DELETE FROM producto WHERE id = p_id
  RETURNING COUNT(*) INTO rows_deleted;
  RETURN rows_deleted;
END;
$$ LANGUAGE plpgsql;


