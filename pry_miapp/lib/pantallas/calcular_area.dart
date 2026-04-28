import 'package:flutter/material.dart';

class TerrenoPagina extends StatefulWidget {
  @override
  State<TerrenoPagina> createState() => _TerrenoPaginaState();

}

class _TerrenoPaginaState extends State<TerrenoPagina>{

  final baseCrtl= TextEditingController();
  final alturaCrtl = TextEditingController();
  double area=0;
  double perimetro=0;
  double valor=0;

  void calcular(){
    final base = double.tryParse(baseCrtl.text)??0;
    final altura = double.tryParse(alturaCrtl.text)??0;

    setState(() {
      area = base * altura;
      perimetro = 2*(base + altura);

      valor = area * 500;
    });
  }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text("Calcular terrenos",
                style: TextStyle(fontSize:16),
              ),
              SizedBox(height: 20,),

              Text("Ingrese las medidas: ",
              style: TextStyle(fontSize: 20),
              ),

              TextField(
                controller: alturaCrtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (m): ",
                    border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height:20,),

              TextField(
                controller: baseCrtl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Base (m): ",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height:20,),

              ElevatedButton(
                  onPressed:calcular,
                  child: Text("Calcular")),
              SizedBox(height: 20,),

              Text("Area : ${area.toStringAsFixed(2)} m^2"),
              Text("Perimetro: ${perimetro.toStringAsFixed(2)} m"),
              Text("Valor Total: ${valor.toStringAsFixed(2)}\$",
              style: TextStyle(color:Colors.green),),
            ],
          ),
      )
      );
    }
}
