import 'package:flutter/material.dart';

// widget para el checkbox de tarea con animación
class CheckboxTarea extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxTarea({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
      child: Checkbox(
        key: ValueKey(value),
        value: value,
        checkColor: Colors.white,
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.green;
          }
          return null;
        }),
        onChanged: onChanged,
      ),
    );
  }
}

