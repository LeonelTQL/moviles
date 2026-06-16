import '../../data/repositories/correo_repository_impl.dart';
import '../entities/correo_entity.dart';

class BuscarCorreosUseCase {
  final CorreoRepositoryImpl repository;

  BuscarCorreosUseCase(this.repository);

  List<CorreoEntity> call(List<CorreoEntity> correos, String filtro) {
    return repository.buscarCorreos(correos, filtro);
  }
}
