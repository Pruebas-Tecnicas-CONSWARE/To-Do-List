// Constantes de la aplicación
class Constantes {
  // Mensajes de validación
  static const String tituloVacio = 'El título de la tarea no puede estar vacío';
  static const String tituloMuyLargo = 'El título de la tarea es demasiado largo';
  static const int longitudMaximaTitulo = 200;

  // Mensajes de éxito
  static const String tareaAgregada = 'Tarea agregada exitosamente';
  static const String tareaActualizada = 'Tarea actualizada exitosamente';
  static const String tareaEliminada = 'Tarea eliminada exitosamente';

  // Mensajes de error
  static const String errorCargarTareas = 'Error al cargar las tareas';
  static const String errorGuardarTarea = 'Error al guardar la tarea';
  static const String errorActualizarTarea = 'Error al actualizar la tarea';
  static const String errorEliminarTarea = 'Error al eliminar la tarea';
  static const String errorInicializarBaseDatos = 'Error al inicializar la base de datos';
  static const String errorDesconocido = 'Ha ocurrido un error desconocido';

  // Textos de UI
  static const String tituloApp = 'Lista de Tareas';
  static const String agregarTarea = 'Agregar Tarea';
  static const String editarTarea = 'Editar Tarea';
  static const String nombreTarea = 'Nombre de la tarea';
  static const String guardar = 'Guardar';
  static const String cancelar = 'Cancelar';
  static const String eliminar = 'Eliminar';
  static const String completada = 'Completada';
  static const String pendiente = 'Pendiente';
  static const String sinTareas = 'No hay tareas';
  static const String sinTareasDescripcion = 'Agrega una nueva tarea para comenzar';
  static const String tareasCompletadas = 'Tareas completadas';
  static const String tareasPendientes = 'Tareas pendientes';
  static const String totalTareas = 'Total de tareas';

  // Nombres de rutas
  static const String rutaInicio = '/';
  static const String rutaAgregarTarea = '/agregar-tarea';
  static const String rutaEditarTarea = '/editar-tarea';
}
