import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../utils/constantes.dart';
import '../screens/agregar_editar_tarea_screen.dart';

class BotonesAccionTarea extends StatelessWidget {
  final Tarea tarea;
  final bool mostrarEditar;
  final VoidCallback onEliminar;

  const BotonesAccionTarea({
    super.key,
    required this.tarea,
    required this.mostrarEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (mostrarEditar)
          IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AgregarEditarTareaScreen(
                    tarea: tarea,
                  ),
                ),
              );
            },
            tooltip: Constantes.editarTarea,
          ),
        IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: onEliminar,
          tooltip: Constantes.eliminar,
        ),
      ],
    );
  }
}

