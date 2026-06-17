import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class CreatePedidoUseCase {
  final PedidoRepository repository;
  CreatePedidoUseCase(this.repository);

  Future<Pedido> execute(Pedido pedido) {
    // Regla de negocio: Un pedido debe tener al menos un plato.
    if (pedido.detalles.isEmpty) {
      throw Exception('Un pedido debe tener al menos un plato.');
    }
    return repository.createPedido(pedido);
  }
}
