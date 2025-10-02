from django.db import models

class Producto(models.Model):
    id = models.AutoField(primary_key=True)
    nombre = models.CharField(max_length=120)
    precio = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.IntegerField()
    creado_en = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'producto'
