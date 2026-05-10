import 'package:flutter/material.dart';
import '../controller/perfecto_controller.dart';

//atomos
class label extends StatelessWidget {
  final String text;
  label(this.text, {super.key});

  @override
  Widget build(BuildContext context) =>
      Text(text, style: TextStyle(fontSize: 20));
}

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  NumberField({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: hint,
        border: OutlineInputBorder()
    ),
  );
}

//button
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),);
  }
}

class resultText extends StatelessWidget {
  final String text;
  resultText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 20));
  }
}

//molecula
class numeroInput extends StatelessWidget {
  final TextEditingController numeroC;

  numeroInput({super.key, required this.numeroC});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: NumberField(controller: numeroC, hint: 'Ingrese el número N')),
      ],
    );
  }
}

//organizmo
class perfectoCard extends StatefulWidget {
  perfectoCard({super.key});

  @override
  State<StatefulWidget> createState() => _perfectoCardState();
}

class _perfectoCardState extends State<perfectoCard> {
  final _ctrlNumero = TextEditingController();
  String _resultado = '';

  //instanciar el controlador siguiendo tu lógica MVC
  final _controller = perfectoController();

  void _calcular() {
    setState(() {
      // Se envía el número al controlador para verificar si es perfecto
      _resultado = _controller.verificarPerfecto(_ctrlNumero.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            label("Verificar si N es un número perfecto"),
            SizedBox(height: 10,),
            numeroInput(numeroC: _ctrlNumero),
            SizedBox(height: 10,),
            PrimaryButton(text: "Verificar", onPressed: _calcular),
            SizedBox(height: 10,),
            label(_resultado),
          ],
        ),
      ),
    );
  }
}

//pagina
class perfectoPage extends StatelessWidget {
  const perfectoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de Números Perfectos"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: perfectoCard(),
      ),
    );
  }
}