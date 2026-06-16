import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class ObtenerCorreosUseCase {
  final CorreoRepositoryImpl repository;

  ObtenerCorreosUseCase(this.repository);

  Future<List<CorreoEntity>> call() {
    return repository.obtenerCorreos();
  }
}
