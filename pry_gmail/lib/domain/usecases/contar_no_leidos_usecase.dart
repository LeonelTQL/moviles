import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class ContarNoLeidosUseCase {
  final CorreoRepositoryImpl repository;

  ContarNoLeidosUseCase(this.repository);

  int call(List<CorreoEntity> correos) {
    return repository.contarNoLeidos(correos);
  }
}
