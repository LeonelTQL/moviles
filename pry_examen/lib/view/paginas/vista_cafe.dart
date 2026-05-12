import 'package:flutter/material.dart';
import '../../controller/cafe_controlador.dart';
import '../moleculas/formulario_pedido_cafe.dart';

class VistaCafe extends StatelessWidget {
  VistaCafe({super.key});

  final CafeControlador _controlador = CafeControlador();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedido de Café'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FormularioPedidoCafe(
          onProcesar: (cliente, producto, tamano, cantidad) {
            try {
              final pedido = _controlador.procesarPedido(
                cliente: cliente,
                producto: producto,
                tamano: tamano,
                cantidad: cantidad,
              );
              Navigator.pushNamed(
                context,
                '/notaVentaCafe',
                arguments: pedido,
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
              );
            }
          },
        ),
      ),
    );
  }
}
