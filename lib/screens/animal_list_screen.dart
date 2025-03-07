import 'package:flutter/material.dart';
import 'package:zoo_app/database/database_helper.dart';
import 'package:zoo_app/models/animal.dart';
import 'package:zoo_app/screens/animal_form_screen.dart';

class AnimalListScreen extends StatefulWidget {
  @override
  _AnimalListScreenState createState() => _AnimalListScreenState();
}

class _AnimalListScreenState extends State<AnimalListScreen> {
  List<Animal> animals = [];

  @override
  void initState() {
    super.initState();
    _loadAnimals();
  }

  void _loadAnimals() async {
    final data = await DatabaseHelper.instance.getAnimals();
    setState(() {
      animals = data;
    });
  }

  void _deleteAnimal(int id) async {
    await DatabaseHelper.instance.deleteAnimal(id);
    _loadAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Animales')),
      body: animals.isEmpty
          ? Center(child: Text('No hay animales registrados.'))
          : ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return ListTile(
                  title: Text(animal.nombre),
                  subtitle: Text('Especie: ${animal.especie} | Edad: ${animal.edad} años'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AnimalFormScreen(animal: animal),
                            ),
                          ).then((_) => _loadAnimals());
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAnimal(animal.id!),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnimalFormScreen(),
            ),
          ).then((_) => _loadAnimals());
        },
      ),
    );
  }
}
