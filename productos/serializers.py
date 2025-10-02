from rest_framework import serializers

class ProductoCreateUpdateSerializer(serializers.Serializer):
    nombre = serializers.CharField(max_length=120)
    precio = serializers.DecimalField(max_digits=10, decimal_places=2)
    stock = serializers.IntegerField(min_value=0)

class ProductoSerializer(serializers.Serializer):
    id = serializers.IntegerField()
    nombre = serializers.CharField(max_length=120)
    precio = serializers.DecimalField(max_digits=10, decimal_places=2)
    stock = serializers.IntegerField()
    creado_en = serializers.DateTimeField()
