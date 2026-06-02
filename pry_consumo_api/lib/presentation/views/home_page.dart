import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/pokemon_viewmodel.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState ()=> HomePageState();
}

class HomePageState extends State<HomePage>{
  @override
  void initState(){
   super.initState();
   
   Future.microtask(() => Provider.of<PokemonViewModel>(context, listen: false).loadPokemons());
  }

  @override
  Widget build(BuildContext context) {
    
    final vm= Provider.of<PokemonViewModel>(context);
    if(vm.loading){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: ListView.builder(
        itemCount: vm.pokemons.length,
        itemBuilder: (_, index){
          final p=vm.pokemons[index];
          return ListTile(
            leading: Image.network(p.imageUrl),
            title:  Text(p.name.toUpperCase()),
            subtitle: Text("ID: ${p.id}"),
            onTap: (){
              Navigator.pushNamed(context, "/detalle", arguments: p);
            },
          );
        },
      )
    );
  }
}

