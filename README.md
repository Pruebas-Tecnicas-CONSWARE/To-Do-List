# Lista de Tareas (To-Do List)

Aplicación móvil en Flutter para gestionar tareas personales.

## Características

-  CRUD completo (Crear, Leer, Actualizar, Eliminar)
-  Persistencia local con Hive
-  Gestión de estado con Provider
-  Interfaz moderna con animaciones
-  Estadísticas en tiempo real
-  Selección múltiple y eliminación en lote

## Instalación

1. **Instalar dependencias:**
   ```bash
   flutter pub get
   ```

2. **Generar adaptadores de Hive (OBLIGATORIO):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Ejecutar la aplicación:**
   ```bash
   flutter run
   ```

## Uso

- **Agregar tarea:** Botón verde "+" → Escribir título → Guardar
- **Completar tarea:** Presionar checkbox a la izquierda
- **Editar tarea:** Icono de lápiz verde → Modificar → Guardar
- **Eliminar tarea:** Icono de basura rojo → Confirmar
- **Selección múltiple:** Botón de checklist en AppBar → Seleccionar → Eliminar

## Arquitectura

- **MVVM** con Provider
- **Model:** `models/tarea.dart`
- **View:** `screens/`
- **ViewModel:** `providers/tareas_provider.dart`
- **Service:** `services/tareas_services.dart`

## Tecnologías

- Flutter 3.0+
- Provider (gestión de estado)
- Hive (persistencia local)

## Estructura

```
lib/
├── main.dart
├── models/          # Modelos de datos
├── providers/       # Gestión de estado
├── screens/         # Pantallas
├── services/        # Persistencia
├── widgets/         # Componentes reutilizables
└── utils/           # Utilidades y constantes
```

---

**Versión:** 1.0.0
