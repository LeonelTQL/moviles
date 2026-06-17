import '../repositories/plato_repository.dart';

class DeletePlatoUseCase {
  final PlatoRepository repository;
  DeletePlatoUseCase(this.repository);

  Future<void> execute(int id) {
    return repository.deletePlato(id);
  }
}
