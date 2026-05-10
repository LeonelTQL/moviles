import 'package:flutter/material.dart';

class ResultadoPageView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final resultado = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text("Resultado")),
      body: Center(
        child: Text(resultado),
      ),
      
    );
  }
}