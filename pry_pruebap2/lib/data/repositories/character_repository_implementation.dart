import '../../domain/entities/character.dart';
import '../datasource/dragonball_datasource.dart';

class CharacterRepositoryImplementation {
  final DragonBallDatasource datasource;

  CharacterRepositoryImplementation(this.datasource);

  Future<List<Character>> getCharacters() async {
    return datasource.fetchCharacters();
  }

  Future<Character> getCharacterById(int id) async {
    return datasource.fetchCharacterById(id);
  }
}
