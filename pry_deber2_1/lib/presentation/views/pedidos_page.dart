import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../widgets/pedido_item.dart';

class PedidosPage extends StatefulWidget {
  const PedidosPage({super.key});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedidoViewModel>().fetchPedidos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Pedidos'),
      ),
      body: Consumer<PedidoViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());
          if (vm.error != null) return Center(child: Text('Error: ${vm.error}'));
          if (vm.pedidos.isEmpty) return const Center(child: Text('No has realizado pedidos aún.'));

          return ListView.builder(
            itemCount: vm.pedidos.length,
            itemBuilder: (context, index) {
              final pedido = vm.pedidos[index];
              return PedidoItem(
                pedido: pedido,
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Eliminar Pedido'),
                      content: const Text('¿Está seguro de eliminar este registro de pedido?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('CANCELAR')),
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('ELIMINAR', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    try {
                      await vm.removePedido(pedido.id!);
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
