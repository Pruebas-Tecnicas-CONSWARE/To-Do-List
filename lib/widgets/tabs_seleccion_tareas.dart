import 'package:flutter/material.dart';

// Widget modular para los tabs de selección entre pendientes y completadas
class TabsSeleccionTareas extends StatelessWidget {
  final int indiceSeleccionado;
  final Function(int) onTabSeleccionado;

  const TabsSeleccionTareas({
    super.key,
    required this.indiceSeleccionado,
    required this.onTabSeleccionado,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              titulo: 'Tareas pendientes',
              icono: Icons.pending_actions,
              color: Colors.orange,
              indice: 0,
              estaSeleccionado: indiceSeleccionado == 0,
              onTap: () => onTabSeleccionado(0),
            ),
          ),
          Container(
            width: 1,
            height: 30,
            margin: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.grey.withOpacity(0.3),
          ),
          Expanded(
            child: _TabItem(
              titulo: 'Tareas completadas',
              icono: Icons.check_circle,
              color: Colors.green,
              indice: 1,
              estaSeleccionado: indiceSeleccionado == 1,
              onTap: () => onTabSeleccionado(1),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget interno para cada item del tab
class _TabItem extends StatelessWidget {
  final String titulo;
  final IconData icono;
  final Color color;
  final int indice;
  final bool estaSeleccionado;
  final VoidCallback onTap;

  const _TabItem({
    required this.titulo,
    required this.icono,
    required this.color,
    required this.indice,
    required this.estaSeleccionado,
    required this.onTap,
  });

// Construye el widget con el titulo, icono, color, indice, estado seleccionado
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: estaSeleccionado
              ? color.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
              child: Icon(
                icono,
                key: ValueKey('$indice-$estaSeleccionado'),
                color: estaSeleccionado ? color : Colors.grey,
                size: 22,
              ),
            ),

            const SizedBox(width: 6),
            Flexible(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: estaSeleccionado
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: estaSeleccionado ? color : Colors.grey,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

