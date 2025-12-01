import '../models/tarea.dart';

// Utilidad para formatear fechas de tareas
class FormateadorFechas {
  static String formatearFechasTarea(Tarea tarea) {
    final ahora = DateTime.now();
    return formatearFechaRelativa(tarea.fechaCreacion, ahora, 'Creada');
  }


// Formatea una fecha relativa a la fecha actual
  static String formatearFechaRelativa(DateTime fecha, DateTime ahora, String prefijo) {
    final diferencia = ahora.difference(fecha);

    if (diferencia.inDays == 0) {
      if (diferencia.inHours == 0) {
        if (diferencia.inMinutes == 0) {
          return '$prefijo hace unos momentos';
        }
        return '$prefijo hace ${diferencia.inMinutes} minuto${diferencia.inMinutes == 1 ? '' : 's'}';
      }
      return '$prefijo hace ${diferencia.inHours} hora${diferencia.inHours == 1 ? '' : 's'}';
    } else if (diferencia.inDays == 1) {
      return '$prefijo ayer';
    } else if (diferencia.inDays < 7) {
      return '$prefijo hace ${diferencia.inDays} días';
    } else {
      final dia = fecha.day.toString().padLeft(2, '0');
      final mes = fecha.month.toString().padLeft(2, '0');
      final anio = fecha.year.toString();
      return '$prefijo el $dia/$mes/$anio';
    }
  }
}

