// widget para el campo de texto del formulario de tarea
import 'package:flutter/material.dart';
import '../utils/constantes.dart';

class CampoTextoTarea extends StatelessWidget {
  final TextEditingController controlador;
  final bool habilitado;

  const CampoTextoTarea({
    super.key,
    required this.controlador,
    this.habilitado = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      decoration: InputDecoration(
        labelText: Constantes.nombreTarea,
        hintText: 'Ej: Comprar leche',
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.task),
      ),
      maxLength: Constantes.longitudMaximaTitulo,
      textCapitalization: TextCapitalization.sentences,
      validator: (valor) {
        if (valor == null || valor.trim().isEmpty) {
          return Constantes.tituloVacio;
        }
        if (valor.length > Constantes.longitudMaximaTitulo) {
          return Constantes.tituloMuyLargo;
        }
        return null;
      },
      enabled: habilitado,
      style: const TextStyle(color: Colors.white),
    );
  }
}

