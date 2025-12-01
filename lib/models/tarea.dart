import 'package:hive/hive.dart';

part 'tarea.g.dart';

@HiveType(typeId: 0)
class Tarea extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String titulo;

  @HiveField(2)
  bool estaCompletada;

  @HiveField(3)
  final DateTime fechaCreacion;

  @HiveField(4)
  DateTime fechaModificacion;

  Tarea({
    String? id,
    required this.titulo,
    this.estaCompletada = false,
    DateTime? fechaCreacion,
    DateTime? fechaModificacion,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        fechaCreacion = fechaCreacion ?? DateTime.now(),
        fechaModificacion = fechaModificacion ?? DateTime.now();

  // Crea una copia de la tarea con los campos modificados
  Tarea copiarCon({
    String? titulo,
    bool? estaCompletada,
  }) {
    return Tarea(
      id: id,
      titulo: titulo ?? this.titulo,
      estaCompletada: estaCompletada ?? this.estaCompletada,
      fechaCreacion: fechaCreacion,
      fechaModificacion: DateTime.now(),
    );
  }

  // Mapeamos la tarea a un formato json 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'estaCompletada': estaCompletada,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaModificacion': fechaModificacion.toIso8601String(),
    };
  }

  // Crea una tarea desde un mapa
  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      id: map['id'] as String,
      titulo: map['titulo'] as String,
      estaCompletada: map['estaCompletada'] as bool? ?? false,
      fechaCreacion: DateTime.parse(map['fechaCreacion'] as String),
      fechaModificacion: DateTime.parse(map['fechaModificacion'] as String),
    );
  }

  @override
  String toString() {
    return 'Tarea(id: $id, titulo: $titulo, estaCompletada: $estaCompletada)';
  }
}
