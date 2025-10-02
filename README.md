# Django + DRF + MySQL (Procedimientos Almacenados) — CRUD de `producto`

Proyecto de ejemplo que implementa un CRUD de `producto` usando **exclusivamente procedimientos almacenados en MySQL**.
El ORM de Django no se usa para las operaciones CRUD, solo para tipado con un modelo `managed=False`.

## Requisitos
- Python 3.10+ (3.11 recomendado)
- MySQL 8.x
- Paquetes Python (ver `requirements.txt`)

## Instalación
```bash
python -m venv venv
# Windows: venv\Scripts\activate
# Linux/Mac: source venv/bin/activate
pip install -r requirements.txt
```

**Opcional (si prefieres PyMySQL):**
- Instala `PyMySQL` y, en `backend/__init__.py`, agrega:
  ```python
  import pymysql
  pymysql.install_as_MySQLdb()
  ```

## Base de datos y SP
1. Crea la base, la tabla y los procedimientos ejecutando `schema.sql` en tu MySQL (Workbench, CLI o similar).
2. Credenciales por defecto esperadas en `settings.py`:
   - DB: `tienda`
   - USER: `tu_usuario`
   - PASSWORD: `tu_password`
   - HOST: `127.0.0.1`
   - PORT: `3306`

## Ejecutar el servidor
```bash
python manage.py migrate  # (no migrará la tabla 'producto' porque es managed=False, pero sí tablas de Django)
python manage.py runserver
```

## Endpoints
- `GET    /api/productos/`
- `GET    /api/productos/{id}/`
- `POST   /api/productos/`
- `PUT    /api/productos/{id}/`
- `DELETE /api/productos/{id}/`

## Ejemplos de requests
**Crear**
```http
POST http://127.0.0.1:8000/api/productos/
Content-Type: application/json

{
  "nombre": "Teclado Mecánico",
  "precio": 250000.00,
  "stock": 10
}
```

**Listar**
```http
GET http://127.0.0.1:8000/api/productos/
```

**Detalle**
```http
GET http://127.0.0.1:8000/api/productos/1/
```

**Actualizar**
```http
PUT http://127.0.0.1:8000/api/productos/1/
Content-Type: application/json

{
  "nombre": "Teclado Mecánico RGB",
  "precio": 280000.00,
  "stock": 12
}
```

**Eliminar**
```http
DELETE http://127.0.0.1:8000/api/productos/1/
```

## Notas
- El modelo `Producto` tiene `managed=False` para no generar migraciones sobre la tabla existente.
- La lógica de acceso a datos está en `productos/services.py` usando `cursor.callproc`.
- Considera usar `transaction.atomic()` donde requieras atomicidad explícita.
