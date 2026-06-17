import '../entities/plato.dart';
import '../repositories/plato_repository.dart';

class GetPlatosUseCase {
  final PlatoRepository repository;
  GetPlatosUseCase(this.repository);

  Future<List<Plato>> execute() {
    return repository.getPlatos();
  }
}
