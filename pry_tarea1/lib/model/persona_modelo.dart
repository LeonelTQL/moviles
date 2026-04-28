class PersonaModelo {
  final double promedio;
  final double ultimoPeso;
  final double diferencia;
  final String estado;

  PersonaModelo(
      this.promedio,
      this.ultimoPeso,
      this.diferencia,
      this.estado,
      );

  static PersonaModelo analizar(List<double> pesos) {
    final suma = pesos.reduce((a, b) => a + b);
    final promedio = suma / pesos.length;
    final ultimo = pesos.last;

    final diferencia = ultimo - promedio;

    final estado = diferencia > 0 ? "SUBIÓ" : "BAJÓ";

    return PersonaModelo(
      promedio,
      ultimo,
      diferencia.abs(),
      estado,
    );
  }
}

