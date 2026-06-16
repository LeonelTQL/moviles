import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class LeerCorreosRealesUseCase {
  final CorreoRepositoryImpl repository;

  LeerCorreosRealesUseCase(this.repository);

  Future<List<CorreoEntity>> call() {
    return repository.leerCorreosReales();
  }
}
