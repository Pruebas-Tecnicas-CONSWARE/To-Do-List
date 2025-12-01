import 'package:flutter/foundation.dart';
import '../models/tarea.dart';
import '../services/tareas_services.dart';


// Clase para gestionar las tareas y las operaciones relacionadas con ellas
class ProveedorTareas extends ChangeNotifier {
  List<Tarea> _tareas = [];
  bool _estaCargando = false;
  String? _mensajeError;

  List<Tarea> get tareas => List.unmodifiable(_tareas);
  bool get estaCargando => _estaCargando;
  String? get mensajeError => _mensajeError;
  bool get tieneError => _mensajeError != null;

  ProveedorTareas() {
    _inicializarYCargar();
  }

  Future<void> _inicializarYCargar() async {
    try {
      await ServicioTareas.inicializar();
      await cargarTareas();
    } catch (e) {
      _estaCargando = false;
      _mensajeError = _obtenerMensajeError(e, 'No se pudo inicializar la aplicación');
      notifyListeners();
    }
  }

  Future<void> cargarTareas() async {
    try {
      _estaCargando = true;
      _mensajeError = null;
      notifyListeners();

      _tareas = ServicioTareas.obtenerTodasLasTareas();
      
      _estaCargando = false;
      _mensajeError = null;
      notifyListeners();
    } catch (e) {
      _estaCargando = false;
      _mensajeError = _obtenerMensajeError(e, 'No se pudieron cargar las tareas');
      notifyListeners();
    }
  }

  Future<bool> agregarTarea(String titulo) async {
    try {
      if (titulo.trim().isEmpty) {
        _mensajeError = 'El título de la tarea no puede estar vacío';
        notifyListeners();
        return false;
      }

      _mensajeError = null;
      final nuevaTarea = Tarea(titulo: titulo.trim());
      
      await Future.delayed(const Duration(milliseconds: 250));
      final exito = await ServicioTareas.guardarTarea(nuevaTarea);
      
      if (exito) {
        await Future.delayed(const Duration(milliseconds: 200));
        await cargarTareas();
        return true;
      } else {
        _mensajeError = 'No se pudo guardar la tarea';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _mensajeError = _obtenerMensajeError(e, 'No se pudo agregar la tarea');
      notifyListeners();
      return false;
    }
  }

  Future<bool> actualizarTarea(Tarea tarea) async {
    try {
      if (tarea.titulo.trim().isEmpty) {
        _mensajeError = 'El título de la tarea no puede estar vacío';
        notifyListeners();
        return false;
      }

      _mensajeError = null;
      await Future.delayed(const Duration(milliseconds: 250));
      final exito = await ServicioTareas.actualizarTarea(tarea);
      
      if (exito) {
        await Future.delayed(const Duration(milliseconds: 200));
        await cargarTareas();
        return true;
      } else {
        _mensajeError = 'No se pudo actualizar la tarea';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _mensajeError = _obtenerMensajeError(e, 'No se pudo actualizar la tarea');
      notifyListeners();
      return false;
    }
  }

  Future<bool> alternarCompletado(String id, bool estaCompletada) async {
    try {
      final tarea = _tareas.firstWhere((t) => t.id == id);
      final tareaActualizada = tarea.copiarCon(estaCompletada: estaCompletada);
      
      return await actualizarTarea(tareaActualizada);
    } catch (e) {
      _mensajeError = _obtenerMensajeError(e, 'No se pudo cambiar el estado de la tarea');
      notifyListeners();
      return false;
    }
  }

  Future<bool> eliminarTarea(String id) async {
    try {
      _mensajeError = null;
      final exito = await ServicioTareas.eliminarTarea(id);
      
      if (exito) {
        await Future.delayed(const Duration(milliseconds: 300));
        await cargarTareas();
        return true;
      } else {
        _mensajeError = 'No se pudo eliminar la tarea';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _mensajeError = _obtenerMensajeError(e, 'No se pudo eliminar la tarea');
      notifyListeners();
      return false;
    }
  }

  Future<bool> eliminarTareasMultiples(List<String> ids) async {
    try {
      _mensajeError = null;
      bool todasEliminadas = true;
      
      for (final id in ids) {
        final exito = await ServicioTareas.eliminarTarea(id);
        if (!exito) {
          todasEliminadas = false;
        }
      }
      
      if (todasEliminadas) {
        await Future.delayed(const Duration(milliseconds: 300));
        await cargarTareas();
        return true;
      } else {
        _mensajeError = 'No se pudieron eliminar algunas tareas';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _mensajeError = _obtenerMensajeError(e, 'No se pudieron eliminar las tareas');
      notifyListeners();
      return false;
    }
  }

  void limpiarError() {
    _mensajeError = null;
    notifyListeners();
  }

  int get numeroTareasCompletadas {
    return _tareas.where((t) => t.estaCompletada).length;
  }

  int get numeroTareasPendientes {
    return _tareas.where((t) => !t.estaCompletada).length;
  }

  String _obtenerMensajeError(dynamic error, String mensajePorDefecto) {
    final mensajeError = error.toString().toLowerCase();
    
    if (mensajeError.contains('no ha sido inicializado') || 
        mensajeError.contains('no ha sido inicializado')) {
      return 'La aplicación no se inicializó correctamente. Por favor, reinicia la app.';
    }
    
    if (mensajeError.contains('adapter') || mensajeError.contains('no está registrado')) {
      return 'Error en la configuración de la base de datos. Por favor, reinicia la app.';
    }
    
    if (mensajeError.contains('permiso') || mensajeError.contains('permission')) {
      return 'No se tienen los permisos necesarios para acceder al almacenamiento.';
    }
    
    if (mensajeError.contains('espacio') || mensajeError.contains('space')) {
      return 'No hay suficiente espacio en el dispositivo.';
    }
    
    return mensajePorDefecto;
  }
}

