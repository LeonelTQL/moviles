import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaFondos {
  static const ColorScheme colorScheme = ColorScheme.light(
    primary: EsquemaColor.gmailRojo,
    secondary: EsquemaColor.gmailAzul,
    surface: EsquemaColor.tarjeta,
    error: Color(0xFFB3261E),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: EsquemaColor.textoPrincipal,
    onError: Colors.white,
  );
}
