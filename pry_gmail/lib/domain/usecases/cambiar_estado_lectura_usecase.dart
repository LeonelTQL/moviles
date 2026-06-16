import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class CambiarEstadoLecturaUseCase {
  final CorreoRepositoryImpl repository;

  CambiarEstadoLecturaUseCase(this.repository);

  Future<void> call(CorreoEntity correo) {
    return repository.actualizarCorreo(correo.copyWith(leido: true));
  }
}
