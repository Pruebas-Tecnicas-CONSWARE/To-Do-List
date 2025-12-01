import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../providers/tareas_provider.dart';
import '../widgets/dialogo_confirmar_eliminacion.dart';
import '../widgets/alerta_exito.dart';
import '../utils/constantes.dart';

// Clase helper para gestionar la selección múltiple de tareas
class GestorSeleccionTareas {
  // Maneja la selección/deselección de una tarea
  static void alternarSeleccion(
    Set<String> tareasSeleccionadas,
    String idTarea,
    VoidCallback onChanged,
  ) {
    if (tareasSeleccionadas.contains(idTarea)) {
      tareasSeleccionadas.remove(idTarea);
    } else {
      tareasSeleccionadas.add(idTarea);
    }
    onChanged();
  }

  // Maneja seleccionar/deseleccionar todas las tareas de una lista
  static void alternarSeleccionTodas(
    Set<String> tareasSeleccionadas,
    List<Tarea> tareasActuales,
    VoidCallback onChanged,
  ) {
    final todasSeleccionadas = tareasActuales.every(
      (t) => tareasSeleccionadas.contains(t.id),
    );

    if (todasSeleccionadas) {
      for (final tarea in tareasActuales) {
        tareasSeleccionadas.remove(tarea.id);
      }
    } else {
      for (final tarea in tareasActuales) {
        tareasSeleccionadas.add(tarea.id);
      }
    }
    onChanged();
  }

  // Muestra el diálogo y elimina las tareas seleccionadas
  static void eliminarTareasSeleccionadas(
    BuildContext context,
    ProveedorTareas proveedor,
    Set<String> tareasSeleccionadas,
    VoidCallback onEliminacionCompleta,
  ) {
    if (tareasSeleccionadas.isEmpty) return;

    final cantidad = tareasSeleccionadas.length;

    DialogoConfirmarEliminacion.mostrar(
      context,
      cantidad == 1 ? 'tarea' : '$cantidad tareas',
      () async {
        final ids = tareasSeleccionadas.toList();
        final exito = await proveedor.eliminarTareasMultiples(ids);

        if (context.mounted) {
          if (exito) {
            onEliminacionCompleta();
            AlertaExito.mostrar(
              context,
              cantidad == 1
                  ? Constantes.tareaEliminada
                  : '$cantidad tareas eliminadas',
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error: ${proveedor.mensajeError ?? "No se pudieron eliminar las tareas"}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }
}

