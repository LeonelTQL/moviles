import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../routes/app_routes.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../viewmodels/delivery_viewmodel.dart';
import '../../viewmodels/order_viewmodel.dart';
import '../../widgets/order_status_badge.dart';

class DeliveryOrdersView extends StatefulWidget {
  const DeliveryOrdersView({super.key});

  @override
  State<DeliveryOrdersView> createState() => _DeliveryOrdersViewState();
}

class _DeliveryOrdersViewState extends State<DeliveryOrdersView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OrderViewModel>().loadDeliveryOrders());
  }

  @override
  Widget build(BuildContext context) {
    final ordersVm = context.watch<OrderViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis entregas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await context.read<AuthViewModel>().logout();
              if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
            },
          )
        ],
      ),
      body: ordersVm.loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => ordersVm.loadDeliveryOrders(),
              child: ordersVm.orders.isEmpty
                  ? const Center(child: Text('No hay pedidos asignados.'))
                  : ListView.builder(
                      itemCount: ordersVm.orders.length,
                      itemBuilder: (_, index) {
                        final order = ordersVm.orders[index];
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Pedido ${order.id.substring(0, 8)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('Cliente: ${order.customerName ?? 'N/D'}'),
                                Text('Dirección: ${order.addressLine ?? 'N/D'}'),
                                Text('Total: \$${order.total.toStringAsFixed(2)}'),
                                OrderStatusBadge(status: order.status),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    OutlinedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.deliveryMap, arguments: order.id), child: const Text('Mapa/GPS')),
                                    OutlinedButton(
                                      onPressed: () async {
                                        await context.read<OrderViewModel>().updateStatus(order.id, 'en_camino');
                                        await context.read<OrderViewModel>().loadDeliveryOrders();
                                      },
                                      child: const Text('En camino'),
                                    ),
                                    OutlinedButton(
                                      onPressed: () async {
                                        await context.read<DeliveryViewModel>().sendCurrentLocation(order.id);
                                        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ubicación enviada')));
                                      },
                                      child: const Text('Enviar GPS'),
                                    ),
                                    ElevatedButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.deliveryProof, arguments: order.id), child: const Text('Comprobante')),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
