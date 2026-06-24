import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/delivery_viewmodel.dart';

class DeliveryMapView extends StatefulWidget {
  const DeliveryMapView({super.key});

  @override
  State<DeliveryMapView> createState() => _DeliveryMapViewState();
}

class _DeliveryMapViewState extends State<DeliveryMapView> {
  String? orderId;
  LatLng? current;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderId ??= ModalRoute.of(context)!.settings.arguments as String?;
    Future.microtask(_loadPosition);
  }

  Future<void> _loadPosition() async {
    final pos = await context.read<DeliveryViewModel>().getCurrentPosition();
    if (pos == null || !mounted) return;
    setState(() => current = LatLng(pos.latitude, pos.longitude));
  }

  @override
  Widget build(BuildContext context) {
    final delivery = context.watch<DeliveryViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa del repartidor')),
      body: current == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(target: current!, zoom: 16),
                    myLocationEnabled: true,
                    markers: {Marker(markerId: const MarkerId('current'), position: current!, infoWindow: const InfoWindow(title: 'Mi ubicación'))},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: delivery.loading || orderId == null
                        ? null
                        : () async {
                            final ok = await context.read<DeliveryViewModel>().sendCurrentLocation(orderId!);
                            await _loadPosition();
                            if (context.mounted && ok) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ubicación enviada al cliente')));
                          },
                    icon: const Icon(Icons.my_location),
                    label: const Text('Enviar ubicación GPS'),
                  ),
                ),
              ],
            ),
    );
  }
}
