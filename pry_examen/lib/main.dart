import 'package:flutter/material.dart';
import 'themes/teme_general.dart';
import 'view/paginas/vista_cafe.dart';
import 'view/paginas/vista_nota_venta_cafe.dart';

void main() {
  runApp(const AplicacionBase());
}

class AplicacionBase extends StatelessWidget {
  const AplicacionBase({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafetería MVC',
      theme: TemeGeneral.claro,
      initialRoute: '/cafe',
      routes: {
        '/cafe': (context) => VistaCafe(),
        '/notaVentaCafe': (context) => const VistaNotaVentaCafe(),
      },
    );
  }
}
