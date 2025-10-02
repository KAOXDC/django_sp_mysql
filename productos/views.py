from rest_framework import status, viewsets
from rest_framework.response import Response
from .serializers import (
    ProductoCreateUpdateSerializer,
    ProductoSerializer
)
from .services import (
    sp_producto_create, sp_producto_get, sp_producto_list,
    sp_producto_update, sp_producto_delete
)

class ProductoViewSet(viewsets.ViewSet):
    """
    Endpoints:
    - GET    /api/productos/        -> list
    - GET    /api/productos/{id}/   -> retrieve
    - POST   /api/productos/        -> create
    - PUT    /api/productos/{id}/   -> update
    - DELETE /api/productos/{id}/   -> destroy
    """

    def list(self, request):
        data = sp_producto_list()
        return Response(data, status=status.HTTP_200_OK)

    def retrieve(self, request, pk=None):
        item = sp_producto_get(int(pk))
        if not item:
            return Response({"detail": "No encontrado"}, status=status.HTTP_404_NOT_FOUND)
        return Response(item, status=status.HTTP_200_OK)

    def create(self, request):
        serializer = ProductoCreateUpdateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        nuevo_id = sp_producto_create(**serializer.validated_data)
        item = sp_producto_get(nuevo_id)
        return Response(item, status=status.HTTP_201_CREATED)

    def update(self, request, pk=None):
        serializer = ProductoCreateUpdateSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        filas = sp_producto_update(int(pk), **serializer.validated_data)
        if filas == 0:
            return Response({"detail": "No encontrado"}, status=status.HTTP_404_NOT_FOUND)
        item = sp_producto_get(int(pk))
        return Response(item, status=status.HTTP_200_OK)

    def destroy(self, request, pk=None):
        filas = sp_producto_delete(int(pk))
        if filas == 0:
            return Response({"detail": "No encontrado"}, status=status.HTTP_404_NOT_FOUND)
        return Response(status=status.HTTP_204_NO_CONTENT)
