import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarea.dart';
import '../providers/tareas_provider.dart';
import 'header_estadisticas.dart';
import 'tabs_seleccion_tareas.dart';
import 'contenido_lista_tareas.dart';
import 'barra_seleccion_multiple.dart';

// widget para el cuerpo de la lista de tareas
class CuerpoListaTareas extends StatelessWidget {
  final int indiceSeleccionado;
  final bool modoSeleccion;
  final Set<String> tareasSeleccionadas;
  final Function(int) onTabSeleccionado;
  final VoidCallback onCancelarSeleccion;
  final VoidCallback onEliminarSeleccionadas;
  final Function(List<Tarea>) onSeleccionarTodas;
  final ValueChanged<String> onTareaSeleccionada;
  final VoidCallback? onCompletada;

  const CuerpoListaTareas({
    super.key,
    required this.indiceSeleccionado,
    required this.modoSeleccion,
    required this.tareasSeleccionadas,
    required this.onTabSeleccionado,
    required this.onCancelarSeleccion,
    required this.onEliminarSeleccionadas,
    required this.onSeleccionarTodas,
    required this.onTareaSeleccionada,
    this.onCompletada,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorTareas>(
      builder: (context, proveedor, child) {
        final tareasFiltradas = indiceSeleccionado == 0
            ? proveedor.tareas.where((t) => !t.estaCompletada).toList()
            : proveedor.tareas.where((t) => t.estaCompletada).toList();

        final todasLasTareas = proveedor.tareas;
        final tareasPendientes = todasLasTareas.where((t) => !t.estaCompletada).toList();
        final tareasCompletadas = todasLasTareas.where((t) => t.estaCompletada).toList();

        return Column(
          children: [
            if (!modoSeleccion) const HeaderEstadisticas(),
            TabsSeleccionTareas(
              indiceSeleccionado: indiceSeleccionado,
              onTabSeleccionado: onTabSeleccionado,
            ),
            if (modoSeleccion)
              BarraSeleccionMultiple(
                cantidadSeleccionadas: tareasSeleccionadas.length,
                onEliminar: onEliminarSeleccionadas,
                onCancelar: onCancelarSeleccion,
                onSeleccionarTodas: () {
                  final tareasActuales = indiceSeleccionado == 0
                      ? tareasPendientes
                      : tareasCompletadas;
                  onSeleccionarTodas(tareasActuales);
                },
              ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
                    ),
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.15, 0),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    ),
                  );
                },
                child: ContenidoListaTareas(
                  key: ValueKey<int>(indiceSeleccionado),
                  tareas: tareasFiltradas,
                  indiceSeleccionado: indiceSeleccionado,
                  mostrarEditar: indiceSeleccionado == 0,
                  modoSeleccion: modoSeleccion,
                  tareasSeleccionadas: tareasSeleccionadas,
                  onTareaSeleccionada: onTareaSeleccionada,
                  onCompletada: onCompletada,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

