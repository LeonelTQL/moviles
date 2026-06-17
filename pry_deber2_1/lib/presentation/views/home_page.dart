import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/plato_viewmodel.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../widgets/plato_card.dart';
import '../routes/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlatoViewModel>().fetchPlatos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.pedidos),
          ),
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.platoForm),
          ),
        ],
      ),
      body: Consumer<PlatoViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) return const Center(child: CircularProgressIndicator());
          if (vm.error != null) return Center(child: Text('Error: ${vm.error}'));
          if (vm.platos.isEmpty) return const Center(child: Text('No hay platos disponibles.'));

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: vm.platos.length,
            itemBuilder: (context, index) {
              final plato = vm.platos[index];
              return PlatoCard(
                plato: plato,
                onTap: () => Navigator.pushNamed(context, AppRoutes.platoDetail, arguments: plato),
                onAdd: () {
                  context.read<PedidoViewModel>().addToCart(plato, 1);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${plato.nombre} añadido al pedido')),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<PedidoViewModel>(
        builder: (context, pedidoVm, child) {
          if (pedidoVm.currentCart.isEmpty) return const SizedBox.shrink();
          return FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.pedidoForm),
            label: Text('Ver Pedido (${pedidoVm.currentCart.length})'),
            icon: const Icon(Icons.shopping_basket),
            backgroundColor: Colors.deepOrange,
          );
        },
      ),
    );
  }
}
