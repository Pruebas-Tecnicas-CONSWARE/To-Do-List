import 'package:flutter/material.dart';

// widget para el encabezado de sección de tareas
class EncabezadoSeccion extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final Color color;

  const EncabezadoSeccion({
    super.key,
    required this.icono,
    required this.titulo,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icono, color: color),
          const SizedBox(width: 8),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

