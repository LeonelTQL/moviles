import 'package:flutter/material.dart';
import '../controller/edad_controller.dart';


class Label extends StatelessWidget{
  final String text;

  //constructor
  Label(this.text,{super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);

}

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


class ResulText extends StatelessWidget{
  final String text;

  //constructor
  ResulText(this.text,{super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);

}

class FechaInput extends StatelessWidget{
  final TextEditingController diaC,mesC,anioC;

  //constructor
  FechaInput({super.key, required this.diaC, required this.mesC, required this.anioC});

  @override
  Widget build(BuildContext context) =>
      Row(
        children:[
          Expanded(child: NumberField(controller: diaC, hint: 'Dia',)),
          SizedBox(width: 10,),
          Expanded(child: NumberField(controller: mesC, hint: 'Mes',)),
          SizedBox(width: 10,),
          Expanded(child: NumberField(controller: anioC, hint: 'Anio',)),
          SizedBox(width: 10,),
        ],
      );
}

class EdadCard extends StatefulWidget{
  EdadCard({super.key});

  @override

  State<StatefulWidget> createState() => EdadCardState();

}

class EdadCardState extends State<EdadCard>{
  final _ctrlDia = TextEditingController();
  final _ctrlMes = TextEditingController();
  final _ctrlDAnio = TextEditingController();
  String _resultado = '';
  final _controller = EdadController();


  void _calcular(){
    setState(() {
          _resultado = _controller.procesarEdad(_ctrlDia.text, _ctrlMes.text, _ctrlDAnio.text);
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
            Label("Ingrese fecha de nacimiento: "),
            SizedBox(height: 10,),
            FechaInput(diaC: _ctrlDia,mesC: _ctrlMes,anioC: _ctrlDAnio),
            SizedBox(height: 10,),
            PrimaryButton(text: "Calcular", onPressed: _calcular,),
            Label(_resultado),
          ],
        ),
      ),
    );
  }
}

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
        child: EdadCard(),
      ),
    );
  }
}