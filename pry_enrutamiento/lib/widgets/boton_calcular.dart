import 'package:flutter/material.dart';

class BotonCalcular extends StatelessWidget{
  final VoidCallback onPresssed;

  const BotonCalcular({required this.onPresssed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPresssed,
        child:Text ("Calcular Sueldo"));
  }
}