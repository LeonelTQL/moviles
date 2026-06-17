import 'package:flutter/material.dart';
import 'esquema_color.dart';

class Tipografia {
  static const TextStyle tituloGrande = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: EsquemaColor.textoPrincipal,
  );

  static const TextStyle tituloMediano = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: EsquemaColor.textoPrincipal,
  );

  static const TextStyle cuerpo = TextStyle(
    fontSize: 14,
    color: EsquemaColor.textoSecundario,
  );

  static const TextStyle precio = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: EsquemaColor.primario,
  );
}
