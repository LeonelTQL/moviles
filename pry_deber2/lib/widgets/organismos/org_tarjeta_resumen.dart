import 'package:flutter/material.dart';
import '../atomos/atom_label.dart';

class OrgTarjetaResumen extends StatelessWidget {
  final String contenidoFactura;

  const OrgTarjetaResumen({required this.contenidoFactura});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AtomLabel(text: "Recibo Digital", isTitle: true),
            Divider(height: 30),
            Text(
              contenidoFactura,
              style: TextStyle(fontSize: 16, height: 1.5, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}