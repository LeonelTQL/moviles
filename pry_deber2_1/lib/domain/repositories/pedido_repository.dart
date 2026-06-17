import '../entities/pedido.dart';

abstract class PedidoRepository {
  Future<List<Pedido>> getPedidos();
  Future<Pedido> createPedido(Pedido pedido);
  Future<Pedido> updatePedido(Pedido pedido);
  Future<void> deletePedido(int id);
}
