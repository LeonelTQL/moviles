import 'package:flutter/material.dart';

import '../atomos/texto_subtitulo_app.dart';
import '../atomos/texto_titulo_app.dart';

class EncabezadoEjercicio extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const EncabezadoEjercicio({
    super.key,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextoTituloApp(titulo),
        const SizedBox(height: 8),
        TextoSubtituloApp(descripcion),
      ],
    );
  }
}
