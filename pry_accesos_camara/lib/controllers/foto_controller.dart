import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/foto.dart';
import '../providers/foto_provider.dart';

class FotoController {
  final FotoProvider provider;
  final ImagePicker picker = ImagePicker();

  FotoController(this.provider);

  Future<void> tomarFoto(BuildContext context) async{
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);

    if (foto != null) {
      provider.agregarFoto(
        Foto(
          path: foto.path,
          nombre: "Foto ${provider.fotos.length + 1}",
          descripcion: 'Capturada el ${DateTime.now()}',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Foto guardada correctamente"),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        )
      );
    }
  }
}