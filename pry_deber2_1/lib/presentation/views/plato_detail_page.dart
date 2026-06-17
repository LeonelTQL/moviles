import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/plato.dart';
import '../viewmodels/plato_viewmodel.dart';
import '../viewmodels/pedido_viewmodel.dart';
import '../routes/app_routes.dart';
import '../../themes/tipografia.dart';

class PlatoDetailPage extends StatelessWidget {
  final Plato plato;

  const PlatoDetailPage({super.key, required this.plato});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plato.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pushNamed(
              context, 
              AppRoutes.platoForm, 
              arguments: plato
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'plato-${plato.id}',
              child: Image.network(
                plato.imagenUrl.isNotEmpty ? plato.imagenUrl : 'https://via.placeholder.com/300',
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.fastfood, size: 100),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: Text(plato.nombre, style: Tipografia.tituloGrande)),
                      Text('\$${plato.precio.toStringAsFixed(2)}', style: Tipografia.precio.copyWith(fontSize: 22)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    label: Text(plato.disponible ? 'DISPONIBLE' : 'AGOTADO'),
                    backgroundColor: plato.disponible ? Colors.green[100] : Colors.red[100],
                    labelStyle: TextStyle(color: plato.disponible ? Colors.green[800] : Colors.red[800], fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text('Descripción', style: Tipografia.tituloMediano),
                  const SizedBox(height: 8),
                  Text(plato.descripcion, style: Tipografia.cuerpo.copyWith(fontSize: 16)),
                  const SizedBox(height: 30),
                  if (plato.disponible)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<PedidoViewModel>().addToCart(plato, 1);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${plato.nombre} añadido al pedido')),
                          );
                        },
                        child: const Text('AÑADIR AL PEDIDO'),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar Plato'),
        content: Text('¿Está seguro de eliminar "${plato.nombre}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCELAR')),
          TextButton(
            onPressed: () async {
              try {
                await context.read<PlatoViewModel>().removePlato(plato.id!);
                Navigator.pop(ctx); // Close dialog
                Navigator.pop(context); // Go back from detail
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
              }
            },
            child: const Text('ELIMINAR', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
