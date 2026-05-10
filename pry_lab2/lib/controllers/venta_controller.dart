import '../models/venta_model.dart';
import '../models/producto_model.dart';

class VentaController {

  Map<String, String> procesarTransaccion({
    required String nombreVendedor,
    required String nombreCliente,
    required List<Map<String, dynamic>> listaProductosAnadidos,
  }) {
    if (nombreVendedor.isEmpty || nombreCliente.isEmpty) {
      return {'error': "Falta el nombre del vendedor o cliente."};
    }

    if (listaProductosAnadidos.isEmpty) {
      return {'error': "Debe agregar al menos un producto a la venta."};
    }

    List<ProductoModel> productos = listaProductosAnadidos.map((prod) {
      return ProductoModel(
        nombre: prod['nombre'],
        precio: prod['precio'],
        cantidad: prod['cantidad'],
      );
    }).toList();

    final modelo = VentaModel(
      cliente: nombreCliente,
      vendedor: nombreVendedor,
      productos: productos,
    );


    String detalleProductos = "";
    for (var p in modelo.productos) {
      detalleProductos += "- ${p.cantidad}x ${p.nombre} (\$${p.precio}) = \$${p.total.toStringAsFixed(2)}\n";
    }

    String facturaText = '''
Cliente: ${modelo.cliente}

Detalle de Compra:
$detalleProductos
-----------------------------------
Subtotal (Bruto): \$${modelo.calcularSubtotalBruto().toStringAsFixed(2)}
Descuento (20%): -\$${modelo.calcularDescuento().toStringAsFixed(2)}
Subtotal Neto: \$${modelo.calcularSubtotalNeto().toStringAsFixed(2)}
IVA (15%): +\$${modelo.calcularIva().toStringAsFixed(2)}
-----------------------------------
TOTAL A PAGAR: \$${modelo.calcularTotalFactura().toStringAsFixed(2)}
''';

    String sueldoText = '''
Vendedor: ${modelo.vendedor}
Total Vendido: \$${modelo.calcularSubtotalBruto().toStringAsFixed(2)}

Sueldo Base: \$${modelo.sueldoBaseVendedor.toStringAsFixed(2)}
Comisión (10%): +\$${modelo.calcularComision().toStringAsFixed(2)}
-----------------------------------
SUELDO TOTAL: \$${modelo.calcularSueldoFinal().toStringAsFixed(2)}
''';

    return {
      'factura': facturaText,
      'sueldo': sueldoText,
    };
  }
}