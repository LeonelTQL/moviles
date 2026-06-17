import '../../domain/entities/plato.dart';
import '../../domain/repositories/plato_repository.dart';
import '../datasource/plato_datasource.dart';
import '../models/plato_model.dart';

class PlatoRepositoryImplementation implements PlatoRepository {
  final PlatoDatasource datasource;

  PlatoRepositoryImplementation(this.datasource);

  @override
  Future<List<Plato>> getPlatos() async {
    return await datasource.getPlatos();
  }

  @override
  Future<Plato> getPlatoById(int id) async {
    return await datasource.getPlatoById(id);
  }

  @override
  Future<Plato> createPlato(Plato plato) async {
    final model = PlatoModel.fromEntity(plato);
    return await datasource.createPlato(model);
  }

  @override
  Future<Plato> updatePlato(Plato plato) async {
    final model = PlatoModel.fromEntity(plato);
    return await datasource.updatePlato(model);
  }

  @override
  Future<void> deletePlato(int id) async {
    await datasource.deletePlato(id);
  }
}
