import 'package:hive_flutter/hive_flutter.dart';
import '../models/tarea.dart';

class ServicioTareas {
  static const String _nombreCaja = 'tareas';
  static Box<Tarea>? _caja;

  static Future<void> inicializar() async {
    try {
      if (_caja != null && _caja!.isOpen) {
        return;
      }
      
      await Hive.initFlutter();
      
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(TareaAdapter());
      }
      
      _caja = await Hive.openBox<Tarea>(_nombreCaja);
    } catch (e) {
      throw Exception('No se pudo inicializar el almacenamiento local');
    }
  }

  static List<Tarea> obtenerTodasLasTareas() {
    if (_caja == null || !_caja!.isOpen) {
      throw Exception('El servicio no ha sido inicializado');
    }
    try {
      return _caja!.values.toList();
    } catch (e) {
      throw Exception('No se pudieron leer las tareas guardadas');
    }
  }

  static Future<bool> guardarTarea(Tarea tarea) async {
    if (_caja == null || !_caja!.isOpen) {
      throw Exception('El servicio no ha sido inicializado');
    }
    try {
      await _caja!.put(tarea.id, tarea);
      return true;
    } catch (e) {
      throw Exception('No se pudo guardar la tarea');
    }
  }

  static Future<bool> actualizarTarea(Tarea tarea) async {
    if (_caja == null || !_caja!.isOpen) {
      throw Exception('El servicio no ha sido inicializado');
    }
    
    if (!_caja!.containsKey(tarea.id)) {
      throw Exception('La tarea no existe');
    }
    
    try {
      tarea.fechaModificacion = DateTime.now();
      await _caja!.put(tarea.id, tarea);
      return true;
    } catch (e) {
      throw Exception('No se pudo actualizar la tarea');
    }
  }

  static Future<bool> eliminarTarea(String id) async {
    if (_caja == null || !_caja!.isOpen) {
      throw Exception('El servicio no ha sido inicializado');
    }
    
    if (!_caja!.containsKey(id)) {
      throw Exception('La tarea no existe');
    }
    
    try {
      await _caja!.delete(id);
      return true;
    } catch (e) {
      throw Exception('No se pudo eliminar la tarea');
    }
  }
}
