bool allowCheckIn(DateTime fechaInicial, DateTime fechaFinal) {
  DateTime hoy = DateTime.now();
  return hoy.isAtSameMomentAs(fechaInicial) ||
      (hoy.isAfter(fechaInicial) && hoy.isBefore(fechaFinal));
}
