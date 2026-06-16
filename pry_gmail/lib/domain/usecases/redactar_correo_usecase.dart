import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class RedactarCorreoUseCase {
  final CorreoRepositoryImpl repository;

  RedactarCorreoUseCase(this.repository);

  Future<void> call(CorreoEntity correo) {
    return repository.guardarCorreo(correo);
  }
}
