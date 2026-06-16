class PolicyEntity {
  final String codigo;
  final String cliente;
  final String tipoSeguro;
  final String fechaInicio;
  final String fechaVencimiento;
  final double valorAsegurado;

  const PolicyEntity({
    required this.codigo,
    required this.cliente,
    required this.tipoSeguro,
    required this.fechaInicio,
    required this.fechaVencimiento,
    required this.valorAsegurado,
  });

  PolicyEntity copyWith({
    String? codigo,
    String? cliente,
    String? tipoSeguro,
    String? fechaInicio,
    String? fechaVencimiento,
    double? valorAsegurado,
  }) {
    return PolicyEntity(
      codigo: codigo ?? this.codigo,
      cliente: cliente ?? this.cliente,
      tipoSeguro: tipoSeguro ?? this.tipoSeguro,
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      valorAsegurado: valorAsegurado ?? this.valorAsegurado,
    );
  }
}
