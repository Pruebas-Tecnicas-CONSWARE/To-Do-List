import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';

// widget para mostrar estado de error con opción de reintentar
class EstadoError extends StatelessWidget {
  const EstadoError({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProveedorTareas>(
      builder: (context, proveedor, child) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                proveedor.mensajeError ?? Constantes.errorDesconocido,
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  proveedor.limpiarError();
                  proveedor.cargarTareas();
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

