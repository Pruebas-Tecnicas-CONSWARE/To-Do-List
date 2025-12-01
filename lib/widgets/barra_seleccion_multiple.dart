import 'package:flutter/material.dart';

// Barra de acciones para modo selección múltiple
class BarraSeleccionMultiple extends StatelessWidget {
  final int cantidadSeleccionadas;
  final VoidCallback onEliminar;
  final VoidCallback onCancelar;
  final VoidCallback? onSeleccionarTodas;

  const BarraSeleccionMultiple({
    super.key,
    required this.cantidadSeleccionadas,
    required this.onEliminar,
    required this.onCancelar,
    this.onSeleccionarTodas,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.green.withOpacity(0.3),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            '$cantidadSeleccionadas seleccionada${cantidadSeleccionadas != 1 ? 's' : ''}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          if (onSeleccionarTodas != null)
            IconButton(
              icon: const Icon(Icons.select_all, color: Colors.green),
              onPressed: onSeleccionarTodas,
              tooltip: 'Seleccionar todas',
            ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: cantidadSeleccionadas > 0 ? onEliminar : null,
            tooltip: 'Eliminar seleccionadas',
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: onCancelar,
            tooltip: 'Cancelar',
          ),
        ],
      ),
    );
  }
}

