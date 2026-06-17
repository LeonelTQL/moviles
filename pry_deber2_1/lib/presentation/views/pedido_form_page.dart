import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../routes/app_routes.dart';

class PedidoFormPage extends StatefulWidget {
  const PedidoFormPage({super.key});

  @override
  State<PedidoFormPage> createState() => _PedidoFormPageState();
}

class _PedidoFormPageState extends State<PedidoFormPage> {
  final _clienteController = TextEditingController();

  @override
  void dispose() {
    _clienteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Pedido'),
      ),
      body: Consumer<PedidoViewModel>(
        builder: (context, vm, child) {
          if (vm.currentCart.isEmpty) {
            return const Center(
              child: Text('El carrito está vacío'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _clienteController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Cliente',
                    hintText: 'Ej. Juan Pérez',
                  ),
                  onChanged: (val) => vm.setCliente(val),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    itemCount: vm.currentCart.length,
                    itemBuilder: (context, index) {
                      final item = vm.currentCart[index];

                      return ListTile(
                        leading: IconButton(
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.red,
                          ),
                          onPressed: () => vm.removeFromCart(item.plato.id!),
                        ),
                        title: Text(item.plato.nombre),
                        subtitle: Text(
                          'Cantidad: ${item.cantidad} x \$${item.plato.precio.toStringAsFixed(2)}',
                        ),
                        trailing: Text(
                          '\$${item.subtotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Divider(thickness: 2),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total a pagar:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${vm.cartTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: vm.currentCart.isEmpty ||
                        _clienteController.text.trim().isEmpty
                        ? null
                        : () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.pedidoSummary,
                      );
                    },
                    child: const Text('REVISAR RESUMEN'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}