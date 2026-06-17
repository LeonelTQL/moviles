import 'package:flutter/material.dart';
import '../../domain/entities/plato.dart';
import '../../themes/tipografia.dart';
import '../../themes/tema_fondos.dart';

class PlatoCard extends StatelessWidget {
  final Plato plato;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  const PlatoCard({
    super.key,
    required this.plato,
    required this.onTap,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: TemaFondos.tarjeta,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  plato.imagenUrl.isNotEmpty 
                    ? plato.imagenUrl 
                    : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(plato.nombre, style: Tipografia.tituloMediano, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text('\$${plato.precio.toStringAsFixed(2)}', style: Tipografia.precio),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plato.disponible ? 'Disponible' : 'Agotado',
                        style: TextStyle(
                          color: plato.disponible ? Colors.green : Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (plato.disponible)
                        IconButton(
                          icon: const Icon(Icons.add_shopping_cart, color: Colors.deepOrange),
                          onPressed: onAdd,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
