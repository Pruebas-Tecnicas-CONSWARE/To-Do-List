import 'package:flutter/material.dart';
import '../models/tarea.dart';
import '../utils/constantes.dart';
import '../widgets/formulario_tarea.dart';
import '../widgets/alerta_exito.dart';

class AgregarEditarTareaScreen extends StatelessWidget {
  final Tarea? tarea;

  const AgregarEditarTareaScreen({super.key, this.tarea});

  bool get esEdicion => tarea != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          esEdicion ? Constantes.editarTarea : Constantes.agregarTarea,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormularioTarea(
          tarea: tarea,
          onGuardar: (exito, mensaje) async {
            if (exito) {
              if (context.mounted) {
                await AlertaExito.mostrar(context, mensaje);
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mensaje),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
