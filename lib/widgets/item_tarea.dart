import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarea.dart';
import '../providers/tareas_provider.dart';
import 'checkbox_tarea.dart';
import 'subtitle_tarea.dart';
import 'botones_accion_tarea.dart';
import 'animacion_eliminar.dart';
import 'eliminador_tarea.dart';

class ItemTarea extends StatefulWidget {
  final Tarea tarea;
  final bool mostrarEditar;
  final VoidCallback? onCompletada;
  final bool modoSeleccion;
  final bool estaSeleccionada;
  final ValueChanged<bool>? onSeleccionada;

  const ItemTarea({
    super.key,
    required this.tarea,
    this.mostrarEditar = true,
    this.onCompletada,
    this.modoSeleccion = false,
    this.estaSeleccionada = false,
    this.onSeleccionada,
  });

  @override
  State<ItemTarea> createState() => _ItemTareaState();
}

// Estado del widget para el item de la tarea
class _ItemTareaState extends State<ItemTarea> {
  bool? _estadoLocalCheckbox;
  final ValueNotifier<bool> _estaEliminando = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _estadoLocalCheckbox = widget.tarea.estaCompletada;
  }

  @override
  void didUpdateWidget(ItemTarea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tarea.estaCompletada != widget.tarea.estaCompletada) {
      _estadoLocalCheckbox = widget.tarea.estaCompletada;
    }
  }
// Construye el widget con el estado y las fechas
  @override
  void dispose() {
    _estaEliminando.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorTareas>(
      builder: (context, proveedor, child) {
        final mostrarCheckbox = _estadoLocalCheckbox ?? widget.tarea.estaCompletada;
        
        return ValueListenableBuilder<bool>(
          valueListenable: _estaEliminando,
          builder: (context, estaEliminando, child) {
            return AnimacionEliminar(
              estaEliminando: estaEliminando,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                elevation: widget.modoSeleccion && widget.estaSeleccionada ? 4 : 2,
                color: widget.modoSeleccion && widget.estaSeleccionada
                    ? Colors.green.withOpacity(0.1)
                    : null,
                child: ListTile(
                  key: ValueKey(widget.tarea.id),
                  leading: widget.modoSeleccion
                      ? Checkbox(
                          value: widget.estaSeleccionada,
                          onChanged: (valor) {
                            widget.onSeleccionada?.call(valor ?? false);
                          },
                          activeColor: Colors.green,
                        )
                      : CheckboxTarea(
                          value: mostrarCheckbox,
                          onChanged: (valor) async {
                            final nuevaCompletada = valor ?? false;
                            setState(() {
                              _estadoLocalCheckbox = nuevaCompletada;
                            });
                            
                            await proveedor.alternarCompletado(widget.tarea.id, nuevaCompletada);
                            
                            if (nuevaCompletada && widget.onCompletada != null) {
                              Future.delayed(const Duration(milliseconds: 800), () {
                                if (mounted) {
                                  widget.onCompletada?.call();
                                }
                              });
                            }
                          },
                        ),
                  title: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      decoration: mostrarCheckbox
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: mostrarCheckbox
                          ? Colors.grey
                          : Colors.white,
                    ),
                    child: Text(widget.tarea.titulo),
                  ),
                  subtitle: SubtitleTarea(tarea: widget.tarea),
                  trailing: widget.modoSeleccion
                      ? null
                      : BotonesAccionTarea(
                          tarea: widget.tarea,
                          mostrarEditar: widget.mostrarEditar,
                          onEliminar: () => EliminadorTarea.mostrarDialogoEliminar(
                            context,
                            widget.tarea.id,
                            widget.tarea.titulo,
                            _estaEliminando,
                          ),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
