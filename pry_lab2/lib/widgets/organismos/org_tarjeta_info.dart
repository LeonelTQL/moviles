import 'package:flutter/material.dart';
import '../atomos/atom_label.dart';

class OrgTarjetaInfo extends StatelessWidget {
  final String titulo;
  final String contenido;
  final Color? colorFondo;

  const OrgTarjetaInfo({
    required this.titulo,
    required this.contenido,
    this.colorFondo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: colorFondo ?? Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AtomLabel(text: titulo, isTitle: true),
            Divider(thickness: 1.5),
            SizedBox(height: 10),
            Text(
              contenido,
              style: TextStyle(fontSize: 15, height: 1.6, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }
}