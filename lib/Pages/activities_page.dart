import 'package:application_laboratorio3/entity/actividad.dart';
import 'package:flutter/material.dart';
import '../entity/actividad.dart';
import '../services/data_base.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Actividad> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  Future<void> _addOrEditActivity({Actividad? activity}) async {
    final isEditing = activity != null;
    final TextEditingController nameController = TextEditingController(text: activity?.nombre ?? '');

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar Actividad' : 'Nueva Actividad'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nombre de la actividad'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) return;
                Navigator.pop(context, true);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      final now = DateTime.now();
      final fechaStr = now.toIso8601String();

      if (isEditing) {
        // Actualizar actividad
        final updatedActivity = Actividad(
          id: activity!.id,
          fecha: fechaStr,
          nombre: nameController.text.trim(),
        );
        await _dbHelper.insertActivity(updatedActivity);
      } else {
        // Insertar nueva actividad
        final newActivity = Actividad(
          id: null,
          fecha: fechaStr,
          nombre: nameController.text.trim(),
        );
        await _dbHelper.insertActivity(newActivity);
      }

      await _loadActivities();
    }
  }

  Future<void> _deleteActivity(Actividad activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Actividad'),
          content: Text('¿Estas seguro que quieres eliminar "${activity.nombre}"?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
            ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
          ],
        );
      },
    );

    if (confirmed == true) {
      final db = await _dbHelper.database;
      await db.delete('activities', where: 'id = ?', whereArgs: [activity.id]);
      await _loadActivities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actividades'),
      ),
      body: _activities.isEmpty
          ? const Center(child: Text('No hay actividades registradas'))
          : ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ListTile(
                  title: Text(activity.nombre),
                  subtitle: Text('Fecha: ${activity.fecha}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _addOrEditActivity(activity: activity),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteActivity(activity),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditActivity(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
