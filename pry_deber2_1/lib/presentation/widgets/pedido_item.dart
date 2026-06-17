import 'package:flutter/material.dart';
import '../../domain/entities/pedido.dart';
import '../../themes/tipografia.dart';
import '../../themes/tema_fondos.dart';

class PedidoItem extends StatelessWidget {
  final Pedido pedido;
  final VoidCallback onDelete;

  const PedidoItem({
    super.key,
    required this.pedido,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaFondos.tarjeta,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Pedido #${pedido.id ?? '---'}', style: Tipografia.tituloMediano),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
            ],
          ),
          const Divider(),
          Text('Cliente: ${pedido.cliente}', style: Tipografia.cuerpo),
          Text('Fecha: ${pedido.fecha.day}/${pedido.fecha.month}/${pedido.fecha.year}', style: Tipografia.cuerpo),
          const SizedBox(height: 8),
          Text('Items:', style: const TextStyle(fontWeight: FontWeight.bold)),
          ...pedido.detalles.map((d) => Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('• ${d.plato.nombre} x${d.cantidad} - \$${d.subtotal.toStringAsFixed(2)}'),
          )),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total:', style: Tipografia.tituloMediano),
              Text('\$${pedido.total.toStringAsFixed(2)}', style: Tipografia.precio),
            ],
          ),
        ],
      ),
    );
  }
}
