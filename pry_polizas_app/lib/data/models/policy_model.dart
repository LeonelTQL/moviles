import '../../domain/entities/policy_entity.dart';

class PolicyModel extends PolicyEntity {
  const PolicyModel({
    required super.codigo,
    required super.cliente,
    required super.tipoSeguro,
    required super.fechaInicio,
    required super.fechaVencimiento,
    required super.valorAsegurado,
  });

  factory PolicyModel.fromEntity(PolicyEntity policy) {
    return PolicyModel(
      codigo: policy.codigo,
      cliente: policy.cliente,
      tipoSeguro: policy.tipoSeguro,
      fechaInicio: policy.fechaInicio,
      fechaVencimiento: policy.fechaVencimiento,
      valorAsegurado: policy.valorAsegurado,
    );
  }

  factory PolicyModel.fromJson(Map<String, dynamic> json) {
    return PolicyModel(
      codigo: json['codigo']?.toString() ?? '',
      cliente: json['cliente']?.toString() ?? '',
      tipoSeguro: json['tipo_seguro']?.toString() ?? '',
      fechaInicio: json['fecha_inicio']?.toString() ?? '',
      fechaVencimiento: json['fecha_vencimiento']?.toString() ?? '',
      valorAsegurado: (json['valor_asegurado'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'cliente': cliente,
      'tipo_seguro': tipoSeguro,
      'fecha_inicio': fechaInicio,
      'fecha_vencimiento': fechaVencimiento,
      'valor_asegurado': valorAsegurado,
    };
  }

  Map<String, dynamic> toUpdateJson() {
    return {
      'cliente': cliente,
      'tipo_seguro': tipoSeguro,
      'fecha_inicio': fechaInicio,
      'fecha_vencimiento': fechaVencimiento,
      'valor_asegurado': valorAsegurado,
    };
  }
}
