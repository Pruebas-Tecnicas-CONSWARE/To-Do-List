// Test básico para la aplicación To-Do List
//
// Este test verifica que la aplicación se inicia correctamente
// y muestra la pantalla principal.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:to_do_list/main.dart';
import 'package:to_do_list/providers/proveedor_tareas.dart';
import 'package:to_do_list/screens/lista_tareas_screen.dart';

void main() {
  testWidgets('La aplicación se inicia correctamente', (WidgetTester tester) async {
    // Construye la aplicación y dispara un frame
    await tester.pumpWidget(const MiAplicacion());

    // Verifica que la pantalla principal se muestra
    expect(find.byType(ListaTareasScreen), findsOneWidget);
    
    // Verifica que el título de la app está presente
    expect(find.text('Lista de Tareas'), findsOneWidget);
  });
}
