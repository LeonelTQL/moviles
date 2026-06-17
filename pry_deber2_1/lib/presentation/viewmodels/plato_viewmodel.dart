import 'package:flutter/material.dart';
import '../../domain/entities/plato.dart';
import '../../domain/usecases/get_platos_usecase.dart';
import '../../domain/usecases/create_plato_usecase.dart';
import '../../domain/usecases/update_plato_usecase.dart';
import '../../domain/usecases/delete_plato_usecase.dart';

class PlatoViewModel extends ChangeNotifier {
  final GetPlatosUseCase getPlatosUseCase;
  final CreatePlatoUseCase createPlatoUseCase;
  final UpdatePlatoUseCase updatePlatoUseCase;
  final DeletePlatoUseCase deletePlatoUseCase;

  List<Plato> _platos = [];
  bool _isLoading = false;
  String? _error;

  PlatoViewModel({
    required this.getPlatosUseCase,
    required this.createPlatoUseCase,
    required this.updatePlatoUseCase,
    required this.deletePlatoUseCase,
  });

  List<Plato> get platos => _platos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPlatos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _platos = await getPlatosUseCase.execute();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlato(Plato plato) async {
    try {
      await createPlatoUseCase.execute(plato);
      await fetchPlatos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> editPlato(Plato plato) async {
    try {
      await updatePlatoUseCase.execute(plato);
      await fetchPlatos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  Future<void> removePlato(int id) async {
    try {
      await deletePlatoUseCase.execute(id);
      await fetchPlatos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      rethrow;
    }
  }
}
