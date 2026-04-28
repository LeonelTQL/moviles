class EdadModel {

  static Map<String, int> calcularEdad(int diaNacimiento, int mesNacimiento, int anioNacimiento){
    final hoy = DateTime.now();
    int dia = hoy.day;
    int mes = hoy.month;
    int anio = hoy.year;

    //ajustar de forma manula si el dia actual es menor al dia de nacimiento

    if(dia < diaNacimiento){
      dia = dia + 30;
      mes = mes -1;
    }

    if(mes < mesNacimiento){
      mes = mes + 12;
      anio = anio -1;
    }

    //operaciones
    int dias = dia - diaNacimiento;
    int meses = mes - mesNacimiento;
    int anios = anio - anioNacimiento;


    return {
      'anios': anios,
      'meses': meses,
      'dias': dias
    };
  }
}