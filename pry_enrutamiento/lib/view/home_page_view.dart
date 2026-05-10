import 'package:flutter/material.dart';
import '../controller/vendedor_controller.dart';
import '../widgets/input_venta.dart';
import "../widgets/boton_calcular.dart";


class HomePaginaView extends StatefulWidget {
  @override
  State<HomePaginaView> createState() => _HomePaginaViewState();

}

class _HomePaginaViewState extends State<HomePaginaView>{
  final controller = VendedorController();
  final venta1Controller = TextEditingController();
  final venta2Controller = TextEditingController();
  final venta3Controller = TextEditingController();

  String resultado ="";

  void _calcular(){
    final resultado = controller.calcularSueldo(
      venta1Controller.text,
      venta2Controller.text,
      venta3Controller.text,
    );

    Navigator.pushNamed(context, '/resultado', arguments: resultado);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calcular sueldo"),),
      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputVenta(controller: venta1Controller, label: "Venta 1"),
            SizedBox(height: 16.0),
            InputVenta(controller: venta2Controller, label: "Venta 2"),
            SizedBox(height: 16.0),
            InputVenta(controller: venta3Controller, label: "Venta 3"),
            SizedBox(height: 16.0),
            
            BotonCalcular(onPresssed: _calcular)
          ],
        ) ,
      ),
    );
  }
}