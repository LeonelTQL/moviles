import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/delivery_viewmodel.dart';
import '../../viewmodels/order_viewmodel.dart';
import '../../widgets/order_status_badge.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({super.key});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  String? orderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderId ??= ModalRoute.of(context)!.settings.arguments as String?;
    if (orderId != null) {
      Future.microtask(() async {
        await context.read<OrderViewModel>().loadOrder(orderId!);
        await context.read<DeliveryViewModel>().loadLatestLocation(orderId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderVm = context.watch<OrderViewModel>();
    final deliveryVm = context.watch<DeliveryViewModel>();
    final order = orderVm.selectedOrder;
    final location = deliveryVm.latest;

    return Scaffold(
      appBar: AppBar(title: const Text('Seguimiento')),
      body: orderVm.loading || order == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pedido ${order.id.substring(0, 8)}', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      OrderStatusBadge(status: order.status),
                      Text('Total: \$${order.total.toStringAsFixed(2)}'),
                      Text('Dirección: ${order.addressLine ?? 'Sin dirección'}'),
                      Text('Repartidor: ${order.riderName ?? 'Aún no asignado'}'),
                    ],
                  ),
                ),
                Expanded(
                  child: location == null
                      ? const Center(child: Text('Aún no hay ubicación del repartidor.'))
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: 16),
                          markers: {
                            Marker(markerId: const MarkerId('rider'), position: LatLng(location.latitude, location.longitude), infoWindow: const InfoWindow(title: 'Repartidor')),
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton.icon(
                    onPressed: () async => context.read<DeliveryViewModel>().loadLatestLocation(order.id),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Actualizar ubicación'),
                  ),
                ),
              ],
            ),
    );
  }
}
