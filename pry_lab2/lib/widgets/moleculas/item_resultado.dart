import 'package:flutter/material.dart';

class ItemResultado extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final IconData? icono;

  const ItemResultado({
    super.key,
    required this.etiqueta,
    required this.valor,
    this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icono != null) ...[
            Icon(icono, size: 20),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(
              etiqueta,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            valor,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
