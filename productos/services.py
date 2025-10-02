from django.db import connection, DatabaseError

def sp_producto_create(nombre: str, precio, stock: int):
    try:
        with connection.cursor() as cursor:
            cursor.callproc('sp_producto_create', [nombre, precio, stock])
            row = cursor.fetchone()
            return int(row[0]) if row else None
    except DatabaseError as e:
        raise

def sp_producto_get(pid: int):
    with connection.cursor() as cursor:
        cursor.callproc('sp_producto_get', [pid])
        row = cursor.fetchone()
        if not row:
            return None
        return {
            "id": row[0],
            "nombre": row[1],
            "precio": row[2],
            "stock": row[3],
            "creado_en": row[4],
        }

def sp_producto_list():
    with connection.cursor() as cursor:
        cursor.callproc('sp_producto_list')
        rows = cursor.fetchall()
        return [
            {
                "id": r[0],
                "nombre": r[1],
                "precio": r[2],
                "stock": r[3],
                "creado_en": r[4],
            } for r in rows
        ]

def sp_producto_update(pid: int, nombre: str, precio, stock: int) -> int:
    with connection.cursor() as cursor:
        cursor.callproc('sp_producto_update', [pid, nombre, precio, stock])
        row = cursor.fetchone()
        return int(row[0]) if row else 0

def sp_producto_delete(pid: int) -> int:
    with connection.cursor() as cursor:
        cursor.callproc('sp_producto_delete', [pid])
        row = cursor.fetchone()
        return int(row[0]) if row else 0
