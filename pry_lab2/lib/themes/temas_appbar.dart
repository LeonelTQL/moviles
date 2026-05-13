import 'package:flutter/material.dart';
import 'esquema_color.dart';

class TemaAppBar {
  static const AppBarTheme estilo = AppBarTheme(
    backgroundColor: ColoresApp.primario,
    foregroundColor: ColoresApp.textoClaro,
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: ColoresApp.textoClaro),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: ColoresApp.textoClaro, // Antes usaba secundario, que es oscuro
    ),
  );
}