import 'package:flutter/material.dart';

// widget reutilizable para botones de navegación en el AppBar
class BotonNavegacionAppBar extends StatelessWidget {
  final IconData icono;
  final String texto;
  final Color color;
  final VoidCallback onPressed;

  const BotonNavegacionAppBar({
    super.key,
    required this.icono,
    required this.texto,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icono, color: color),
      label: Text(
        texto,
        style: TextStyle(color: color),
      ),
    );
  }
}

