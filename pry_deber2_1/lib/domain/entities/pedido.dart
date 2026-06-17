import 'pedido_detalle.dart';

class Pedido {
  final int? id;
  final String cliente;
  final DateTime fecha;
  final List<PedidoDetalle> detalles;
  final double total;

  Pedido({
    this.id,
    required this.cliente,
    required this.fecha,
    required this.detalles,
    required this.total,
  });
}
