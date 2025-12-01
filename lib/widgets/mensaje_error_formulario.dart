
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';

// widget para mostrar mensajes de error en el formulario
class MensajeErrorFormulario extends StatelessWidget {
  const MensajeErrorFormulario({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorTareas>(
      builder: (context, proveedor, child) {
        if (proveedor.tieneError) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.5)),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red[300]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      proveedor.mensajeError ?? Constantes.errorDesconocido,
                      style: TextStyle(color: Colors.red[300]),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

