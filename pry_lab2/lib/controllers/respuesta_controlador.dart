class RespuestaControlador<T> {
  final T? datos;
  final String? error;

  const RespuestaControlador.exito(this.datos) : error = null;
  const RespuestaControlador.error(this.error) : datos = null;

  bool get esExito => error == null;
}
