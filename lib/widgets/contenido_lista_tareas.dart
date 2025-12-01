import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../widgets/item_tarea.dart';
import '../widgets/estado_vacio.dart';

// widget para el contenido de la lista de tareas
class ContenidoListaTareas extends StatelessWidget {
  final List<Tarea> tareas;
  final int indiceSeleccionado;
  final bool mostrarEditar;
  final VoidCallback? onCompletada;
  final bool modoSeleccion;
  final Set<String> tareasSeleccionadas;
  final ValueChanged<String>? onTareaSeleccionada;

  const ContenidoListaTareas({
    super.key,
    required this.tareas,
    required this.indiceSeleccionado,
    required this.mostrarEditar,
    this.onCompletada,
    this.modoSeleccion = false,
    this.tareasSeleccionadas = const {},
    this.onTareaSeleccionada,
  });

  @override
  Widget build(BuildContext context) {
    if (tareas.isEmpty) {
      return _buildEstadoVacio();
    }

    return ListView.builder(
      key: ValueKey('lista_${tareas.length}'),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: tareas.length,
      itemBuilder: (context, index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 50)),
            curve: Curves.easeOut,
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 30 * (1 - value)),
                  child: Transform.scale(
                    scale: 0.9 + (value * 0.1),
                    child: child,
                  ),
                ),
              );
            },
            child: ItemTarea(
              key: ValueKey(tareas[index].id),
              tarea: tareas[index],
              mostrarEditar: mostrarEditar,
              onCompletada: onCompletada,
              modoSeleccion: modoSeleccion,
              estaSeleccionada: tareasSeleccionadas.contains(tareas[index].id),
              onSeleccionada: (seleccionada) {
                onTareaSeleccionada?.call(tareas[index].id);
              },
            ),
          ),
        );
      },
    );
  }

  // Construye el widget con el estado vacío
  Widget _buildEstadoVacio() {
    if (indiceSeleccionado == 0) {
      return const EstadoVacio(
        icono: Icons.pending_actions,
        titulo: 'No hay tareas pendientes',
        descripcion: 'Todas tus tareas están completadas',
        color: Colors.orange,
      );
    } else {
      return const EstadoVacio(
        icono: Icons.check_circle_outline,
        titulo: 'No hay tareas completadas',
        descripcion: 'Completa algunas tareas para verlas aquí',
        color: Colors.green,
      );
    }
  }
}

