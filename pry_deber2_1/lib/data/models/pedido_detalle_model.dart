import '../../domain/entities/pedido_detalle.dart';
import '../../domain/entities/plato.dart';

class PedidoDetalleModel extends PedidoDetalle {
  PedidoDetalleModel({
    super.id,
    required super.plato,
    required super.cantidad,
    required super.subtotal,
  });

  factory PedidoDetalleModel.fromJson(Map<String, dynamic> json) {
    return PedidoDetalleModel(
      id: json['id'],
      plato: Plato(
        id: json['plato_id'] ?? 0,
        // Priorizamos 'nombre_plato' (de la DB) o el 'nombre' (si viene del objeto plato)
        nombre: json['nombre_plato']?.toString() ?? 
                json['plato']?['nombre']?.toString() ?? 
                'Plato',
        descripcion: '',
        precio: double.tryParse(json['precio_unitario']?.toString() ?? '0') ?? 0.0,
        disponible: true,
        imagenUrl: '',
      ),
      cantidad: json['cantidad'] ?? 0,
      subtotal: double.tryParse(json['subtotal']?.toString() ?? '0') ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plato_id': plato.id,
      'cantidad': cantidad,
    };
  }
}
