import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';
import '../widgets/loading_pantalla.dart';
import '../widgets/estado_error.dart';
import '../widgets/app_bar_lista_tareas.dart';
import '../widgets/cuerpo_lista_tareas.dart';
import '../widgets/gestor_seleccion_tareas.dart';
import 'agregar_editar_tarea_screen.dart';

// Pantalla principal con tabs para cambiar entre tareas pendientes y tareas completadas
class ListaTareasScreen extends StatefulWidget {
  const ListaTareasScreen({super.key});

  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  int _indiceSeleccionado = 0; // 0 = Pendientes, 1 = Completadas
  bool _modoSeleccion = false;
  final Set<String> _tareasSeleccionadas = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarListaTareas(
        modoSeleccion: _modoSeleccion,
        onActivarSeleccion: () {
          setState(() {
            _modoSeleccion = true;
            _tareasSeleccionadas.clear();
          });
        },
      ),
      body: Consumer<ProveedorTareas>(
        builder: (context, proveedor, child) {
          if (proveedor.estaCargando) {
            return const LoadingPantalla();
          }

          if (proveedor.tieneError) {
            return const EstadoError();
          }

          return CuerpoListaTareas(
            indiceSeleccionado: _indiceSeleccionado,
            modoSeleccion: _modoSeleccion,
            tareasSeleccionadas: _tareasSeleccionadas,
            onTabSeleccionado: (indice) {
              if (_indiceSeleccionado != indice) {
                setState(() {
                  _indiceSeleccionado = indice;
                });
              }
            },
            onCancelarSeleccion: () {
              setState(() {
                _modoSeleccion = false;
                _tareasSeleccionadas.clear();
              });
            },
            onEliminarSeleccionadas: () {
              GestorSeleccionTareas.eliminarTareasSeleccionadas(
                context,
                proveedor,
                _tareasSeleccionadas,
                () {
                  setState(() {
                    _modoSeleccion = false;
                    _tareasSeleccionadas.clear();
                  });
                },
              );
            },
            onSeleccionarTodas: (tareasActuales) {
              setState(() {
                GestorSeleccionTareas.alternarSeleccionTodas(
                  _tareasSeleccionadas,
                  tareasActuales,
                  () {},
                );
              });
            },
            onTareaSeleccionada: (id) {
              setState(() {
                GestorSeleccionTareas.alternarSeleccion(
                  _tareasSeleccionadas,
                  id,
                  () {},
                );
              });
            },
            onCompletada: () {
              if (mounted) {
                setState(() {
                  _indiceSeleccionado = 1;
                });
              }
            },
          );
        },
      ),
      floatingActionButton: _modoSeleccion
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AgregarEditarTareaScreen(),
                  ),
                );
              },
              tooltip: Constantes.agregarTarea,
              backgroundColor: Colors.green,
              child: const Icon(Icons.add, color: Colors.white),
            ),
    );
  }
}
