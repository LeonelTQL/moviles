import 'package:flutter/material.dart';
import '../../model/pedido_cafe_modelo.dart';
import '../atomos/texto_etiqueta.dart';

class ResumenNotaVenta extends StatelessWidget {
  final PedidoCafeModelo pedido;

  const ResumenNotaVenta({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'NOTA DE VENTA',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            TextoEtiqueta(etiqueta: 'Cliente:', valor: pedido.cliente),
            TextoEtiqueta(etiqueta: 'Producto:', valor: pedido.producto),
            TextoEtiqueta(etiqueta: 'Tamaño:', valor: pedido.tamano),
            TextoEtiqueta(etiqueta: 'Cantidad:', valor: pedido.cantidad.toString()),
            const Divider(),
            TextoEtiqueta(etiqueta: 'Subtotal:', valor: '\$${pedido.subtotal.toStringAsFixed(2)}'),
            TextoEtiqueta(etiqueta: 'IVA (15%):', valor: '\$${pedido.iva.toStringAsFixed(2)}'),
            const Divider(),
            TextoEtiqueta(
              etiqueta: 'TOTAL A PAGAR:',
              valor: '\$${pedido.total.toStringAsFixed(2)}',
            ),
          ],
        ),
      ),
    );
  }
}
