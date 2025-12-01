import 'package:flutter/material.dart';
import '../utils/constantes.dart';

// Widget modular para el diálogo de confirmación de eliminación
class DialogoConfirmarEliminacion extends StatelessWidget {
  final String tituloTarea;
  final VoidCallback onConfirmar;

  const DialogoConfirmarEliminacion({
    super.key,
    required this.tituloTarea,
    required this.onConfirmar,
  });

  static Future<void> mostrar(
    BuildContext context,
    String tituloTarea,
    VoidCallback onConfirmar,
  ) {
    return showDialog(
      context: context,
      builder: (context) => DialogoConfirmarEliminacion(
        tituloTarea: tituloTarea,
        onConfirmar: onConfirmar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1E1E),
      title: const Text(
        'Confirmar eliminación',
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        '¿Estás seguro de que deseas eliminar la tarea "$tituloTarea"?',
        style: const TextStyle(color: Colors.white70),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            Constantes.cancelar,
            style: TextStyle(color: Colors.green.withOpacity(0.9)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirmar();
          },
          child: const Text(
            Constantes.eliminar,
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}

