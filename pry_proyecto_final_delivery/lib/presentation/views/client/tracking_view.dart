import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../../themes/esquema_color.dart';
import '../../viewmodels/delivery_viewmodel.dart';
import '../../viewmodels/maps_viewmodel.dart';
import '../../viewmodels/order_viewmodel.dart';
import '../../widgets/order_status_badge.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({super.key});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  String? orderId;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderId ??= ModalRoute.of(context)!.settings.arguments as String?;
    if (!_loaded && orderId != null) {
      _loaded = true;
      Future.microtask(_loadData);
    }
  }

  Future<void> _loadData() async {
    final orderVm = context.read<OrderViewModel>();
    final deliveryVm = context.read<DeliveryViewModel>();
    final mapsVm = context.read<MapsViewModel>();

    await orderVm.loadOrder(orderId!);
    await deliveryVm.loadLatestLocation(orderId!);

    final order = orderVm.selectedOrder;
    final location = deliveryVm.latest;
    if (order?.latitude != null && order?.longitude != null && location != null) {
      await mapsVm.loadRoute(
        originLat: location.latitude,
        originLng: location.longitude,
        destinationLat: order!.latitude!,
        destinationLng: order.longitude!,
        travelMode: 'DRIVE',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderVm = context.watch<OrderViewModel>();
    final deliveryVm = context.watch<DeliveryViewModel>();
    final mapsVm = context.watch<MapsViewModel>();
    final order = orderVm.selectedOrder;
    final location = deliveryVm.latest;
    final route = mapsVm.activeRoute;

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
                      const SizedBox(height: 8),
                      Text('Total: \$${order.total.toStringAsFixed(2)}'),
                      Text('Dirección: ${order.addressLine ?? 'Sin dirección'}'),
                      Text('Repartidor: ${order.riderName ?? 'Aún no asignado'}'),
                      if (route != null) Text('Ruta: ${route.distanceLabel} · ${route.durationLabel}'),
                      if (mapsVm.error != null) Text(mapsVm.error!, style: const TextStyle(color: EsquemaColor.danger)),
                    ],
                  ),
                ),
                Expanded(
                  child: location == null
                      ? const Center(child: Text('Aún no hay ubicación del repartidor.'))
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(target: LatLng(location.latitude, location.longitude), zoom: 15),
                          myLocationButtonEnabled: false,
                          markers: {
                            Marker(
                              markerId: const MarkerId('rider'),
                              position: LatLng(location.latitude, location.longitude),
                              infoWindow: const InfoWindow(title: 'Repartidor'),
                            ),
                            if (order.latitude != null && order.longitude != null)
                              Marker(
                                markerId: const MarkerId('destination'),
                                position: LatLng(order.latitude!, order.longitude!),
                                infoWindow: const InfoWindow(title: 'Entrega'),
                              ),
                          },
                          polylines: {
                            if (route != null && route.points.isNotEmpty)
                              Polyline(
                                polylineId: const PolylineId('delivery_route'),
                                points: route.points.map((point) => LatLng(point.latitude, point.longitude)).toList(),
                                width: 6,
                                color: EsquemaColor.primary,
                              ),
                            if ((route == null || route.points.isEmpty) && order.latitude != null && order.longitude != null)
                              Polyline(
                                polylineId: const PolylineId('direct_route'),
                                points: [LatLng(location.latitude, location.longitude), LatLng(order.latitude!, order.longitude!)],
                                width: 4,
                                color: EsquemaColor.muted,
                              ),
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: OutlinedButton.icon(
                    onPressed: _loadData,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Actualizar ubicación'),
                  ),
                ),
              ],
            ),
    );
  }
}
