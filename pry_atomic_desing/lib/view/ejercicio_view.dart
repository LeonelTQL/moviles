import 'package:flutter/material.dart';
import '../controller/ejercicio_controller.dart';


//1. atomos

class Label extends StatelessWidget{
  final String text;

  //constructor
Label(this.text,{super.key});

  @override
  Widget build(BuildContext context) =>
    Text(text,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);

}

//NumberField

class NumberField extends StatelessWidget{
  final TextEditingController controller;
  final String hint;


  NumberField({super.key, required this.controller, required this.hint});

  @override
  Widget build (BuildContext context) =>
    TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder(),
      ),
    );
}

//button

class PrimaryButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;

  PrimaryButton({super.key, required this.text, required this.onPressed});

  @override

  Widget build (BuildContext context) =>
      ElevatedButton(
          onPressed: onPressed,
          child: Text(text));
}

//2. molecula

class TripleInput extends StatelessWidget{
  final TextEditingController a,b,c;

  TripleInput({super.key, required this.a, required this.b, required this.c});

  @override
  // Widget build(BuildContext context)=>
  //     Row(
  //       children: [
  //         Expanded(
  //             child: TextField(
  //               controller: a,
  //             ),
  //         ), SizedBox(width: 10,),
  //         Expanded(
  //           child: TextField(
  //             controller: b,
  //           ),
  //         ), SizedBox(width: 10,),
  //         Expanded(
  //           child: TextField(
  //             controller: c,
  //           ),
  //         ), SizedBox(width: 10,),
  //       ],
  //     );

  Widget build(BuildContext context)=>
      Row(
        children: [
          Expanded(
            child: NumberField(
              controller: a,
              hint: "Valor A",
            ),
          ), SizedBox(width: 10,),
          Expanded(
            child: NumberField(
              controller: b,
              hint: "Valor B",
            ),
          ), SizedBox(width: 10,),
          Expanded(
            child: NumberField(
              controller: c,
              hint: "Valor C",
            ),
          ), SizedBox(width: 10,),
        ],
      );
}


//organismo

class AnalisisCard extends StatefulWidget{
  AnalisisCard({super.key});

  @override

  State<StatefulWidget> createState() => AnalisisCardState();

}

class AnalisisCardState extends State<AnalisisCard>{
  final _a= TextEditingController();
  final _b= TextEditingController();
  final _c= TextEditingController();
  final _controller= EjercicioController();
  String _resultado="";

  void _calcular(){
    setState(() {
      _resultado = _controller.procesar(_a.text, _b.text, _c.text);
    });
  }
  @override
  Widget build(BuildContext context){
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
          padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Label("Ingrese 3 numeros enteros: "),
                SizedBox(height: 10,),
                TripleInput(a: _a, b: _b, c: _c),
                SizedBox(height: 10,),
                PrimaryButton(text: "Calcular", onPressed: _calcular,),
                Label(_resultado),
                Text(_resultado),
              ],
            ),
      ),
    );
  }
}


//pagina

class NumerosPage extends StatelessWidget{
  NumerosPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title: Text("Calculos de numeros")
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: AnalisisCard(),
      ),
    );
  }
}