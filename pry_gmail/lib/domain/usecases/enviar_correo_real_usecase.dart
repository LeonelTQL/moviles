import '../../data/repositories/correo_repository_impl.dart';

class EnviarCorreoRealUseCase {
  final CorreoRepositoryImpl repository;

  EnviarCorreoRealUseCase(this.repository);

  Future<bool> call({
    required String destinatario,
    required String asunto,
    required String mensaje,
  }) {
    return repository.enviarCorreoReal(
      destinatario: destinatario,
      asunto: asunto,
      mensaje: mensaje,
    );
  }
}
