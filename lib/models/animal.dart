class Animal {
  int? id;
  String nombre;
  String especie;
  int edad;
  String estadoSalud;

  Animal({this.id, required this.nombre, required this.especie, required this.edad, required this.estadoSalud});

  // Convertir un objeto Animal en un Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'especie': especie,
      'edad': edad,
      'estado_salud': estadoSalud,
    };
  }

  // Convertir un Map en un objeto Animal
  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'],
      nombre: map['nombre'],
      especie: map['especie'],
      edad: map['edad'],
      estadoSalud: map['estado_salud'],
    );
  }
}
