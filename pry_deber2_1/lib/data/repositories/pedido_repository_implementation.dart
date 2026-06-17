import '../../domain/entities/pedido.dart';
import '../../domain/repositories/pedido_repository.dart';
import '../datasource/pedido_datasource.dart';
import '../models/pedido_model.dart';

class PedidoRepositoryImplementation implements PedidoRepository {
  final PedidoDatasource datasource;

  PedidoRepositoryImplementation(this.datasource);

  @override
  Future<List<Pedido>> getPedidos() async {
    return await datasource.getPedidos();
  }

  @override
  Future<Pedido> createPedido(Pedido pedido) async {
    final model = PedidoModel(
      cliente: pedido.cliente,
      fecha: pedido.fecha,
      detalles: pedido.detalles,
      total: pedido.total,
    );
    return await datasource.createPedido(model);
  }

  @override
  Future<Pedido> updatePedido(Pedido pedido) async {
    final model = PedidoModel(
      id: pedido.id,
      cliente: pedido.cliente,
      fecha: pedido.fecha,
      detalles: pedido.detalles,
      total: pedido.total,
    );
    return await datasource.updatePedido(model);
  }

  @override
  Future<void> deletePedido(int id) async {
    await datasource.deletePedido(id);
  }
}
