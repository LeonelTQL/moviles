import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../routes/app_routes.dart';

class PedidoSummaryPage extends StatelessWidget {
  const PedidoSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Detalles de la Entrega', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Cliente: ${vm.currentCart.isEmpty ? "N/A" : "Cliente"}', style: const TextStyle(fontSize: 16)), // Need to store client in VM properly
            const SizedBox(height: 20),
            const Text('Productos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: vm.currentCart.length,
                itemBuilder: (context, index) {
                  final item = vm.currentCart[index];
                  return ListTile(
                    title: Text(item.plato.nombre),
                    trailing: Text('\$${item.subtotal.toStringAsFixed(2)}'),
                    subtitle: Text('Cantidad: ${item.cantidad}'),
                  );
                },
              ),
            ),
            const Divider(thickness: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('TOTAL:', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text('\$${vm.cartTotal.toStringAsFixed(2)}', 
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await vm.confirmPedido();
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('¡Pedido Exitoso!'),
                          content: const Text('Su pedido ha sido registrado correctamente.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                },
                child: const Text('CONFIRMAR Y PAGAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
