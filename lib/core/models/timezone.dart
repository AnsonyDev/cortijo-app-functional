class Timezone {
  String? startTime;
  String? endTime;
  int id;

  Timezone({
    this.startTime,
    this.endTime,
    required this.id,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        startTime: json["start_time"],
        endTime: json["end_time"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() =>
      {"start_time": startTime, "end_time": endTime, "id": id};

  @override
  String toString() {
    return "${convertirFormatoTiempo(startTime ?? '')}  - ${convertirFormatoTiempo(endTime ?? '')}";
  }
}

String convertirFormatoTiempo(String tiempoCompleto) {
  List<String> partes = tiempoCompleto.split(':');

  // Asegurarse de que hay al menos dos partes (hora y minuto)
  if (partes.length >= 2) {
    String hora = partes[0];
    String minuto = partes[1];

    // Formatear el resultado como "hh:mm"
    String tiempoFormateado = '$hora:$minuto';
    return tiempoFormateado;
  } else {
    // En caso de que no haya suficientes partes
    return tiempoCompleto;
  }
}
