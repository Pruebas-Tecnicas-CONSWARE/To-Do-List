import 'package:flutter/material.dart';
import '../utils/constantes.dart';

// widget para el AppBar de la lista de tareas
class AppBarListaTareas extends StatelessWidget implements PreferredSizeWidget {
  final bool modoSeleccion;
  final VoidCallback? onActivarSeleccion;

  const AppBarListaTareas({
    super.key,
    required this.modoSeleccion,
    this.onActivarSeleccion,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(modoSeleccion ? 'Seleccionar tareas' : Constantes.tituloApp),
      elevation: 0,
      actions: [
        if (!modoSeleccion && onActivarSeleccion != null)
          IconButton(
            icon: const Icon(Icons.checklist),
            onPressed: onActivarSeleccion,
            tooltip: 'Seleccionar múltiples tareas',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

