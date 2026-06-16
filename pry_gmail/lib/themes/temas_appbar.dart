import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemasAppbar {
  static AppBarTheme get appBarTheme {
    return const AppBarTheme(
      backgroundColor: EsquemaColor.tarjeta,
      foregroundColor: EsquemaColor.textoPrincipal,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: EsquemaColor.textoPrincipal,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}
