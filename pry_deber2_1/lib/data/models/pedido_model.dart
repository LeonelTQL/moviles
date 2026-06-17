import '../../domain/entities/pedido.dart';
import 'pedido_detalle_model.dart';

class PedidoModel extends Pedido {
  PedidoModel({
    super.id,
    required super.cliente,
    required super.fecha,
    required super.detalles,
    required super.total,
  });

  factory PedidoModel.fromJson(Map<String, dynamic> json) {
    return PedidoModel(
      id: json['id'],
      cliente: json['cliente'],
      // Postgres might return date string
      fecha: DateTime.parse(json['fecha'].toString()),
      detalles: json['detalles'] != null
          ? (json['detalles'] as List)
              .map((d) => PedidoDetalleModel.fromJson(d))
              .toList()
          : [],
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    // This format is what the backend expects for creation: { cliente, platos: [...] }
    return {
      'cliente': cliente,
      'platos': detalles.map((d) {
        return {
          'plato_id': d.plato.id,
          'cantidad': d.cantidad,
        };
      }).toList(),
    };
  }
}
