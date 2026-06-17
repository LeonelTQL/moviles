import 'plato.dart';

class PedidoDetalle {
  final int? id;
  final Plato plato;
  final int cantidad;
  final double subtotal;

  PedidoDetalle({
    this.id,
    required this.plato,
    required this.cantidad,
    required this.subtotal,
  });
}
