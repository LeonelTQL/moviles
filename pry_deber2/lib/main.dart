import 'package:flutter/material.dart';
import 'view/menu_view.dart';
import 'view/registro_pago_view.dart';
import 'view/resumen_pago_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestor de Servicios',
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuView(),
        '/registro': (context) => RegistroPagoView(),
        '/resumen': (context) => ResumenPagoView(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.tealAccent,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    );
  }
}