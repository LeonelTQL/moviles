import 'dart:io';
import 'package:flutter/material.dart';
import '../models/foto.dart';

class FotoItem extends StatelessWidget {

  final Foto foto;

  FotoItem({super.key, required this.foto});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(
        File(foto.path),
        width:50,
        fit: BoxFit.cover,
      ),
      title: Text(foto.nombre),
      subtitle: Text(foto.descripcion),
    );
  }
}
