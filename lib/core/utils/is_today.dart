bool esDiaActual(DateTime fecha) {
  DateTime fechaActual = DateTime.now();
  return fecha.year == fechaActual.year &&
      fecha.month == fechaActual.month &&
      fecha.day == fechaActual.day;
}
