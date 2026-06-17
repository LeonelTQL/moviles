import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class UpdatePedidoUseCase {
  final PedidoRepository repository;
  UpdatePedidoUseCase(this.repository);

  Future<Pedido> execute(Pedido pedido) {
    if (pedido.detalles.isEmpty) {
      throw Exception('Un pedido debe tener al menos un plato.');
    }
    return repository.updatePedido(pedido);
  }
}
