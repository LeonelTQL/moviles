import '../entities/character.dart';
import '../../data/repositories/character_repository_implementation.dart';

class GetCharactersUseCase {
  final CharacterRepositoryImplementation repository;

  GetCharactersUseCase(this.repository);

  Future<List<Character>> call() {
    return repository.getCharacters();
  }
}
