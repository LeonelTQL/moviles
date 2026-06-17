import '../repositories/pedido_repository.dart';

class DeletePedidoUseCase {
  final PedidoRepository repository;
  DeletePedidoUseCase(this.repository);

  Future<void> execute(int id) {
    return repository.deletePedido(id);
  }
}
