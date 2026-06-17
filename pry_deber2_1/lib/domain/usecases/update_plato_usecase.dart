import '../entities/plato.dart';
import '../repositories/plato_repository.dart';

class UpdatePlatoUseCase {
  final PlatoRepository repository;
  UpdatePlatoUseCase(this.repository);

  Future<Plato> execute(Plato plato) {
    return repository.updatePlato(plato);
  }
}
