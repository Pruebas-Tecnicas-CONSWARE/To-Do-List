// widget que muestra una estadística de tareas
import 'package:flutter/material.dart';

class EstadisticaTarea extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final IconData icono;
  final Color? color;

  const EstadisticaTarea({
    super.key,
    required this.etiqueta,
    required this.valor,
    required this.icono,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icono, color: color ?? Colors.green),
        const SizedBox(height: 4),
        Text(
          valor,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.green,
          ),
        ),
        Text(
          etiqueta,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
