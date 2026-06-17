import '../entities/pedido.dart';
import '../repositories/pedido_repository.dart';

class GetPedidosUseCase {
  final PedidoRepository repository;
  GetPedidosUseCase(this.repository);

  Future<List<Pedido>> execute() {
    return repository.getPedidos();
  }
}
