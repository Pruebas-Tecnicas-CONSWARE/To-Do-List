// Widget modularizado para el formulario de agregar/editar tarea
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/tarea.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';
import 'campo_texto_tarea.dart';
import 'botones_formulario.dart';
import 'mensaje_error_formulario.dart';

class FormularioTarea extends StatefulWidget {
  final Tarea? tarea;
  final Function(bool exito, String mensaje) onGuardar;

  const FormularioTarea({
    super.key,
    this.tarea,
    required this.onGuardar,
  });

  bool get esEdicion => tarea != null;

  @override
  State<FormularioTarea> createState() => _FormularioTareaState();
}

class _FormularioTareaState extends State<FormularioTarea> {
  final _formKey = GlobalKey<FormState>();
  final _controladorTitulo = TextEditingController();
  bool _estaGuardando = false;

  @override
  void initState() {
    super.initState();
    if (widget.esEdicion) {
      _controladorTitulo.text = widget.tarea!.titulo;
    }
  }

  @override
  void dispose() {
    _controladorTitulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          CampoTextoTarea(
            controlador: _controladorTitulo,
            habilitado: !_estaGuardando,
          ),
          const SizedBox(height: 24),
          BotonesFormulario(
            estaGuardando: _estaGuardando,
            esEdicion: widget.esEdicion,
            onGuardar: () => _guardarTarea(context),
            onCancelar: () => Navigator.pop(context),
          ),
          const MensajeErrorFormulario(),
        ],
      ),
    );
  }

  // Guarda la tarea en la base de datos
  Future<void> _guardarTarea(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _estaGuardando = true;
    });

    try {
      final proveedor = Provider.of<ProveedorTareas>(context, listen: false);
      bool exito;
      String mensaje;

      if (widget.esEdicion) {
        final tareaActualizada = widget.tarea!.copiarCon(
          titulo: _controladorTitulo.text.trim(),
        );
        exito = await proveedor.actualizarTarea(tareaActualizada);
        mensaje = exito
            ? Constantes.tareaActualizada
            : proveedor.mensajeError ?? Constantes.errorActualizarTarea;
      } else {
        exito = await proveedor.agregarTarea(_controladorTitulo.text.trim());
        mensaje = exito
            ? Constantes.tareaAgregada
            : proveedor.mensajeError ?? Constantes.errorGuardarTarea;
      }

      if (context.mounted) {
        widget.onGuardar(exito, mensaje);
      }
    } catch (e) {
      if (context.mounted) {
        widget.onGuardar(false, 'Error: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() {
          _estaGuardando = false;
        });
      }
    }
  }
}
