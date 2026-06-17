import '../entities/plato.dart';
import '../repositories/plato_repository.dart';

class CreatePlatoUseCase {
  final PlatoRepository repository;
  CreatePlatoUseCase(this.repository);

  Future<Plato> execute(Plato plato) {
    return repository.createPlato(plato);
  }
}
