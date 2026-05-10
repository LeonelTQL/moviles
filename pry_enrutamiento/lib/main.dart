import 'package:flutter/material.dart';
import 'view/home_page_view.dart';
import 'view/resultado_page_view.dart';
import 'view/factura_page_view.dart';
import 'view/menu_page_view.dart';
import 'view/factura_detalle_view.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rutas",
      initialRoute: '/menu',
      routes: {
        '/menu': (context) => MenuPageView(),
        '/':(context) => HomePaginaView(),
        '/resultado':(context) => ResultadoPageView(),
        '/factura':(context) => FacturaPageView(),
        '/factura_detalle': (context) => FacturaDetalleView(),
    },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
    );
  }
}
