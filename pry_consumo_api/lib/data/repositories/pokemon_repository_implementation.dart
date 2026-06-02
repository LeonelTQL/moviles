import '../../domain/entities/pokemon.dart';
import '../datasource/pokeapi_datasource.dart';

class PokemonRepositoryImplementation {

  final PokeApiDatasource datasource;
  PokemonRepositoryImplementation(this.datasource);

  Future<List<Pokemon>> getPokemon({ int limit = 30, int offset = 0}) async{
    return datasource.fetchPokemon(limit, offset);
  }
}