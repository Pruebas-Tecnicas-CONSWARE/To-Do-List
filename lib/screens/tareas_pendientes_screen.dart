import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tareas_provider.dart';
import '../utils/constantes.dart';
import '../widgets/item_tarea.dart';
import '../widgets/loading_pantalla.dart';
import '../widgets/header_estadisticas.dart';
import '../widgets/estado_error.dart';
import '../widgets/estado_vacio.dart';
import '../widgets/encabezado_seccion.dart';
import '../widgets/boton_navegacion_appbar.dart';
import 'agregar_editar_tarea_screen.dart';
import 'tareas_completadas_screen.dart';

// Pantalla principal que muestra solo las tareas pendientes
class TareasPendientesScreen extends StatelessWidget {
  const TareasPendientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constantes.tituloApp),
        elevation: 0,
        actions: [
          BotonNavegacionAppBar(
            icono: Icons.check_circle,
            texto: 'Tareas Completadas',
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TareasCompletadasScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProveedorTareas>(
        builder: (context, proveedor, child) {
          // Estado de carga
          if (proveedor.estaCargando) {
            return const LoadingPantalla();
          }

          // Estado de error
          if (proveedor.tieneError) {
            return const EstadoError();
          }

          // Filtrar solo tareas pendientes
          final tareasPendientes = proveedor.tareas
              .where((t) => !t.estaCompletada)
              .toList();

          // Estado vacío
          if (tareasPendientes.isEmpty) {
            return const EstadoVacio(
              icono: Icons.pending_actions,
              titulo: 'No hay tareas pendientes',
              descripcion: 'Todas tus tareas están completadas',
              color: Colors.orange,
            );
          }

          // Contenido principal con lista de tareas
          return Column(
            children: [
              const HeaderEstadisticas(),
              EncabezadoSeccion(
                icono: Icons.pending_actions,
                titulo: 'Tareas Pendientes (${tareasPendientes.length})',
                color: Colors.orange,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: tareasPendientes.length,
                  itemBuilder: (context, index) {
                    return ItemTarea(tarea: tareasPendientes[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
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

