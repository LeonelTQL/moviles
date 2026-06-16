import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/foto_controller.dart';
import '../providers/foto_provider.dart';
import '../widgets/foto_item.dart';

class FotoView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FotoProvider>(context);
    final controller = FotoController(provider);
    return Scaffold(
      appBar: AppBar(title: Text("Mis Fotos"),),
      body: ListView.builder(
        itemCount: provider.fotos.length,
        itemBuilder: (_,index) {
          return FotoItem(foto: provider.fotos[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () =>
          controller.tomarFoto(context),
        child: Icon(Icons.camera_alt),),
    );
  }
}