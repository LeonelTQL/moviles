import 'package:flutter/material.dart';


class InputVenta extends StatelessWidget {
  final TextEditingController controller;
  final String label;


  InputVenta({ required this.controller, required this.label});


  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder()
      ),
      keyboardType: TextInputType.number,
    );
  }
}