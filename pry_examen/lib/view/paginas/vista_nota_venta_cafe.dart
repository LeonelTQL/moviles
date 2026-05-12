import 'package:flutter/material.dart';
import '../../model/pedido_cafe_modelo.dart';
import '../moleculas/resumen_nota_venta.dart';
import '../atomos/boton_principal.dart';

class VistaNotaVentaCafe extends StatelessWidget {
  const VistaNotaVentaCafe({super.key});

  @override
  Widget build(BuildContext context) {
    final PedidoCafeModelo pedido = ModalRoute.of(context)!.settings.arguments as PedidoCafeModelo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen de Compra'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ResumenNotaVenta(pedido: pedido),
            const Spacer(),
            BotonPrincipal(
              texto: 'Regresar',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
