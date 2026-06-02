import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/pokemon.dart';

class DetallePage extends StatelessWidget{
  DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      appBar: AppBar(title: Text(pokemon.name.toUpperCase())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(pokemon.imageUrl, width: 550, fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Text("ID: ${pokemon.id}", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            Text("Nombre: ${pokemon.name}", style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}