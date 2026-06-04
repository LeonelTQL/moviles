import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';
import '../../domain/usescases/get_characters_usecase.dart';
import '../../data/repositories/character_repository_implementation.dart';

class CharacterViewModel extends ChangeNotifier {
  final GetCharactersUseCase getCharactersUseCase;
  final CharacterRepositoryImplementation repository;

  CharacterViewModel(this.getCharactersUseCase, this.repository);

  List<Character> characters = [];
  bool loading = false;
  String? errorMessage;

  Future<void> loadCharacters() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      characters = await getCharactersUseCase();
    } catch (e) {
      errorMessage = "Error al cargar datos de Dragon Ball";
    }

    loading = false;
    notifyListeners();
  }

  Future<Character?> getCharacterDetails(int id) async {
    try {
      return await repository.getCharacterById(id);
    } catch (e) {
      return null;
    }
  }
}
