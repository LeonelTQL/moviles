import '../../data/repositories/correo_repository_impl.dart';

class MarcarTodosLeidosUseCase {
  final CorreoRepositoryImpl repository;

  MarcarTodosLeidosUseCase(this.repository);

  Future<void> call() {
    return repository.marcarTodosLeidos();
  }
}
