import 'package:flutter/material.dart';

// widget para la animación de eliminación
class AnimacionEliminar extends StatefulWidget {
  final Widget child;
  final bool estaEliminando;

  const AnimacionEliminar({
    super.key,
    required this.child,
    required this.estaEliminando,
  });

  @override
  State<AnimacionEliminar> createState() => _AnimacionEliminarState();
}

class _AnimacionEliminarState extends State<AnimacionEliminar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animacionFade;
  late Animation<double> _animacionSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animacionFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _animacionSlide = Tween<double>(begin: 0.0, end: -100.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(AnimacionEliminar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.estaEliminando && !oldWidget.estaEliminando) {
      _controller.forward();
    } else if (!widget.estaEliminando && oldWidget.estaEliminando) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: widget.estaEliminando ? _animacionFade.value : 1.0,
          child: Transform.translate(
            offset: Offset(0, widget.estaEliminando ? _animacionSlide.value : 0),
            child: Transform.scale(
              scale: widget.estaEliminando
                  ? 0.8 + (_animacionFade.value * 0.2)
                  : 1.0,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

