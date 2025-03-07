import 'package:flutter/material.dart';
import 'package:zoo_app/database/database_helper.dart';
import 'package:zoo_app/models/animal.dart';

class AnimalFormScreen extends StatefulWidget {
  final Animal? animal;

  AnimalFormScreen({this.animal});

  @override
  _AnimalFormScreenState createState() => _AnimalFormScreenState();
}

class _AnimalFormScreenState extends State<AnimalFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController especieController = TextEditingController();
  TextEditingController edadController = TextEditingController();
  TextEditingController estadoSaludController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.animal != null) {
      nombreController.text = widget.animal!.nombre;
      especieController.text = widget.animal!.especie;
      edadController.text = widget.animal!.edad.toString();
      estadoSaludController.text = widget.animal!.estadoSalud;
    }
  }

  void _saveAnimal() async {
    if (_formKey.currentState!.validate()) {
      final animal = Animal(
        id: widget.animal?.id,
        nombre: nombreController.text,
        especie: especieController.text,
        edad: int.parse(edadController.text),
        estadoSalud: estadoSaludController.text,
      );

      if (widget.animal == null) {
        await DatabaseHelper.instance.insertAnimal(animal);
      } else {
        await DatabaseHelper.instance.updateAnimal(animal);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.animal == null ? 'Agregar Animal' : 'Editar Animal')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: nombreController, decoration: InputDecoration(labelText: 'Nombre')),
              TextFormField(controller: especieController, decoration: InputDecoration(labelText: 'Especie')),
              TextFormField(controller: edadController, decoration: InputDecoration(labelText: 'Edad'), keyboardType: TextInputType.number),
              TextFormField(controller: estadoSaludController, decoration: InputDecoration(labelText: 'Estado de Salud')),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveAnimal, child: Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}