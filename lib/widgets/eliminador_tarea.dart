import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';
import 'alerta_exito.dart';
import 'dialogo_confirmar_eliminacion.dart';

class EliminadorTarea {
  // Muestra el diálogo de confirmación y maneja la eliminación completa
  static Future<void> mostrarDialogoEliminar(
    BuildContext context,
    String idTarea,
    String tituloTarea,
    ValueNotifier<bool>? estadoEliminando,
  ) async {
    final proveedor = Provider.of<ProveedorTareas>(context, listen: false);
    
    DialogoConfirmarEliminacion.mostrar(
      context,
      tituloTarea,
      () async {
        if (estadoEliminando != null) {
          estadoEliminando.value = true;
        }
        
        await Future.delayed(const Duration(milliseconds: 600));
        
        if (!context.mounted) return;
        
        final exito = await proveedor.eliminarTarea(idTarea);
        
        if (!context.mounted) return;
        
        if (exito) {
          AlertaExito.mostrar(context, Constantes.tareaEliminada);
        } else {
          if (estadoEliminando != null) {
            estadoEliminando.value = false;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error: ${proveedor.mensajeError ?? Constantes.errorEliminarTarea}',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}

