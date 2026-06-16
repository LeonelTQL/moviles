import '../../data/repositories/correo_repository_impl.dart';

class RecibirCorreoUseCase {
  final CorreoRepositoryImpl repository;

  RecibirCorreoUseCase(this.repository);

  Future<void> call() {
    return repository.recibirNuevoCorreo();
  }
}
