import 'package:flutter/material.dart';
import '../../domain/entities/resultado_operario.dart';
class ResultadoPage  extends StatelessWidget{
  final ResultadoOperario resultadoOperario;
  const ResultadoPage({super.key, required this.resultadoOperario});

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Resultado"),),
      body: Padding(padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text("Aumento aplicado"),
                trailing: Text(
                  "\$${resultadoOperario.aumento.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Sueldo Final"),
                trailing: Text(
                  "\$${resultadoOperario.sueldoFinal.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),

            ElevatedButton(
                onPressed:() => Navigator.pop(context),
                child: Text("Regresar"))


          ],
        ),

      ) ,
    );
  }


}