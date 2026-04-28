import 'package:flutter/material.dart';

//1. crear stateless
class Calcu extends StatefulWidget {
  @override
  CalculadoraState createState() => CalculadoraState();


}

//2. definir
class CalculadoraState extends State<Calcu>{
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  String resultado = "Resultado";
  double a =0;
  double b=0;

  void ingresar(){
    a=double.tryParse(num1.text)??0;
    b=double.tryParse(num2.text)??0;

  }

  void sumar(){
    ingresar();
    setState(() {
      resultado = "Suma: ${a+b}";
    });
  }

  void restar(){
    ingresar();
    setState(() {
      resultado = "Resta: ${a-b}";
    });
  }
  void multi(){
    ingresar();
    setState(() {
      resultado = "Multiplicacion: ${a*b}";
    });
  }
  void divi(){
    ingresar();
    if(b==0){
      print("No 0");
    }else{
      setState(() {
        resultado = "Division: ${a/b}";
      });
    }

  }

  void limpiar(){
    setState(() {
      num1.clear();
      num2.clear();
      resultado="Resultado";
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi calculadora'),
          backgroundColor: Colors.purple,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: num1,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Numero 1",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),

          TextField(
            controller: num2,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Numero 2",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: sumar, child: Text("+"),
              ),
              ElevatedButton(onPressed: restar, child: Text("-"),
              ),
              ElevatedButton(onPressed: multi, child: Text("X"),
              ),
              ElevatedButton(onPressed: divi, child: Text("/"),
              ),
            ],
          ),
          
          ElevatedButton(onPressed: limpiar, child: Text("Limpiar")),
          SizedBox(height: 20,),
          Text(resultado,style: TextStyle(fontSize: 20),)
        ],
      ) ,
    );
  }
}

