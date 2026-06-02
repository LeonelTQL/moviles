import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usescases/get_pokemons_usecase.dart';


class PokemonViewModel extends ChangeNotifier{
  final GetPokemonsUseCase getPokemonsUseCase;

  PokemonViewModel(this.getPokemonsUseCase);

  //manejo de estado
List<Pokemon> pokemons = [];
bool loading = false;
String? errorMessage;
  //routes; navigator

Future<void> loadPokemons() async{
  loading = true;
  notifyListeners();

  try{
    pokemons = await getPokemonsUseCase();
  }catch(e){
    errorMessage= "Error al cargar datos";
  }

  loading = false;
  notifyListeners();
}
  //view:
}