import '../entities/pokemon.dart';
import '../../data/repositories/pokemon_repository_implementation.dart';


class GetPokemonsUseCase {
  final PokemonRepositoryImplementation repository;

  GetPokemonsUseCase(this.repository);

  Future<List<Pokemon>> call(){
    return repository.getPokemon(limit: 30, offset:0);
  }
}
