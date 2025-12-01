import 'package:flutter/material.dart';
import '../utils/constantes.dart';

class BotonesFormulario extends StatelessWidget {
  final bool estaGuardando;
  final bool esEdicion;
  final VoidCallback onGuardar;
  final VoidCallback onCancelar;

  const BotonesFormulario({
    super.key,
    required this.estaGuardando,
    required this.esEdicion,
    required this.onGuardar,
    required this.onCancelar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: estaGuardando ? null : onGuardar,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          icon: estaGuardando
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(esEdicion ? Icons.edit : Icons.save),
          label: Text(
            estaGuardando
                ? (esEdicion ? 'Actualizando...' : 'Guardando...')
                : (esEdicion ? 'Actualizar Tarea' : Constantes.guardar),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: estaGuardando ? null : onCancelar,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            side: BorderSide(color: Colors.green.withOpacity(0.5)),
          ),
          child: Text(
            Constantes.cancelar,
            style: TextStyle(color: Colors.green.withOpacity(0.9)),
          ),
        ),
      ],
    );
  }
}

