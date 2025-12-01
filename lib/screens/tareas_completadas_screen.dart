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
import 'tareas_pendientes_screen.dart';

// Pantalla que muestra solo las tareas completadas
class TareasCompletadasScreen extends StatelessWidget {
  const TareasCompletadasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constantes.tituloApp),
        elevation: 0,
        actions: [
          BotonNavegacionAppBar(
            icono: Icons.pending_actions,
            texto: 'Tareas Pendientes',
            color: Colors.orange,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const TareasPendientesScreen(),
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

          // Filtrar solo tareas completadas
          final tareasCompletadas = proveedor.tareas
              .where((t) => t.estaCompletada)
              .toList();

          // Estado vacío
          if (tareasCompletadas.isEmpty) {
            return const EstadoVacio(
              icono: Icons.check_circle_outline,
              titulo: 'No hay tareas completadas',
              descripcion: 'Completa algunas tareas para verlas aquí',
              color: Colors.green,
            );
          }

          // Contenido principal con lista de tareas
          return Column(
            children: [
              const HeaderEstadisticas(),
              EncabezadoSeccion(
                icono: Icons.check_circle,
                titulo: 'Tareas Completadas (${tareasCompletadas.length})',
                color: Colors.green,
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: tareasCompletadas.length,
                  itemBuilder: (context, index) {
                    return ItemTarea(tarea: tareasCompletadas[index]);
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

