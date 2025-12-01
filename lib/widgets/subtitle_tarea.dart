import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../utils/constantes.dart';
import '../utils/formateador_fechas.dart';

// Widget para el subtitle de la tarea con estado y fechas
class SubtitleTarea extends StatelessWidget {
  final Tarea tarea;

  const SubtitleTarea({
    super.key,
    required this.tarea,
  });

// Construye el widget con el estado y las fechas
  @override
  Widget build(BuildContext context) {
    final fechaTexto = FormateadorFechas.formatearFechasTarea(tarea);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: tarea.estaCompletada ? Colors.green : Colors.orange,
            fontSize: 12,
          ),
          child: Text(
            tarea.estaCompletada
                ? Constantes.completada
                : Constantes.pendiente,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fechaTexto,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

