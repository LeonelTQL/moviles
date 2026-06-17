import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemasAppBar {
  static const AppBarTheme lightAppBarTheme = AppBarTheme(
    backgroundColor: EsquemaColor.primario,
    foregroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  );
}
