import 'package:flutter/material.dart';
import '../atomos/atom_label.dart';

class OrgCotizacion extends StatelessWidget {
  final String titulo;
  final String contenido;
  final bool destacar;

  const OrgCotizacion({
    super.key,
    required this.titulo,
    required this.contenido,
    this.destacar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: destacar ? 6 : 3,
      color: destacar ? Theme.of(context).colorScheme.primaryContainer : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AtomLabel(text: titulo, isTitle: true),
            const Divider(height: 20),
            Text(
              contenido,
              style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: destacar ? Theme.of(context).colorScheme.onPrimaryContainer : null
              ),
            ),
          ],
        ),
      ),
    );
  }
}