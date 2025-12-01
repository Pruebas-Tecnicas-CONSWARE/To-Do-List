import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';
import 'estadistica_tarea.dart';

// Widget reutilizable para mostrar estadísticas de tareas
class HeaderEstadisticas extends StatelessWidget {
  const HeaderEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorTareas>(
      builder: (context, proveedor, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: const Color(0xFF1E1E1E),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              EstadisticaTarea(
                etiqueta: Constantes.totalTareas,
                valor: proveedor.tareas.length.toString(),
                icono: Icons.list_alt,
              ),
              EstadisticaTarea(
                etiqueta: Constantes.tareasPendientes,
                valor: proveedor.numeroTareasPendientes.toString(),
                icono: Icons.pending_actions,
                color: Colors.orange,
              ),
              EstadisticaTarea(
                etiqueta: Constantes.tareasCompletadas,
                valor: proveedor.numeroTareasCompletadas.toString(),
                icono: Icons.check_circle,
                color: Colors.green,
              ),
            ],
          ),
        );
      },
    );
  }
}

