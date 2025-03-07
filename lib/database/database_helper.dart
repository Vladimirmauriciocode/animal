import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/animal.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'animals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE animals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            especie TEXT,
            edad INTEGER,
            estado_salud TEXT
          )
        ''');
      },
    );
  }

  // Insertar un animal en la base de datos
  Future<int> insertAnimal(Animal animal) async {
    final db = await database;
    return await db.insert('animals', animal.toMap());
  }

  // Obtener todos los animales
  Future<List<Animal>> getAnimals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('animals');
    return List.generate(maps.length, (i) {
      return Animal.fromMap(maps[i]);
    });
  }

  // Actualizar un animal
  Future<int> updateAnimal(Animal animal) async {
    final db = await database;
    return await db.update(
      'animals',
      animal.toMap(),
      where: 'id = ?',
      whereArgs: [animal.id],
    );
  }

  // Eliminar un animal
  Future<int> deleteAnimal(int id) async {
    final db = await database;
    return await db.delete(
      'animals',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}